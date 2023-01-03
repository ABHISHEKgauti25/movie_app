

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'movie_model.dart';

const String baseurl ='https://api.themoviedb.org/3/movie/';
const api_key = '?api_key=62cc3de528c9b1ec1b36e3c7e6a793ad';
class BaseClient {
  var client = http.Client();

  //Get method
  Future<dynamic> get( String api) async{
    var url = Uri.parse(baseurl+api+api_key);
    var response = await client.get(url);
    if(response.statusCode == 200){
        return response.body;
    }
  }
}

class scrollbuilder{

  Future<Movie> get_movie(String category) async {
    var response = await BaseClient().get(category);
    var body = json.decode(response.toString());
    return Movie.fromJson(body);
  }
  Widget movie_scroll( String categ){
    return   Expanded(
      child: FutureBuilder<Movie>(
                future: get_movie(categ),   //accessing popular category
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.results.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                child: Container(
                                  height: 100,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'http://image.tmdb.org/t/p/w780${snapshot.data!.results[index]
                                                  .posterPath}'),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 50,
                                width: 140,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      snapshot.data!.results[index].title
                                          .toString(),
                                      style: const TextStyle(
                                          color: Color(0xFFCCD8E4),
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    );
                  }
                  else {
                    return const Text('loading');
                  }
                }



      ),
    );
  }
}


