import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProviders = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('Peliculas en Cine'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {}
          ),
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
            height: 400.0,
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
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subhead),
          FutureBuilder(
            future: peliculasProviders.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              snapshot.data.forEach((p) => print(p.title)
            );
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
