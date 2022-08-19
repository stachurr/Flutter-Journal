import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'models/documentDTO.dart';
import 'widgets/post_entry.dart';

class PostList extends StatelessWidget {
  const PostList({ Key? key, required this.docs, required this.updateTotal }) : super(key: key);
  final Function(num) updateTotal;
  final List<QueryDocumentSnapshot<Object?>> docs;

  @override
  Widget build(BuildContext context) {
    num total = 0;

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      updateTotal(total);
    });

    return ListView.separated(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        var post = docs[index];
        total += post['quantity'];
        return PostEntry(
          documentDTO: DocumentDTO(
            date:     post['date'],
            quantity: post['quantity'],
            imageURL: post['imageURL'],
            location: post['location']
          )
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Divider(height: 0, thickness: 1)
      ),
    );
  }
}