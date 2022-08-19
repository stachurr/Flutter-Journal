import 'package:flutter/material.dart';
import 'dart:async';
import 'cloud_clipper.dart';

class UploadingCloud extends StatefulWidget {
  const UploadingCloud({ Key? key }) : super(key: key);

  @override
  _UploadingCloudState createState() => _UploadingCloudState();
}

class _UploadingCloudState extends State<UploadingCloud> {
  static const double iconSize = 40;
  static const double positionStart = -iconSize;
  static const double positionEnd = iconSize * 2;
  static const double increment = (positionEnd - positionStart) / 60;
  double position = positionStart;

  void updatePosition(Timer t) async
    => setState(()
      => position = (position >= positionEnd) ? positionStart : position + increment);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 16), updatePosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconSize * 2,
              height: iconSize * 1.6,
              child: ClipPath(
                clipper: const CloudClipper(),
                child: Container(
                  color: Theme.of(context).accentColor,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [Positioned(
                      child: const Icon(Icons.arrow_upward_rounded, size: iconSize, color: Colors.black,),
                      bottom: position
                    )]
                  ),
                )
              ),
            ),
            SizedBox(height: 20),
            Text('Uploading...')
          ],
        ),
      )
    );
  }
}