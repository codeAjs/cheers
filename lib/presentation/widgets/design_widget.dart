
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheers/data/models/cocktail_model.dart';
import 'package:cheers/logic/cubits/cocktail_cubit/cocktail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class YellowContainer extends StatelessWidget {
  const YellowContainer(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      height: 40,
      //width: 200,
      decoration: BoxDecoration(
        color: Colors.yellowAccent.withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class MainImage {
  static Widget mainImage(Drinks drink) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            width: 4.5,
            color: Colors.yellow.withOpacity(0.6),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: drink.strDrinkThumb!,
            placeholder: (context, url) =>
            const SizedBox(
                height: 100,
                width: 100,
                child: Center(child: CircularProgressIndicator())),
            errorWidget: (context, url, error) =>
            const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class IngredientImages extends StatelessWidget {
  const IngredientImages(this.ingredients, this.ingredientImages, this.measures, {super.key,
    required this.scrollController});

  final ScrollController scrollController;
  final List<String> ingredients;
  final Map<String, String> measures;
  final Map<String, String> ingredientImages;

  //final Drinks drinks;

  //final CocktailController cocktailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: Colors.yellowAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SizedBox(
          height: 180,
          child: Scrollbar(
            controller: scrollController,
            thickness: 5,
            thumbVisibility: false,
            radius: const Radius.circular(5),
            child: ListView.builder(
            //padding: EdgeInsets.all(5),
            scrollDirection: Axis.horizontal,
            physics:
            const AlwaysScrollableScrollPhysics(),
            shrinkWrap: false,
            itemCount:
            ingredients?.length,
            itemBuilder: (context, index) {
              final ingredient =
              ingredients?[index];
              final measure = measures?[ingredient];
              final image = ingredientImages?[ingredient];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0),
                child: Column(
                  children: [
                    if (image != null)
                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        // CACHED NETWORK IMAGE
                        child: CachedNetworkImage(
                          imageUrl: image,
                          width: 100.0,
                          height: 100.0,
                          placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                          errorWidget:
                              (context, url, error) =>
                          const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      )
                    else const CircularProgressIndicator(),
                    const Gap(10),
                    Row(
                      children: [
                        YellowContainer('$measure $ingredient'),
                        //Text('$measure $ingredient'),
                        //Text(ingredient ?? 'No drink found'),
                      ],
                    ),
                  ],
                ),
              );
              //return Text(_ingredients![index]);
            },
          ),
          ),
        ),
      ),
    );
  }
}
