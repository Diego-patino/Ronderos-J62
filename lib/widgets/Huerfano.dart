import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/Unirse_familia.dart';

class Huerfano extends StatefulWidget {
  const Huerfano({Key? key}) : super(key: key);

  @override
  State<Huerfano> createState() => _HuerfanoState();
}

class _HuerfanoState extends State<Huerfano> {
  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Parece que eres huerfano :(', style: GoogleFonts.rampartOne(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),

                const SizedBox(height: 10,),

                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                           "Ingresa a una familia ",
                          style: TextStyle(
                             color: Colors.black45,
                                  fontSize: 19),
                                    ),
                    GestureDetector(
                           onTap: () {
                             Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                      Unirse_familia()));
                                    },
                        child: const Text(
                           "aqui",
                          style: TextStyle(
                             color: Colors.green,
                                fontWeight: FontWeight.bold,
                                  fontSize: 19),
                                    ),
                                  ),
                  ],
                )
              ],
            ));
  }
}