import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/search_bloc/search_bloc.dart';
import '../screens/home_screen.dart';
import 'common/home_screen_bg.dart';

// ignore: must_be_immutable
class SearchItem extends StatelessWidget {
  List searchedData;
  SearchItem({super.key, required this.searchedData});

  @override
  Widget build(BuildContext context) {
    /// BlocConsumer to handle the listening and building
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        /// Navigate to HomeScreen if state is SearchTextSuccess
        if (state is SearchTextSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeScreen(
                    pageIndex: 1,
                  )));
        }
      },
      builder: (context, state) {
        /// If searching text fetch successfully save the data
        if (state is SearchSuccess) {
          searchedData = state.searchData;
        }

        return HomeScreenBg(
          /// If autocomplete data is empty show the no data found else show the result
          child: searchedData.isEmpty

              /// No data found text
              ? const Center(
                  child: Text('No results found'),
                )

              /// Autocomplete data list
              : ListView.builder(
                  itemCount: searchedData.length,
                  itemBuilder: (context, index) {
                    final location = searchedData[index];

                    /// List tile to show the autocomplete data
                    return ListTile(
                      onTap: () {
                        context.read<SearchBloc>().add(SearchLocationRequested(
                            searchText:
                                '${location['lat']},${location['lon']}'));
                      },
                      title: Text('${location['name']}, ${location['region']}'),
                    );
                  },
                ),
        );
      },
    );
  }
}
