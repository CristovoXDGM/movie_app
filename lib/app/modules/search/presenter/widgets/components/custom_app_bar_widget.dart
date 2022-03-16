import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/search_movie_bloc_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/search_movie_bloc.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key, this.appBarHeight = 180, required this.onChange})
      : super(key: key);
  final double appBarHeight;
  final Function(String e) onChange;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final double iconsSize = 30;

  final searchMovieBloc = Modular.get<SearchMovieBloc>();

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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      label: Text("Type a movie name..."),
                    ),
                    onChanged: widget.onChange,
                  ),
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
        ],
      ),
    );
  }
}
