import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/get_movie_categories_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/get_movie_categories_bloc.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/get_movie_categories_bloc_state.dart';

class CustomListCategoriesWidget extends StatefulWidget {
  const CustomListCategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CustomListCategoriesWidget> createState() =>
      _CustomListCategoriesWidgetState();
}

class _CustomListCategoriesWidgetState
    extends State<CustomListCategoriesWidget> {
  final movieCategoriesBloc = Modular.get<GetMovieCategoriesBloc>();

  @override
  void initState() {
    super.initState();
    movieCategoriesBloc.add(LoadMovieCategories());
  }

  @override
  void dispose() {
    super.dispose();
    movieCategoriesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 40,
        child: StreamBuilder(
            stream: movieCategoriesBloc.stream,
            builder: (context, snapshot) {
              var state = movieCategoriesBloc.state;

              if (state is LoadingGetCategories) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ErrorGetCategories) {
                return const Center(
                  child: Text("Categories unavailable"),
                );
              }

              final result = (state as SuccessGetCategories).results;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 31,
                    alignment: Alignment.center,
                    child: Text(
                      result[index].category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 18),
                    decoration: BoxDecoration(
                        color: const Color(0xff12162D),
                        borderRadius: BorderRadius.circular(15)),
                  );
                },
              );
            }));
  }
}
