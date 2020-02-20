import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey],
            begin: FractionalOffset.bottomRight,
            end: FractionalOffset.topRight
          )
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            _crearAppBar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 10.0,
                ),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.grey,
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

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  //style: TextStyle(color: Colors.white),
                  style: Theme.of(context).textTheme.title.merge(TextStyle(color: Colors.white)),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: Colors.white)),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0
      ),
      child: Text(
        pelicula.overview,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
