import 'package:flutter/material.dart';

class CardComponentWidget extends StatefulWidget {
  const CardComponentWidget({
    Key? key,
    this.title = "",
    this.description = "",
    this.image = "",
    required this.cardHeight,
    this.imageAspectRatio = 3 / 4,
    this.cardWidth = double.infinity,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;
  final double imageAspectRatio;
  final double cardHeight;
  final double cardWidth;

  @override
  State<CardComponentWidget> createState() => _CardComponentWidgetState();
}

class _CardComponentWidgetState extends State<CardComponentWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.cardHeight,
      width: widget.cardWidth,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff12162D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: widget.imageAspectRatio,
            child: Container(
              color: Colors.red,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Title",
                  style: TextStyle(),
                ),
                Text("Accent"),
                Text("Level"),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.only(left: 20),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      favorite = !favorite;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Icon(
                        favorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white),
                  ),
                ),
                Container(
                  child: const Text("0.0"),
                  height: 60,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xffFAD603),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
