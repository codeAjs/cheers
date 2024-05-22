import 'package:cached_network_image/cached_network_image.dart';
import 'package:cheers/data/models/cocktail_model.dart';
import 'package:cheers/logic/cubits/extract_cubit/extract_cubit.dart';
import 'package:cheers/presentation/screens/cocktail_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CocktailCard extends StatelessWidget {
  const CocktailCard({super.key, required this.drinks});
  final Drinks drinks;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => ExtractCubit(drinks),
              child: CocktailDetailsScreen(drinks),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 69,
        child: Card(
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
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
                Text(
                  drinks?.strDrink ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
