import 'package:flutter/material.dart';

@immutable
class LoadingIndefinite extends StatelessWidget {
  const LoadingIndefinite({ Key? key, required this.title }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 20),
          Text(title)
        ]
      )
    );
  }
}