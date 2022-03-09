import 'package:flutter/material.dart';

class CardComponentWidget extends StatefulWidget {
  const CardComponentWidget({
    Key? key,
    this.title = "",
    this.description = "",
    this.image = "",
    //Todo: change to aspect ratio and remove as parameter
    this.imageWidth = 120,
    required this.cardHeight,
    this.cardWidth = double.infinity,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;
  final double imageWidth;
  final double cardHeight;
  final double cardWidth;

  @override
  State<CardComponentWidget> createState() => _CardComponentWidgetState();
}

class _CardComponentWidgetState extends State<CardComponentWidget> {
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
        children: [
          Container(
            color: Colors.red,
            width: widget.imageWidth,
          )
        ],
      ),
    );
  }
}
