import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProviders = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {
    
    peliculasProviders.getPopulares();

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Peliculas en Cine'),
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body:
          //"SafeArea" Widget que respeta la muesca del celular
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _swiperTarjeta(),
                _footer(context),
              ],
              )
          )
      );
  }

  Widget _swiperTarjeta() {
    return FutureBuilder(
      future: peliculasProviders.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 300.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 15.0),
            child: Text('Populares',
              style: TextStyle(color: Colors.white),
            )
          ),

          //AQUI ESTA EL STREAM
          StreamBuilder(
            stream: peliculasProviders.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProviders.getPopulares,
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
