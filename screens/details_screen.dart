import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/documentDTO.dart';

@immutable
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);
  static const String routeName = 'DetailsScreen';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DocumentDTO;

    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram Post'), centerTitle: true),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            CachedNetworkImage(
              imageUrl: args.imageURL,
              progressIndicatorBuilder: (context, url, downloadProgress)
                => Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: Theme.of(context).accentColor
                    )
                  ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    DateFormat.yMMMMEEEEd().format(args.date.toDate()),
                    style: TextStyle(fontSize: 20)
                  ),
                  Text(args.location.latitude.toString() + ',  ' + args.location.longitude.toString()),
                  Text(args.quantity.toString() + ' wasted item' + ((args.quantity > 1) ? 's' : ''))
                ]
              )
            )
          ]
        )
      )
    );
  }
}