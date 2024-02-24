import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather/bloc/search_bloc/search_bloc.dart';
import 'package:weather/presentation/screens/home_screen.dart';
import 'package:weather/presentation/widgets/search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  /// Search field controller
  final TextEditingController searchController = TextEditingController();

  /// Search text variable
  String searchText = '';

  /// Searched Data list
  List weatherData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe4f1fe),
      appBar: AppBar(
        backgroundColor: const Color(0xFFe4f1fe),
        foregroundColor: Colors.black,

        /// Back button
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomeScreen(
                      pageIndex: 0,
                    )));
          },
          icon: const Icon(Iconsax.arrow_left),
        ),

        /// Search field
        title: TextField(
          autofocus: true,
          controller: searchController,

          /// Update the search text and search fir the details
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
            context.read<SearchBloc>().add(SearchedLocation(searchText: value));
          },

          /// Search field decoration
          decoration: InputDecoration(
            hintText: 'Search city e.g. Hyderabad',
            suffixIcon: GestureDetector(
              onTap: () => searchController.clear(),
              child: const Icon(
                Icons.clear,
              ),
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),

      /// Search or auto complete list
      body: SearchItem(searchedData: weatherData),
    );
  }
}
