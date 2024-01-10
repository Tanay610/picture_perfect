import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_perfect/cubit/movie_cubit.dart';

class PictureHomePage extends StatefulWidget {
  const PictureHomePage({super.key});

  @override
  State<PictureHomePage> createState() => _PictureHomePageState();
}

class _PictureHomePageState extends State<PictureHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getPictureDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieFailure) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is! MovieSuccess) {
            return const Center(
              child: CircularProgressIndicator.adaptive(backgroundColor: Color(0xff000000),),
            );
          }

          final data = state.pictureModel;
          final pictureUrl = data.posterPath;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Color.fromARGB(200, 254, 144, 144),
                shadowColor: Colors.black,
                elevation: 30,
                title: Text(
                  "Picture Perfect",
                ),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, pageIndex) {
                      return Container(
                        color: Colors.black,
                        child: Center(
                          child: Image.network("https://image.tmdb.org/t/p/w500$pictureUrl"),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      height: 486,
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}
