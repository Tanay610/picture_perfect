import 'package:flutter/material.dart';
import 'package:picture_perfect/bloc/genres%20bloc/genre_bloc.dart';
import 'package:picture_perfect/bloc/movie%20bloc/movie_bloc.dart';
import 'package:picture_perfect/bloc/movie%20bloc/movie_bloc_event.dart';
import 'package:picture_perfect/cubit/genre%20cubit/genre_cubit.dart';
import 'package:picture_perfect/cubit/movie%20cubit/movie_cubit.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/presentation/pages/picture_explore_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => MovieBloc())
        ),
        BlocProvider(create: ((context) => MovieCubit(PictureDataProvider()))),
        BlocProvider(create: ((context) => GenreBloc())),
        BlocProvider(create: ((context)=>GenreCubit(PictureDataProvider())))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 76, 121, 255)),
          useMaterial3: true,
        ),
        home: PictureHomePage(),
      ),
    );
  }
}
