import 'package:flutter/material.dart';
import 'package:movies_app/features/browse/presentation/widgets/genresViewWidget.dart';

class GenresScreen extends StatelessWidget {
  const GenresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //context.read<GenresCubit>().fetchCategories();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: const Text("GENRES"),
      ),
      body: Column(
        children: [
          Expanded(child: GenresView()),
        ],
      ),
    );
  }
}
