import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheers/data/models/cocktail_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CocktailCard extends StatelessWidget {
  const CocktailCard({super.key, required this.cocktail});
  final CocktailModel cocktail;

  @override
  Widget build(BuildContext context) {
    final drinks = cocktail.drinks?[0];
    return GestureDetector(
      //onTap: () =>
          //Get.to(() => CocktailDetailsWidget(cocktail: cocktail)),
      child: SizedBox(
        height: 69,
        child: Card(
          //color: Colors.yellow[700],
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  //backgroundColor: Colors.white,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: 40,
                      height: 40,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      //placeholderFit: BoxFit.cover,
                      imageUrl: '${drinks?.strDrinkThumb!}/preview',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                //
                const Gap(8),
                // DRINK'S NAME
                Text(drinks?.strDrink ?? '',
                  style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}