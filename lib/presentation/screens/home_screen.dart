import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/auth_bloc/auth_bloc.dart';
import 'package:weather/bloc/weather_bloc/weather_bloc.dart';

import '../../bloc/search_bloc/search_bloc.dart';
import '../constants/constants.dart';
import '../widgets/common/home_screen_bg.dart';
import '../widgets/page_view.dart';

class HomeScreen extends StatefulWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Index of page
  int index = 0;

  /// Page chaged or not
  bool pageChanged = false;

  @override
  void initState() {
    super.initState();

    /// Fetch current location weather when page is called
    context.read<WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AuthBloc builder for managing AuthState
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          /// Auth state loading check
          if (state is AuthLoading) {
            return const HomeScreenBg(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          /// WeatherBloc builder for managing the weather data fetch
          return BlocConsumer<WeatherBloc, WeatherState>(
            listener: (context, state) {
              /// Weather failure check
              if (state is WeatherFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(Constants().customSnackBar(state.error));
              }
            },
            builder: (context, state) {
              /// Weather is not success check
              if (state is! WeatherSuccess) {
                return const HomeScreenBg(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              /// Fetched weather data from current location
              final currentLocationData = state.weatherData;

              /// Searched for any location
              bool searched = false;

              /// SearchBloc builder to manage search state
              return BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  var searchedLocationData = currentLocationData;

                  /// Searched location success state
                  if (state is SearchTextSuccess) {
                    searchedLocationData = state.weatherData;
                    searched = true;
                  }

                  /// Body
                  return HomeScreenBg(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 800,

                        /// PageView for current weather location and searched location
                        /// weather report
                        child: PageView(
                          /// PageController to handle the page index
                          controller:
                              PageController(initialPage: widget.pageIndex),
                          onPageChanged: (value) {
                            /// On page changed updates the index and pageChanged values
                            setState(() {
                              pageChanged = !pageChanged;
                              index = value;
                            });
                          },
                          children: [
                            /// Current location Weather data
                            PageItem(
                              data: currentLocationData,
                              pageIndex: pageChanged ? index : widget.pageIndex,
                            ),

                            /// Searched location weather data
                            /// Checks if searched or not
                            searched
                                ? PageItem(
                                    data: searchedLocationData,
                                    pageIndex:
                                        pageChanged ? index : widget.pageIndex,
                                  )
                                : const Center(
                                    child: Text(
                                        'Search for a location to get the Weather information.'),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
