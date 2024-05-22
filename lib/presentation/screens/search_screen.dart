import 'package:cheers/logic/controller/change_screenX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cocktail_model.dart';
import '../../logic/cubits/search_cubit/search_cubit.dart';
import '../widgets/cocktail_card.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final controllerX = ChangeScreenX.instance;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        _onWillPop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12.withOpacity(0.01),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  //width: MediaQuery.of(context).size.width * 0.82,
                  height: 45,
                  child: TextField(
                    controller: _textController,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _editingCompleted(context),
                    autofocus: true,
                    cursorColor: Colors.yellow,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Search cocktail',
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 16
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                                color: Colors.grey.shade600
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                                color: Colors.grey.shade600
                            )
                        ),
                        // suffix: IconButton(
                        //     onPressed: () {
                        //       //BlocProvider.of<SearchCubit>(context).searchSingleCocktail(_textController.text);
                        //     },
                        //     icon: const Icon(Icons.search)),
                        prefixIcon: IconButton(
                          onPressed: () {
                            controllerX.toggleScreen();
                            //Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,
                            color: Colors.white,),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.help))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.82,
              //       height: 45,
              //       child: TextField(
              //         controller: _textController,
              //         textInputAction: TextInputAction.done,
              //         onEditingComplete: () => _editingCompleted(context),
              //         autofocus: true,
              //         cursorColor: Colors.yellow,
              //         decoration: InputDecoration(
              //           contentPadding: EdgeInsets.all(10),
              //           hintText: 'Search cocktail',
              //           hintStyle: TextStyle(
              //             color: Colors.white38,
              //           ),
              //           enabledBorder: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(100),
              //             borderSide: BorderSide(
              //               color: Colors.grey.shade600
              //             )
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(100),
              //               borderSide: BorderSide(
              //                   color: Colors.grey.shade600
              //               )
              //           ),
              //           // suffix: IconButton(
              //           //     onPressed: () {
              //           //       //BlocProvider.of<SearchCubit>(context).searchSingleCocktail(_textController.text);
              //           //     },
              //           //     icon: const Icon(Icons.search)),
              //           prefixIcon: IconButton(
              //             onPressed: () {
              //               controllerX.toggleScreen();
              //               //Navigator.pop(context);
              //             },
              //             icon: Icon(Icons.arrow_back,
              //             color: Colors.white,),
              //           )
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              const SizedBox(height: 20,),

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

                  return const Text('No cocktail found. Try different name.');
                }

                if (state is SearchLoadingState) {
                  return const Center(child: CircularProgressIndicator(),);
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                    Text("What's your poison tonight?\nSearch for your perfect cocktail!",
                    style: Theme.of(context).textTheme.titleLarge,),
                    Image.asset('assets/beer.png',
                    height: 200,),
                  ],
                );

              })
            ],
          ),
        )
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

  void _editingCompleted(BuildContext context) {
    String name = _textController.text.trim();
    if (name.isEmpty) {
      _unfocused();
      return;
    }

    _unfocused();
    BlocProvider.of<SearchCubit>(context).searchSingleCocktail(_textController.text);
  }

  void _unfocused() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

 void _onWillPop() {
    ChangeScreenX.instance.toggleScreen();
  }
}
