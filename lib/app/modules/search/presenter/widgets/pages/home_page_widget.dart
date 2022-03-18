import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
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
  TextEditingController _movieTitleTextEdController = TextEditingController();
  int currentPage = 1;
  List<ResultSearchEntity> currentMoviesList = [];

  final ScrollController _scrollController = ScrollController();
  final searchMovieBloc = Modular.get<SearchMovieBloc>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final currentScroll = _scrollController.position.pixels;
      final maxScroll = _scrollController.position.maxScrollExtent;

      if (currentScroll >= maxScroll * 0.99) {
        print(_movieTitleTextEdController.text);
        searchMovieBloc.add(StartSearchMoviesEvent(
            movieTitle: _movieTitleTextEdController.text, page: currentPage++));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchMovieBloc.close();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            movieTitleController: _movieTitleTextEdController,
            inputOnChange: (movieTitle) {
              searchMovieBloc
                  .add(StartSearchMoviesEvent(movieTitle: movieTitle));
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
                child: StreamBuilder<SearchState>(
                    stream: searchMovieBloc.stream,
                    builder: (context, snapshot) {
                      final state = searchMovieBloc.state;

                      if (state is SearchStateStart) {
                        return const Center(
                          child: Text(
                            'Type a movie name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      if (state is SearchStateError) {
                        return const Center(
                          child: Text(
                            'Movie not found,\nkeep searching',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }

                      if (state is SearchStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final List<ResultSearchEntity> fetchedMovieList =
                          state is SearchStateSuccess
                              ? (state).results
                              : currentMoviesList;
                      currentMoviesList = fetchedMovieList;
                      print(currentMoviesList.length);
                      return ListView.builder(
                        itemCount: (fetchedMovieList.length),
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final item = fetchedMovieList[index];

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
