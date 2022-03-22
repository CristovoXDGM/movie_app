import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/result_search.dart';
import 'package:movie_app_fteam/app/modules/search/domain/errors/errors.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/store/home_page_store.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/store/home_page_widget_state.dart';
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
  final homePageStore = Modular.get<HomePageStore>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final currentScroll = _scrollController.position.pixels;
      final maxScroll = _scrollController.position.maxScrollExtent;

      if (currentScroll >= maxScroll * 0.99) {
        homePageStore.getMoviesByText(
            _movieTitleTextEdController.text, currentPage++);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            movieTitleController: _movieTitleTextEdController,
            onSubmitInput: (movieTitle) {
              homePageStore.getMoviesByText(movieTitle);
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
                child: ScopedBuilder<HomePageStore, SearchMoviesException,
                        HomePageWidgetState>(
                    onError: (context, error) {
                      currentMoviesList = [];

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
                    },
                    store: homePageStore,
                    onState: (context, HomePageWidgetState state) {
                      late List<ResultSearchEntity> fetchedList;

                      fetchedList = state.resultSearchList.isEmpty
                          ? currentMoviesList
                          : state.resultSearchList;
                      currentMoviesList.addAll(fetchedList);

                      return ListView.builder(
                        itemCount: (state
                                .filteredByCategoryResultSearchList.isEmpty
                            ? currentMoviesList.length
                            : state.filteredByCategoryResultSearchList.length),
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final item = state
                                  .filteredByCategoryResultSearchList.isEmpty
                              ? currentMoviesList[index]
                              : state.filteredByCategoryResultSearchList[index];

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
              homePageStore.isLoading
                  ? Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black54,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          )),
    );
  }
}
