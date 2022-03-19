import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/store/get_movie_categories_store.dart';

class CustomListCategoriesWidget extends StatefulWidget {
  const CustomListCategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CustomListCategoriesWidget> createState() =>
      _CustomListCategoriesWidgetState();
}

class _CustomListCategoriesWidgetState
    extends State<CustomListCategoriesWidget> {
  final movieCategoriesStore = Modular.get<GetMovieCategoriesStore>();
  int currentCategoryIndex = 0;
  @override
  void initState() {
    super.initState();
    movieCategoriesStore.getMovieCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 40,
        child: ScopedBuilder(
          store: movieCategoriesStore,
          onError: (context, error) => const Center(
            child: Text('Categories unavailable'),
          ),
          onLoading: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          onState: (context, List<MovieCategoriesEntity> state) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentCategoryIndex = index;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 31,
                    alignment: Alignment.center,
                    child: Text(
                      state[index].category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    margin: const EdgeInsets.only(right: 18),
                    decoration: BoxDecoration(
                        color: currentCategoryIndex == index
                            ? const Color(0xff3D57BC)
                            : const Color(0xff12162D),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                );
              },
            );
          },
        ));
  }
}
