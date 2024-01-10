import 'package:flutter/material.dart';
import 'package:picture_perfect/cubit/movie_cubit.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/data/repository/picture_repository.dart';
import 'package:picture_perfect/presentation/pages/picture_explore_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PictureRepository(PictureDataProvider()),
      child: BlocProvider(
        create: (context) => MovieCubit(context.read<PictureRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 76, 121, 255)),
            useMaterial3: true,
          ),
          home: PictureHomePage(),
        ),
      ),
    );
  }
}
