import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/search_movie_bloc_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/search_movie_bloc.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/search_result_bloc_state.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/widgets/components/custom_app_bar_widget.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/widgets/components/custom_card_component_widget.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/widgets/components/custom_list_categories_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final Color defaultBackgroundColor = const Color(0xff1E2440);

  final searchMovieBloc = Modular.get<SearchMovieBloc>();

  @override
  void initState() {
    super.initState();

    searchMovieBloc.add(StartSearchMoviesEvent(movieTitle: 'a'));
  }

  @override
  void dispose() {
    super.dispose();
    searchMovieBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            onChange: (e) {
              searchMovieBloc.add(StartSearchMoviesEvent(movieTitle: e));
            },
          ),
          backgroundColor: defaultBackgroundColor,
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomListCategoriesWidget(),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: searchMovieBloc.stream,
                    builder: (context, snapshot) {
                      final state = searchMovieBloc.state;

                      if (state is SearchStateStart) {
                        return const Center(
                          child: Text('Type a movie name'),
                        );
                      }
                      if (state is SearchStateError) {
                        return const Center(
                          child: Text('An error Occurred'),
                        );
                      }

                      if (state is SearchStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final list = (state as SearchStateSuccess).results;

                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];

                          return CardComponentWidget(
                            cardHeight: 180,
                            image: item.movieImage,
                            title: item.movieTitle,
                            accent: item.movieAccent,
                            rating: item.movieRating,
                          );
                        },
                      );
                    }),
              ),
            ],
          )),
    );
  }
}
