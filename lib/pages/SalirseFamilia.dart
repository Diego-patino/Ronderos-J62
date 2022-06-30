import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalirseFamilia extends StatefulWidget {
  const SalirseFamilia({Key? key}) : super(key: key);

  @override
  State<SalirseFamilia> createState() => _SalirseFamiliaState();
}

class _SalirseFamiliaState extends State<SalirseFamilia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Salirse de Familia', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body: Center(
        child: Container(
          child: Text("PlaceHolder  Bottom Text"),
        ),
      ),
    );
  }
}