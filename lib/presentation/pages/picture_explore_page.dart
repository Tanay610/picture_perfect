
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:picture_perfect/components/picture_drawer.dart';
import 'package:picture_perfect/cubit/movie%20cubit/movie_cubit.dart';
import 'package:picture_perfect/models/picture_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:picture_perfect/presentation/widgets/category_widget.dart';
import 'package:picture_perfect/presentation/widgets/person_widget.dart';

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
      drawer: PicDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Color.fromARGB(200, 254, 144, 144),
            shadowColor: Colors.black,
            elevation: 30,
            title: Text(
              "Picture Perfect",
              style:
                  TextStyle(fontFamily: 'Dosis', fontWeight: FontWeight.w600),
            ),
          

            centerTitle: true,
            actions: [
              IconButton(onPressed: (){

              }, icon: Icon(Icons.search))
            ],
          ),
          
          SliverPadding(
            padding: EdgeInsets.only(top: 15),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<MovieCubit, MovieState>(
                builder: (context, state) {
                  if (state is MovieFailure) {
                    return Center(
                      child: Text(state.error),
                    );
                  }

                  if (state is! MovieSuccess) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Color(0xff000000),
                      ),
                    );
                  }

                  List<PictureModel> dataList = state.pictureModel;
                  return CarouselSlider.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index, pageIndex) {
                        PictureModel movie = dataList[index];
                        final backdroPath = movie.backdropPath;
                        return Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original${backdroPath}',
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Lottie.asset(
                                      "assets/imaages/Animation - 1705141203569.json");
                                },
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/imaages/icons8-no-image-100.png')),
                                  ),
                                ),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, bottom: 15),
                              child: Text(
                                movie.title.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Dosi',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        );
                      },
                      options: CarouselOptions(
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(microseconds: 800),
                        pauseAutoPlayOnTouch: true,
                        viewportFraction: 0.78,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ));
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CategoryWidget(),
                  Text("Trending person on this week".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,

                      ),
                      
                      ),
                      SizedBox(
                    height: 10,
                  ),
                      PersonWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
   

   /**
    * BlocBuilder<MovieCubit, MovieState>(
       
    */