import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.appBarHeight = 210}) : super(key: key);
  final double appBarHeight;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final double iconsSize = 30;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.appBarHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: Icon(
                  Icons.menu,
                  size: iconsSize,
                  color: Colors.white,
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(),
                ),
              ),
              Icon(
                Icons.search,
                size: iconsSize,
                color: Colors.white,
              ),
              Icon(
                Icons.filter_list_rounded,
                size: iconsSize,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Categories",
              style: TextStyle(color: Colors.white, fontSize: 31),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 31,
                  margin: const EdgeInsets.only(right: 18),
                  decoration: BoxDecoration(
                      color: const Color(0xff12162D),
                      borderRadius: BorderRadius.circular(15)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
