import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedbackCard extends StatefulWidget {
  @override
  _FeedbackCardState createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  var isSelected = false;

  double rating = 0;
  static Color _grey = Colors.blueGrey;
  static double _fontSize16 = 18;
  TextStyle textStyle = TextStyle(
      fontSize: _fontSize16, color: _grey, fontWeight: FontWeight.bold);
  TextStyle textStyleBold = TextStyle(
      fontSize: _fontSize16, color: Colors.black, fontWeight: FontWeight.bold);
  TextEditingController _textFieldController = TextEditingController();

  int _charCount = 0;

  _onChanged(String value) {
    setState(() {
      _charCount = value.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.clear,
                      ))),
              Text(
                "Thanks for availing service from",
                style: textStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: CircleAvatar(
                    minRadius: 48.0,
                    maxRadius: 48.0,
                    backgroundImage: NetworkImage(
                        "https://live.staticflickr.com/1585/23886400870_36f555a4ac_b.jpg")),
              ),
              Text(
                "Dr. Nupur Garg",
                style: textStyleBold,
              ),
              SizedBox(
                height: 32.0,
              ),
              Text(
                "Rate your experience",
                style: textStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) {
                    rating = v;
                    setState(() {});
                  },
                  starCount: 5,
                  rating: rating,
                  size: 32.0,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0),
              SizedBox(
                height: 32.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Leave your comments",
                    style: textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.grey, //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _textFieldController,
                    onChanged: _onChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                      counterText: _charCount.toString() + "/250",
                    ),
                    maxLength: 250,
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                textColor: Colors.white,
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.green)),
                color: Colors.green,
                child: Text("Submit"),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
