import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 254, 144, 144),
        title: Text("Favorites",
        style: TextStyle(
          fontFamily: "Dosis",
          fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: 6,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          return SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              isThreeLine: true,
              leading: SizedBox(
                height: 80,
                width: 80,
                child: Icon(Icons.movie_creation,
                size: 40,
                )
              ),
              title: Text("Superman",
              style: TextStyle(
                fontFamily: "Dosis",
                fontWeight: FontWeight.w500,
              ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Superman is a great movie msncjkdnjkcnjksnjknsdnjk ndjkn jkdnjk njknjkxn jkncjkn jknjzkn jzn",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Dosis",
                    fontWeight: FontWeight.w400
                  ),
                  ),
                  Text("Imdb")
                ],
              ),
              
            ),
          );
      }),
    );
  }
}