import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DocumentDTO {
  const DocumentDTO({
    required this.date,
    required this.quantity,
    required this.imageURL,
    required this.location
  });

  final Timestamp date;
  final int quantity;
  final String imageURL;
  final GeoPoint location;
}