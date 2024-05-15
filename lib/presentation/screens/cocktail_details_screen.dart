import 'dart:developer';

import 'package:cheers/data/models/cocktail_model.dart';
import 'package:cheers/logic/cubits/cocktail_cubit/cocktail_cubit.dart';
import 'package:cheers/logic/cubits/extract_cubit/extract_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../widgets/design_widget.dart';

class CocktailDetailsScreen extends StatelessWidget {
  CocktailDetailsScreen(this.drink, {super.key});

  final Drinks drink;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cheers',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: BlocBuilder<ExtractCubit, ExtractState>(
              builder: (context, state) {
                if (state is ExtractStartingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ExtractEndState) {
                  return ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// COCKTAIL NAME
                          Center(
                            child: Text(
                              drink.strDrink!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),

                          /// MAIN IMAGE
                          MainImage.mainImage(drink),

                          const Gap(16),

                          /// CATEGORY
                          Text(
                            'Category',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 60,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      YellowContainer(drink.strCategory!),
                                      //
                                      const Gap(8),

                                      /// ALCOHOLIC
                                      YellowContainer(drink.strAlcoholic!),
                                    ],
                                  ),
                                ]),
                          ),

                          /// GLASS CATEGORY
                          Text(
                            'Glass',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),

                          /// 2nd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// GLASS
                              YellowContainer(drink.strGlass!),
                            ],
                          ),
                          //
                          const Gap(16),

                          /// INSTRUCTIONS
                          Text(
                            'Instructions',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              //width: 200,
                              decoration: BoxDecoration(
                                color: Colors.yellowAccent.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  drink.strInstructions!,
                                  textAlign: TextAlign.start,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              )),
                          const Gap(16.0),
                          Text(
                            'Ingredients',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Gap(8),
                          Text(
                              'Total ingredients: ${state.ingredients!.length}'),
                          //
                          const Gap(8),

                          /// INGREDIENTS IMAGE LIST
                          IngredientImages(state.ingredients!,
                              state.ingredientImages!, state.measures!,
                              scrollController: _scrollController)
                        ],
                      )
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ));
  }
}
