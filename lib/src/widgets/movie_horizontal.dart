import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        //print('Cargar siguientes peliculas');
        siguientePagina();
      }
    });

    return Container(
      //margin: EdgeInsets.only(top: 10.0),

//--** LA DIFERENCIA ENTRE PAGEVIEW Y PAGEVIEW.BUILDER
//--** ES QUE EL BUILDER LOS VA A RENDERIZAR CONFORME SON NECESARIOS.

      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {

        //id unico, creado especialmente por si la pelicula este en
    //el mismo contenedor
    //--**Creado en el modelo pelicula
    pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula
                  .uniqueId, //Id unico que debe identificar el elemento a animar
              //tanto aqui como en la otra vista
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 155.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            )
          ],
        ));

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        //print('NOMBRE DE LA PELICULA: ${pelicula.title}');
        timeDilation = 2;
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 155.0,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                pelicula.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ));
    }).toList();
  }
}
