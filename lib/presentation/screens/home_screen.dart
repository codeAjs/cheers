import 'dart:developer';

import 'package:cheers/logic/controller/change_screenX.dart';
import 'package:cheers/logic/cubits/cocktail_cubit/cocktail_cubit.dart';
import 'package:cheers/logic/cubits/search_cubit/search_cubit.dart';
import 'package:cheers/presentation/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cocktail_model.dart';
import '../widgets/cocktail_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controllerX = ChangeScreenX.instance;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controllerX.toggleScreen();
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 0,
                        color: Colors.white12
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.search,
                          color: Colors.yellow.withOpacity(0.6),),
              
                        const SizedBox(width: 10,),
                        const Text('Search cocktail',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white30))
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // const SizedBox(width: 5,),
            // IconButton(
            //     onPressed: () {},
            //     icon:  Icon(Icons.settings,
            //       color: Colors.yellow.withOpacity(0.6),))
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon:  Icon(Icons.settings,
                color: Colors.yellow.withOpacity(0.6),))
        ],
        backgroundColor: Colors.black12.withOpacity(0.01),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            const SizedBox(height: 40,),

            SizedBox(
              height: 80,
              child: Stack(
                children: [
                  Positioned(
                      child: Text('Shake it up! Explore some\ncocktails for a refreshing twist.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400
                      ),)),

                  Positioned(
                    right: 30,
                      bottom: 5,
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.asset('assets/cocktail-shaker.png',
                        height: 80,
                        ),
                      )),

                  Positioned(
                      right: 105,
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset('assets/cocktail.png',
                        height: 20,),
                      )),

                  Positioned(
                      right: 140,
                      bottom: 5,
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset('assets/cocktail2.png',
                          height: 30,),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 20,),

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
    );
  }

}
