import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app_fteam/app/modules/search/domain/entities/movie_category.dart';
import 'package:movie_app_fteam/app/modules/search/domain/usecases/get_movie_categories_usecase.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/events/get_movie_categories_event.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/get_movie_categories_bloc.dart';
import 'package:movie_app_fteam/app/modules/search/presenter/bloc/states/get_movie_categories_bloc_state.dart';

class GetMovieCategoriesMock extends Mock implements GetMovieCategoriesUseCase {
}

void main() {
  late GetMovieCategoriesBloc getMovieCategoriesBloc;
  late GetMovieCategoriesUseCase useCase;

  setUpAll(() {
    useCase = GetMovieCategoriesMock();
    getMovieCategoriesBloc = GetMovieCategoriesBloc(useCase);
  });

  test('Should return states in the correct order', () {
    when(() => useCase.call())
        .thenAnswer((invocation) async => right(<MovieCategoriesEntity>[]));

    expect(
        getMovieCategoriesBloc.stream,
        emitsInOrder([
          isA<LoadingGetCategories>(),
          isA<SuccessGetCategories>(),
        ]));
    getMovieCategoriesBloc.add(LoadMovieCategories());
  });
}
