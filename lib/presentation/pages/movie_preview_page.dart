import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:picture_perfect/cubit/bloc/bloc/favorite_bloc.dart';
import 'package:picture_perfect/cubit/movie%20cubit/movie_cubit.dart';
import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/picture_image.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:picture_perfect/models/preview_model.dart';
import 'package:picture_perfect/models/screen_shot.dart';
import 'package:picture_perfect/movie_preview_bloc/bloc/movie_preview_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/cast_list.dart';

class MoviePreviewPage extends StatefulWidget {
  final int movieId;
  final PictureModel movie;
   MoviePreviewPage({
    super.key,
    required this.movieId,
    required this.movie,
  });

  @override
  State<MoviePreviewPage> createState() => _MoviePreviewPageState();
}

class _MoviePreviewPageState extends State<MoviePreviewPage> {
  bool isExpanded = false;
  bool isfavorite = false;
  List<String> titles = [];
  List<String> overview = [];
  List<String> stringImage = [];

  void saveData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs.setStringList("movieTitle", titles..add(widget.movie.title));
      _prefs.setStringList(
          "movieOverview", overview..add(widget.movie.overview));
      _prefs.setStringList(
          "movieImage", stringImage..add(widget.movie.posterPath));
      // _prefs.setBool("favorite", isfavorite!);
    });
  }

  // void loadbool() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   isfavorite = _prefs.getBool("favorite");
  // }

  Future<void> removeFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('movieTitle');
    await prefs.remove('movieOverview');
    await prefs.remove('movieImage');
    await prefs.remove('favorite');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavoriteBloc>().state;
    return BlocProvider(
      create: (_) => MoviePreviewBloc(PictureDataProvider())
        ..add(MoviePreviewEventStarted(id: widget.movieId)),
      child: PopScope(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
               IconButton(
  onPressed: () {
    if (state is FavoriteAdded && state.movieList.any((movie) => movie.id == widget.movieId)) {
      //? Dispatch RemoveFromFavoriteEvent when the favorite icon is tapped again
      context.read<FavoriteBloc>().add(RemoveFromFavoriteEvent(widget.movieId));
    } else {
      //? Dispatch AddToFavoriteEvent when the favorite icon is tapped
      context.read<FavoriteBloc>().add(FavoriteEventStarted(widget.movieId));
    }
    
  },
  icon: Icon(
        // Display the correct icon based on the state
        (state is FavoriteAdded && state.movieList.any((movie) => movie.id == widget.movieId))
            ? Icons.favorite
            : Icons.favorite_border,
            color: Colors.red,
      ),
),
             
          ],
        ),
        body: _buildPreviewBody(context, isExpanded),
        // extendBody: true,
        extendBodyBehindAppBar: true,
      )),
    );
  }

  Widget _buildPreviewBody(BuildContext context, bool isExpanded) {
    return BlocBuilder<MoviePreviewBloc, MoviePreviewState>(
      builder: (BuildContext context, state) {
        if (state is MoviePreviewLoading) {
          return Center(
              child: SizedBox(
            height: 90,
            child:
                Lottie.asset("assets/imaages/Animation - 1705141203569.json"),
          ));
        } else if (state is MoviePreviewSucces) {
          MovieDetails previeDetails = state.previewdetails;
          PictureImage pictureImageShots = state.pictureImage;
          final String vack = previeDetails.backdroPath;
          return Stack(
            children: [
              ClipPath(
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: "https://image.tmdb.org/t/p/original/${vack}",
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return SizedBox(
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
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final youtube =
                          'https://www.youtube.com/watch?v=${previeDetails.video}';

                      if (await canLaunchUrl(Uri.parse(youtube))) {
                        await launchUrl(Uri.parse(youtube));
                      }
                    },
                    child: SizedBox(
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.red.shade300,
                              size: 85,
                            ),
                            Text(
                              previeDetails.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Dosis'),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Screenshots".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dosis',
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          ScreenShot image =
                              pictureImageShots.backdrops![index];
                          return SizedBox(
                            child: Card(
                              elevation: 3,
                              borderOnForeground: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return SizedBox(
                                      child: Lottie.asset(
                                          "assets/imaages/Animation - 1705141203569.json"),
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/imaages/icons8-no-image-100.png')),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return VerticalDivider(
                            color: Colors.transparent,
                            width: 5,
                          );
                        },
                        itemCount: pictureImageShots.backdrops!.length),
                  ),

                  SizedBox(
                    child: Row(
                      children: [
                        Text(previeDetails.release_date),
                        SizedBox(
                          width: 10,
                        ),
                        Text(previeDetails.budget),
                        SizedBox(
                          width: 10,
                        ),
                        Text("${previeDetails.runtime} min"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: ExpandableText(
                      text: previeDetails.overview,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       isExpanded = !isExpanded;
                  //     });
                  //   },
                  //   child: Text(
                  //     isExpanded ? 'See less' : 'See more',
                  //     style: TextStyle(
                  //       color: Colors.blue,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  Text(
                    "Cast".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Dosi',
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Cast cast = previeDetails.castList[index];
                          final String? image = cast.profilePath;

                          return SizedBox(
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  elevation: 3,
                                  child: ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl: image == null
                                          ? "https://th.bing.com/th/id/OIP.75GXk4fq7mcS9WehghvIjAAAAA?w=173&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"
                                          : "https://image.tmdb.org/t/p/w200${image}",
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        );
                                      },
                                      placeholder: (context, url) {
                                        return SizedBox(
                                          height: 80,
                                          child: Lottie.asset(
                                              "assets/imaages/Animation - 1705141203569.json"),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/imaages/icons8-no-image-100.png')),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      cast.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Dosis"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Center(
                                    child: Text(
                                      cast.character,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        fontFamily: 'Dosis',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return VerticalDivider(
                            color: Colors.transparent,
                            width: 5,
                          );
                        },
                        itemCount: previeDetails.castList.length),
                  )
                ],
              )
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

class ExpandableTextWidget extends StatelessWidget {
  final String text;
  final int? maxLines;

  ExpandableTextWidget({super.key, required this.text, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Text(
              text,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({super.key, required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(
        _isExpanded ? 'See less' : 'See more',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.text,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
