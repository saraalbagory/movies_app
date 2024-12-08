import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/presentation/bloc/search/search_cubit.dart';
import 'package:movies_app/features/browse/presentation/widgets/searchResultsWidget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();
    // to be changed
    //ApiSearchResult apiSearchResult = ApiSearchResultsImpl();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                //setState(() {});
                searchCubit.searchMovies(value);
              },
              decoration: const InputDecoration(hintText: 'Search...'),
            ),
            Expanded(
              child: SearchResultsWidgets(
                query: controller.text,
                //apiSearchResult: apiSearchResult,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
