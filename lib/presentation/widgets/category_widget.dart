import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:picture_perfect/cubit/bloc/now_play_bloc.dart';
import 'package:picture_perfect/cubit/genre%20cubit/genre_cubit.dart';
import 'package:picture_perfect/cubit/movie%20cubit/movie_cubit.dart';
import 'package:picture_perfect/models/genre_model.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:picture_perfect/presentation/pages/movie_preview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, this.selectedGenre = 28});

  final int selectedGenre;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late int selectedGenre;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
    context.read<GenreCubit>().getGenreList();
    context.read<NowPlayBloc>().add(GetPlayList(genreId: selectedGenre));
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<GenreCubit, GenreState>(builder: (context, state) {
          if (state is GenreLoading) {
            return Center(
              child: Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator(),
            );
          } else if (state is GenreSuccess) {
            List<Genre> genres = state.genreModel;
            return SizedBox(
              height: 45,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Genre genre = genres[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Genre genre = genres[index];
                            setState(() {
                              selectedGenre = genre.id;
                              context.read<NowPlayBloc>().add(GetPlayList(genreId: selectedGenre));
                            });
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: (genre.id == selectedGenre)
                                    ? const Color.fromARGB(255, 250, 127, 119)
                                    : Colors.white,
                                border: Border.all(color: Colors.black)),
                            child: Text(
                              genre.name.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (genre.id == selectedGenre)
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: 'Dosis'),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return VerticalDivider(
                      color: Colors.transparent,
                      width: 6,
                    );
                  },
                  itemCount: genres.length),
            );
          } else {
            return SizedBox();
          }
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "New Playing".toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Dosis'),
          ),
        ),
        BlocBuilder<NowPlayBloc, NowPlayState>(builder: (context, state) {
          if (state is NowPlayLoading) {
            List<PictureModel> movieL = state.tobeSorted;
            return sortList(context, movieL);

          }else if(state is NowPLaySuccess){
            List <PictureModel> sortedMovies = state.pictures;
            return sortList(context, sortedMovies);
          }else if(state is NowPlayError){
            return Text("Error:${state.message}");
          } else {
            return SizedBox.shrink();
          }
        })
      ],
    );
  }

  SizedBox sortList(BuildContext context, List<PictureModel> movieL) {
    return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  PictureModel movie = movieL[index];
                  final backdrop = movie.backdropPath;
                  final movieId = movie.id;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
          return MoviePreviewPage(movieId: movieId, movie: movie,);
        }));
                        },
                        child: ClipRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original${backdrop}',
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width * 0.35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(Radius.circular(12)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )),

                                    );
                                  },
                                  placeholder: (context, url) {
                                    return SizedBox(
                                      height: 200,
                                      width: 100,
                                      child: Lottie.asset(
                                          "assets/imaages/Animation - 1705141203569.json"),
                                    );
                                  },
                                  errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/imaages/icons8-no-image-100.png')),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                            SizedBox(height: 6,),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Dosis',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13
                                  
                                  ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){},
                                  child: SizedBox(
                                    height: 10,
                                    width: 15,
                                    child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,
                                    size: 20,
                                    
                                    )
                                    
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(children: [
                             
                              Image.asset("assets/imaages/imdb-svgrepo-com.png",
                              height: 16,
                              width: 18,
                              ),
                              SizedBox(width: 6,),
                              Text(movie.voteaverage.toStringAsFixed(1),
    
                              
                              )
                            ],)
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return VerticalDivider(
                    width: 14,
                    color: Colors.transparent,
                  );
                },
                itemCount: movieL.length),
          );
  }
}
