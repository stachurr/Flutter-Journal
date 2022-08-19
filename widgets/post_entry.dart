import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/details_screen.dart';
import '../models/documentDTO.dart';

@immutable
class PostEntry extends StatelessWidget {
  const PostEntry({ Key? key, required this.documentDTO }) : super(key: key);
  static const String help = 'View this post in detail.';
  final DocumentDTO documentDTO;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: ListTile(
        title: Text(DateFormat.yMMMMEEEEd().format(documentDTO.date.toDate())),
        trailing: Text(documentDTO.quantity.toString(), style: TextStyle(fontSize:20)),
        onTap: () => Navigator.pushNamed(context, DetailsScreen.routeName, arguments: documentDTO)
      ),
      button: false,
      enabled: true,
      label: help,
      onTapHint: help,
      onLongPressHint: help
    );
  }
}