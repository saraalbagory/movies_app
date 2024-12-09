import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/geners_cubit.dart';
import 'package:movies_app/features/browse/presentation/bloc/genres/genres_cubit_states.dart';
import 'package:movies_app/features/browse/presentation/widgets/genreCard.dart';

class GenresView extends StatelessWidget {
  GenresView({super.key /*, required this.apiGenresGet*/});
//to be changed
  //final ApiGenresGet apiGenresGet = new ApiGenresGetImpl();

  @override
  Widget build(BuildContext context) {
    context.read<GenresCubit>().fetchCategories();
    return BlocBuilder<GenresCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesLoaded) {
          return ListView.builder(
            itemCount: state.genres.length,
            itemBuilder: (context, index) {
              final genre = state.genres[index];
              return GenreCard(genre: genre);
            },
          );
        } else if (state is CategoriesError) {
          return Center(child: Text(state.message));
        }
        return Container();
      },
    );
  }
}
