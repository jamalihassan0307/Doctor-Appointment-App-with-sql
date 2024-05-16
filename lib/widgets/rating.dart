import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Ratingscreen extends StatefulWidget {
  const Ratingscreen({super.key});

  @override
  State<Ratingscreen> createState() => _RatingscreenState();
}

class _RatingscreenState extends State<Ratingscreen> {
  double fullrating = 0;
  double halfrating = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 900,
          width: 370,
          color: Colors.white,
          child: Column(
            children: [
              //fullrating
              SizedBox(
                height: 20,
              ),
              Text(
                "Full Rating",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  unratedColor: Colors.grey,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  updateOnDrag: true,
                  itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Color(0xFF7165D6),
                      ),
                  onRatingUpdate: (ratingvalue) {
                    setState(() {
                      fullrating = ratingvalue;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rating : $fullrating",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              // halfrating
              SizedBox(
                height: 20,
              ),
              Text(
                "Half & Full Rating",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                  initialRating: 0,
                  allowHalfRating: true,
                  minRating: 1,
                  unratedColor: Colors.grey,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  updateOnDrag: true,
                  itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Color(0xFF7165D6),
                      ),
                  onRatingUpdate: (ratingvalue) {
                    setState(() {
                      halfrating = ratingvalue;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rating : $halfrating",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
