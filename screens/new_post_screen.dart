import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../widgets/loading_indefinite.dart';
import '../widgets/uploading_cloud.dart';

class NewPost extends StatefulWidget {
  const NewPost({ Key? key }) : super(key: key);
  static const String routeName = 'NewPost';
  static const String help = 'Upload the post.';

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  static final formKey = GlobalKey<FormState>();
  static final picker = ImagePicker();
  static final locationService = Location();
  LocationData? locationData;
  int? quantity;
  File? image;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  // Have user select image from gallery. If they back out, pop screen.
  void getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) { if (this.mounted) { Navigator.pop(context); } }
    else {
      image = File(pickedFile.path);
      setState(() {});
    }
  }

  // Get location
  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();

    // Only set state if 'this' still in widget tree.
    // It's possible for the user to allow location services, then back out of
    // selecting an image, causing this to be called after navigator popped
    if (this.mounted) setState(() {});
  }

  // If form validation OK, upload image to FirebaseStorage, get link,
  // upload document to FirebaseFirestore, return to home
  void savePost(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final DateTime time = DateTime.now();
      final String fileName = 'Wasteagram_' + time.toString();

      setState(() { uploading = true; });

      // Upload image and get link
      final Reference ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(image!);
      final String url = await ref.getDownloadURL();

      // Create and upload document
      FirebaseFirestore.instance.collection('posts').add({
        'date': Timestamp.fromDate(time),
        'quantity': quantity,
        'imageURL' : url,
        'location': GeoPoint(locationData!.latitude!.toDouble(), locationData!.longitude!.toDouble())
      });

      Navigator.pop(context);
    }
  }

  // Make sure the entered value is a positive integer
  String? ensureInt(String? value) {
    if (value!.isEmpty) return 'Please enter a quantity.';  // If field is empty
    else if (num.tryParse(value) == null) return 'Please enter a valid number.';  // If not a number
    else if (int.tryParse(value) == null) return 'The number must be a whole number.';  // If not an integer
    else if (int.parse(value) < 1) return 'The number must be positive.'; // If non-positive integer
    return null;  // No issues, good to use
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Post'), centerTitle: true),
        body: newPost(context)
    );
  }

  Widget newPost(BuildContext context) {
    if (image == null) {
      getImage(context);
      return LoadingIndefinite(title: 'Loading...');
    }
    else if (uploading) return UploadingCloud();
    else return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              Image.file(image!),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      focusColor: Color(0xff58fed4),
                      labelText: 'Number of wasted items',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Enter the number of wasted items',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff58fed4)))
                    ),
                    onSaved: (value) => quantity = int.parse(value!),
                    validator: (value) => ensureInt(value)
                  )
                )
              )
            ]
          )
        ),
        Semantics(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xFF58fed4)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.cloud_upload, size: 60, color: Color(0xff303030))
            ),
            onPressed: () => savePost(context)
          ),
          button: true,
          enabled: true,
          label: NewPost.help,
          onTapHint: NewPost.help,
          onLongPressHint: NewPost.help
        )
      ]
    );
  }
}