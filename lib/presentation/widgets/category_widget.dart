import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_perfect/cubit/genre%20cubit/genre_cubit.dart';
import 'package:picture_perfect/cubit/movie%20cubit/movie_cubit.dart';
import 'package:picture_perfect/models/genre_model.dart';
import 'package:picture_perfect/models/picture_model.dart';

class CategoryWidget extends StatefulWidget {
   const CategoryWidget({super.key,this.selectedGenre = 28});

  final int selectedGenre;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int selectedGenre = 1;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
    context.read<GenreCubit>().getGenreList();
    context.read<MovieCubit>().getPictureDetails(selectedGenre, '');
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GenreCubit, GenreState>(builder: (context, state){
          if (state is GenreLoading) {
            return Center(
              child: Platform.isAndroid?CircularProgressIndicator():CupertinoActivityIndicator(),
            );
          } else if (state is GenreSuccess){
            List<Genre> genres = state.genreModel;
            return SizedBox(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                Genre genre = genres[index];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: (genre.id == selectedGenre)?const Color.fromARGB(255, 250, 127, 119):Colors.white,
                        border: Border.all(color: Colors.black)
                        ),
                        child: Text(genre.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: (genre.id == selectedGenre)?Colors.white:Colors.black,
                          fontFamily: 'Dosis'
                        ),
                        ),
                      ),
                  ],
                );
              }, separatorBuilder: (context, index){
                return VerticalDivider(
                  color: Colors.transparent,
                  width: 6,
                );

              }, itemCount: genres.length),
            );
            
          }else{
            return SizedBox();
          }
        }),

        Text("New Playing".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dosis'
                      ),
                      ),
                      BlocBuilder<MovieCubit, MovieState>(
                        builder: (context, state){
                          if (state is MovieLoading) {
                            return CircularProgressIndicator();
                          } else if (state is MovieSuccess){
                            List<PictureModel> movieList = state.pictureModel;
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 0.3,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: Colors.green
                                    ),
                                  );
                              }, separatorBuilder: (context, index){
                                return VerticalDivider(
                                  width: 14,
                                );
                              }, itemCount: 7),
                            );
                          }else{
                            return SizedBox();
                          }
                      })

        
      ],
    );
  }
}