import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_perfect/cubit/movie_cubit.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

          List <PictureModel> dataList = state.pictureModel;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Color.fromARGB(200, 254, 144, 144),
                shadowColor: Colors.black,
                elevation: 30,
                title: Text(
                  "Picture Perfect",
                  style: TextStyle(
                    fontFamily: 'Dosis',
                    fontWeight: FontWeight.w600
                  ),
                ),
                centerTitle: true,
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 15),
                sliver: SliverToBoxAdapter(
                  child: CarouselSlider.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index, pageIndex) {
                        PictureModel movie = dataList[index];
                        final backdroPath = movie.backdropPath;
                        return Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original${backdroPath}',
                            height: MediaQuery.of(context).size.height/3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url)=>Platform.isAndroid?CircularProgressIndicator.adaptive(backgroundColor: const Color.fromARGB(255, 233, 112, 103),):CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/imaages/icons8-no-image-100.png'))
                              ),
                            ),
                            ),
                
                          ],
                        );
                      },
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(microseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 0.68,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
