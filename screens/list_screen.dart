import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../post_list.dart';
import '../widgets/loading_indefinite.dart';
import 'new_post_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({ Key? key }) : super(key: key);
  static const String routeName = '/';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  
  int total = 0;

  void updateTotal(num val)
    => setState(()
      => total = val.toInt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: postListAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_photo_alternate),
        onPressed: () => Navigator.pushNamed(context, NewPost.routeName)
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.length == 0)
            return LoadingIndefinite(title: 'Loading...');
          return PostList(docs: snapshot.data!.docs, updateTotal: updateTotal);
        }
      )
    );
  }

  // Tailing shows total wasted items, nothing if none.
  // Transitions by sliding in from right with AnimatedPosition
  PreferredSizeWidget? postListAppBar(BuildContext context) {
    return AppBar(
      title: Text('Wasteagram'),
      centerTitle: true,
      actions: [
        Container(
          width: MediaQuery.of(context).size.width/3.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                right: (total == 0) ? -90 : 15,
                curve: Curves.easeInOutQuint,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Text(total.toString(), style: TextStyle(fontSize: 20, color: Colors.grey)),
                    Text('wasted items', style: TextStyle(color: Colors.grey))
                  ]
                ),
              )
            ]
          ),
        )
      ]
    );
  }
}