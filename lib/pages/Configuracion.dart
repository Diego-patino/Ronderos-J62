import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/models/Config_opciones.dart';
import 'package:ronderos/pages/Administrar_familia.dart';
import 'package:ronderos/pages/Borrar_cuenta.dart';
import 'package:ronderos/pages/Cambiar_contra.dart';
import 'package:ronderos/pages/Edicion_usuario.dart';

import 'HomePage.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Configuracion', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
      
            SizedBox(height: 10,),
      
            Container(child: Text("AJUSTES DE USUARIO", style: GoogleFonts.righteous(textStyle: TextStyle(fontSize: 20)),)),
      
            SizedBox(height: 10,),
      
            Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: Config1List.length,
                            itemBuilder: (context, index) {
                              Config1 config1 = Config1List[index];
                              return ListTile(
                                title: Text(config1.configuracion),
                                subtitle: Text(config1.descripcion),
                                leading: config1.boton,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                    config1.materialPageRoute == "cuenta" ? Edicion_usuario() :
                                    config1.materialPageRoute == "contra" ? Cambiarcontra() :
                                    Administrar_familia() ));
                                },
                              );
                            },
                  
                ),
              ),
            ),
      
            SizedBox(height: 20,),
      
            Container(child: Text("AJUSTES DE APLICACIÓN", style: GoogleFonts.righteous(textStyle: TextStyle(fontSize: 20)),)),
      
            SizedBox(height: 10,),
      
            Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: Config2List.length,
                            itemBuilder: (context, index) {
                              Config2 config2 = Config2List[index];
                              return ListTile(
                                title: Text(config2.configuracion),
                                subtitle: Text(config2.descripcion),
                                leading: config2.boton,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                   builder: (context) =>
                                    config2.materialPageRoute == "salirfamily"? HomePage123() : BorrarCuenta()));
                                },
                              );
                            },
                          ),
                  
                ),
              ),
          ],
        ),
      ),
    );
  }
}