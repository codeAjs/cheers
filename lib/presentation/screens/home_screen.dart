import 'dart:developer';

import 'package:cheers/logic/cubits/cocktail_cubit/cocktail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cocktail_model.dart';
import '../widgets/cocktail_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                                onPressed: () => BlocProvider.of<CocktailCubit>(context).fetchCocktail(),
                                icon: const Icon(Icons.refresh_outlined)),
                          )
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
                listener: (context, state) {

                }),

            const TextField(
              decoration: InputDecoration(
                hintText: 'Search cocktail',
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _randomList(List<CocktailModel> cocktails, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>  BlocProvider.of<CocktailCubit>(context).fetchCocktail(),
      child: ListView.builder(
        physics:
        const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cocktails.length,
        itemBuilder: (context, index) {
          final cocktail = cocktails[index];
          return CocktailCard(cocktail: cocktail);
        },
      ),
    );
  }

}
