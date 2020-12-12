import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required this.message,
    @required this.author,
    @required this.rating,
  }) : super(key: key);

  final String message;
  final String author;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.white70,
        title: Text('${message}'),
        subtitle: Text("~ ${author}",
            style: TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.right),
        trailing: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: Container(
            child: Text('${rating}'),
            color: Colors.amber,
            height: 40,
            width: 40,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
