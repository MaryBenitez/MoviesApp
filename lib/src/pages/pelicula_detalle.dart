import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blueGrey,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: _condicion(pelicula),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 100),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

//Condicion para los titulos que son muy largos
  _condicion(Pelicula pelicula) {
    if (pelicula.id == 495764) {
      return Text(
        pelicula.title,
        style: TextStyle(color: Colors.white, fontSize: 9.5),
        textAlign: TextAlign.center,
      );
    } else if (pelicula.id == 565426) {
      return Text(pelicula.title,
          style: TextStyle(color: Colors.black, fontSize: 13.0),
          textAlign: TextAlign.center);
    } else {
      return Text(
        pelicula.title,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
        textAlign: TextAlign.center,
      );
    }
  }
}
