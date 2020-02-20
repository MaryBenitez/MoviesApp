import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvider = new PeliculasProviders();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro AppBar, que puedn permitir limpiar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            //print('CLICK');
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          //print('ICON PRESS');
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //Instruccion que crea los resultados que vamos a mostrar
    return Center(
      child: Container(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    } else {
    
      return FutureBuilder(
          future: peliculasProvider.buscarPelicula(query),
          builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
            if (snapshot.hasData) {
              final peliculas = snapshot.data;
              return ListView(
                children: peliculas.map((pelicula) {
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage(pelicula.getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'), 
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text(pelicula.title),
                    subtitle: Text(pelicula.originalTitle),
                    onTap: (){
                      close( context, null); //Cierra la busqueda
                      pelicula.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                    },
                  );
                }).toList()
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }
  }
}
