
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/base_client.dart';


class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21262E),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20,0,0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: const Color(0x2ffccd8e4),
                          hintText: 'search',
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 8, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Trending movies',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),


                        scrollbuilder().movie_scroll('popular'),


                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 8, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Top Rated',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),


                        scrollbuilder().movie_scroll('top_rated'),



                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 8, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Now Playing',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),


                        scrollbuilder().movie_scroll('now_playing'),










                ElevatedButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text('Signout'),
              ),
              ]
      ),





    );
  }
}
