import 'package:cheers/data/repo/cocktail_repo.dart';
import 'package:cheers/logic/controller/change_screenX.dart';
import 'package:cheers/logic/cubits/cocktail_cubit/cocktail_cubit.dart';
import 'package:cheers/logic/cubits/search_cubit/search_cubit.dart';
import 'package:cheers/presentation/screens/home_screen.dart';
import 'package:cheers/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeScreenX());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CocktailCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        ),
        themeMode: ThemeMode.dark,
        home: GetBuilder<ChangeScreenX>(builder: (context) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.fastEaseInToSlowEaseOut,
              switchOutCurve: Curves.easeInOutCirc,
              child:
                  context.isSearchScreen ? SearchScreen() : HomeScreen());
        }),
      ),
    );
  }
}
