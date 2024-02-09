import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:picture_perfect/cubit/bloc/person_bloc.dart';
import 'package:picture_perfect/models/person_model.dart';

class PersonWidget extends StatefulWidget {
  const PersonWidget({super.key});

  @override
  State<PersonWidget> createState() => _PersonWidgetState();
}

class _PersonWidgetState extends State<PersonWidget> {
  @override
  void initState() {
    super.initState();
    context.read<PersonBloc>().add(PersonEventStarted());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          BlocBuilder<PersonBloc, PersonState>(builder: (context, state) {
            if (state is PersonLaoding) {
              return Lottie.asset(
                  "assets/imaages/Animation - 1705141203569.json");
            } else if (state is PersonSuccess) {
              List<Person> person = state.personModel;
              return SizedBox(
                height: 130,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Person per = person[index];
                      return SizedBox(
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 3,
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w200${per.profile_path}",
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
                                      width: 80,
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
                                  per.name.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Center(
                                child: Text(
                                  per.knownForDepartment.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: ((context, index) {
                      return VerticalDivider(
                        color: Colors.transparent,
                        width: 5,
                      );
                    }),
                    itemCount: person.length),
              );
            } else {
              return SizedBox();
            }
          })
        ],
      ),
    );
  }
}
