import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardComponentWidget extends StatefulWidget {
  const CardComponentWidget({
    Key? key,
    this.title = '',
    this.accent = '',
    this.image = '',
    this.rating = 0.0,
    required this.cardHeight,
    this.imageAspectRatio = 3 / 4,
    this.cardWidth = double.infinity,
  }) : super(key: key);

  final String title;

  final String accent;
  final String image;
  final double rating;
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
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/original${widget.image}',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                )),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                highlightColor: Colors.grey.shade100,
                baseColor: Colors.grey.shade300,
                child: Container(
                  color: Colors.grey.shade300,
                ),
              ),
              errorWidget: (context, url, error) => const Placeholder(),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text('Accent: ${widget.accent}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(left: 20),
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                          favorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Text(widget.rating.toStringAsFixed(1)),
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
          ),
        ],
      ),
    );
  }
}
