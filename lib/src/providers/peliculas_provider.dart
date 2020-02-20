import 'dart:async';
import 'dart:convert';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apikey = '3efc5e7dc0972d57f4997477b3954e29';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  //Stream: Corrientes de datos
  List<Pelicula> _populares = new List();

  //Creando Stream -- Hay que ser especifico en la información
  final _popularesStreamController = StreamController<
      List<
          Pelicula>>.broadcast(); //Si no se pone el broadcast funcionaria solo lo escucharia un widget

  //Introduciendo informacion
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //Saliendo la informacion
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  //Funcion para cerrar el Stream
  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) {
      return [];
    } else {
      _cargando = true;
    }

    _popularesPage++;

    //print('Cargando siguientes...');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    //Utilizando sink para colocarlo al inicio del Stream de datos
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.http(_url, '3/movie/$peliId/credits',{
      'api_key'   : _apikey, 
      'language'  : _language
    });

    final resp = await http.get(url);

    //Almaceno la respuesta del mapa
    final decodedData = json.decode(resp.body);

    
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apikey,
      'language': _language,
      'query'   : query
    });

    return await _procesarRespuesta(url);
  }

}
