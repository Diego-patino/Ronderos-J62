import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ronderos/pages/Configuracion.dart';
import 'package:ronderos/pages/Confirmar_Borrar_cuenta.dart';

class BorrarCuenta extends StatefulWidget {
  const BorrarCuenta({Key? key}) : super(key: key);

  @override
  State<BorrarCuenta> createState() => _BorrarCuentaState();
}

class _BorrarCuentaState extends State<BorrarCuenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Borrar Cuenta', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    ListTile(
                      title: Text("Esta accion borrara tu cuenta de por vida",),
                      subtitle: Text("Al iniciar el proceso de eliminacion de tu cuenta,tu perfil y tus datos se eliminaran completamente de nuestra base de datos y tambien se te eliminara automaticamente de la familia a la que perteneces  "),
                    ),
                    SizedBox(height: 80,),

                    Text("SI ESTAS SEGURO DA CLICK EN PROCEDER", 
                    textAlign: TextAlign.center,
                    style: GoogleFonts.zillaSlabHighlight(
                      textStyle: TextStyle( 
                        fontSize: 60, 
                        color: Colors.green, 
                        fontWeight: FontWeight.bold ) )),
                    
                  ],
                  
                ),

                
              ],
            ),
          ),
        ),
        bottomNavigationBar: Material(
        color: Colors.red,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                ConfirmarBorrarCuenta()));
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Proceder',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}