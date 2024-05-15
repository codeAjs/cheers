import 'dart:developer';

import 'package:cheers/logic/cubits/cocktail_cubit/cocktail_cubit.dart';
import 'package:cheers/logic/cubits/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cocktail_model.dart';
import '../widgets/cocktail_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cheers'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            BlocConsumer<CocktailCubit, CocktailState>(
                builder: (context, state) {
                  log('building blocbuilder');

                  if (state is CocktailLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is CocktailLoadedState) {
                    return _randomList(state.cocktails, context);
                  }

                  if (state is CocktailErrorState) {
                    final cachedModels =
                        BlocProvider.of<CocktailCubit>(context).cachedModel;
                    if (cachedModels != null && cachedModels.isNotEmpty) {
                      return _randomList(cachedModels, context);
                    }

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No data found. Try again.'),
                          const SizedBox(height: 10,),
                          SizedBox(
                            child: IconButton(
                                onPressed: () => BlocProvider.of<CocktailCubit>(context).fetchRandomCocktail(),
                                icon: const Icon(Icons.refresh_outlined)),
                          )
                        ],
                      ),
                    );
                  }

                  return const Text('testing');
                },
              listener: (context, state) {

              },
                ),

            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search cocktail',
                suffix: IconButton(
                    onPressed: () {
                      BlocProvider.of<SearchCubit>(context).searchSingleCocktail(_textController.text);
                    },
                    icon: const Icon(Icons.search)),
              ),
            ),

            BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
              if (state is SearchErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.e)));
                final cachedModels =
                    BlocProvider.of<SearchCubit>(context).cachedSearch;
                if (cachedModels != null) {
                  return _searchList(cachedModels);
                }
                return const Text('Try again');
              }

              if (state is SearchLoadedState) {
                if (state.cocktails != null) {
                  return _searchList(state.cocktails!);
                }

                log('cocktail is null.');

                return const Text('No cocktail found. Try different name.');
              }

              if (state is SearchLoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }

              return const SizedBox.shrink();

            })
          ],
        ),
      )
    );
  }

  Widget _randomList(List<CocktailModel> cocktails, BuildContext context) {
    log('Random list building');
    return RefreshIndicator(
      onRefresh: () =>  BlocProvider.of<CocktailCubit>(context).fetchRandomCocktail(),
      child: ListView.builder(
        physics:
        const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cocktails.length,
        itemBuilder: (context, index) {
          final cocktail = cocktails[index];
          return CocktailCard(drinks: cocktail.drinks![0]);
        },
      ),
    );
  }

  Widget _searchList(CocktailModel cocktails) {
    //log('cocktail details: ${cocktails[0].drinks}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 10,
        color: Colors.yellow.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Scrollbar(
            controller: _scrollController,
            child: ListView.builder(
              physics:
              const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cocktails.drinks!.length,
              itemBuilder: (context, index) {
                return CocktailCard(drinks: cocktails.drinks![index]);
              },
            ),
          ),
        ),
      ),
    );
  }

}
