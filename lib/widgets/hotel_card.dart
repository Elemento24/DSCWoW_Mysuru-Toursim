import 'package:flutter/material.dart';

class HotelCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String rating;

  HotelCard(this.title, this.imgUrl, this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Card(
        // elevation: 6,
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.amber[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // padding: EdgeInsets.only(left: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          rating,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
