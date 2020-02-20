import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que aparecen cuando la persona escribe
    return Container();
  }
}
