import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picture_perfect/models/preview_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubit/bloc/bloc/favorite_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<String> stringy = [];
  List<String> overview = [];
  List<String> image = [];

  Future<void> loadData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String>? strings = _prefs.getStringList("movieTitle");
    List<String>? overs = _prefs.getStringList("movieOverview");
    List<String>? images = _prefs.getStringList("movieImage");
    if (strings != null) {
      setState(() {
        if (stringy != null && overs != null && images != null) {
          stringy = strings;
          overview = overs;
          image = images;
        }
      });
    }
  }

  @override
  void initState() {
    // loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 254, 144, 144),
        title: Text(
          "Favorites",
          style: TextStyle(
            fontFamily: "Dosis",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteAdded) {
            return fav_list(state);
          }else if (state is FavoriteRemoved){
            return fav_list(state);
          }else{
            return Container(color: Colors.black,);
          }
          
        },
      ),
    );
  }

  ListView fav_list(state) {
    return ListView.builder(
            itemCount: state.movieList.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final list = state.movieList[index];
              // final list = stringy[index];
              // final lis2 = overview[index];
              return SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListTile(
                  isThreeLine: true,
                  leading: SizedBox(
                      height: 80,
                      width: 80,
                      child: Icon(
                        Icons.movie_creation,
                        size: 40,
                      )),
                  title: Text(
                    list.title,
                    style: TextStyle(
                      fontFamily: "Dosis",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list.overview,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Dosis",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text("Imdb")
                    ],
                  ),
                ),
              );
            });
  }
}
