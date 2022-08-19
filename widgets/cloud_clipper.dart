// Used [https://fluttershapemaker.com/] to generate path_0
import 'package:flutter/material.dart';

class CloudClipper extends CustomClipper<Path> {
  const CloudClipper();
  
  @override
  Path getClip(Size size) {
            
    Path path_0 = Path();
    path_0.moveTo(size.width*0.8400000,size.height*0.4425781);
    path_0.cubicTo(size.width*0.8464063,size.height*0.4216797,size.width*0.8500000,size.height*0.3988281,size.width*0.8500000,size.height*0.3750000);
    path_0.cubicTo(size.width*0.8500000,size.height*0.2714844,size.width*0.7828125,size.height*0.1875000,size.width*0.7000000,size.height*0.1875000);
    path_0.cubicTo(size.width*0.6692187,size.height*0.1875000,size.width*0.6404687,size.height*0.1992188,size.width*0.6167187,size.height*0.2191406);
    path_0.cubicTo(size.width*0.5734375,size.height*0.1253906,size.width*0.4926563,size.height*0.06250000,size.width*0.4000000,size.height*0.06250000);
    path_0.cubicTo(size.width*0.2618750,size.height*0.06250000,size.width*0.1500000,size.height*0.2023437,size.width*0.1500000,size.height*0.3750000);
    path_0.cubicTo(size.width*0.1500000,size.height*0.3802734,size.width*0.1501562,size.height*0.3855469,size.width*0.1503125,size.height*0.3908203);
    path_0.cubicTo(size.width*0.06281250,size.height*0.4292969,0,size.height*0.5335937,0,size.height*0.6562500);
    path_0.cubicTo(0,size.height*0.8115234,size.width*0.1007813,size.height*0.9375000,size.width*0.2250000,size.height*0.9375000);
    path_0.lineTo(size.width*0.8000000,size.height*0.9375000);
    path_0.cubicTo(size.width*0.9104688,size.height*0.9375000,size.width,size.height*0.8255859,size.width,size.height*0.6875000);
    path_0.cubicTo(size.width,size.height*0.5666016,size.width*0.9312500,size.height*0.4656250,size.width*0.8400000,size.height*0.4425781);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}