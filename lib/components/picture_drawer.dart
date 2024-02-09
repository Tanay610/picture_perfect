import 'package:flutter/material.dart';
import 'package:picture_perfect/presentation/pages/favorite_page.dart';

class PicDrawer extends StatelessWidget {
  const PicDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Column(
            children: [
              Icon(Icons.movie,
              size: 70,
              color: Colors.red.shade300,
              ),
              Text("Picture Perfect",
              style: TextStyle(
                fontFamily: 'Dosis',
                fontWeight: FontWeight.w500,
                fontSize: 24
              ),
              )
            ],
          )),

          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home",
            style: TextStyle(
                fontFamily: 'Dosis',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          InkWell(
            onTap:(){
              Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context){
              return FavoritesPage();
            }));
            },
            child: ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Favorites",
              style: TextStyle(
                  fontFamily: 'Dosis',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text("Search",
            style: TextStyle(
                fontFamily: 'Dosis',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}