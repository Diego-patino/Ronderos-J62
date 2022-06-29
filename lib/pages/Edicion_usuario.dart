import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ronderos/models/Familia.dart';
import 'package:ronderos/models/Users.dart';
import 'package:ronderos/models/usuarios123.dart';
import 'package:ronderos/pages/Configuracion.dart';
import 'package:ronderos/pages/HomePage.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'package:path/path.dart';
import 'package:ronderos/pages/SignIn.dart';
import 'package:ronderos/widgets/validators.dart';

class Edicion_usuario extends StatefulWidget {
  const Edicion_usuario({Key? key}) : super(key: key);

  @override
  State<Edicion_usuario> createState() => _Edicion_usuarioState();
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
class _Edicion_usuarioState extends State<Edicion_usuario> {
    File? image;
    UploadTask? uploadTask;

  Future pickImage() async{
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return ;
  
    final imagetemporary = File(image.path);
          setState(() => this.image = imagetemporary);
        } on PlatformException catch (e) {
          print('Fallo');
        }
      print('la ruta es: ${image}');
  }
    
  Future Alertdialogconfirm(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      
    final alertDialog = showDialog(
          context: context,
          builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(),
          title: Text("Confirmar", 
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25)),),
          content: Text("¿Deseas guardar los cambios?", 
            style: GoogleFonts.prompt(
              textStyle: TextStyle(
                fontSize: 15,
              )),),
          actions: <Widget>[
            Wrap(
              spacing: 70,
              children: [
                FlatButton(
                  onPressed:  (){
                  Navigator.of(context, rootNavigator: true).pop();
                  _Scroll123(context);
                 //   Scroll123(context);
                     },
                  child: Text(
                    'Si',
                    style: GoogleFonts.poppins(textStyle: TextStyle(
                      color: Colors.green
                    ),) 
                  )),
                FlatButton(
                  onPressed: ()=>
                  Navigator.of(context, rootNavigator: true).pop(),
                  child: Text(
                    'No', 
                    style: GoogleFonts.poppins(textStyle:TextStyle(
                      color: Colors.red,
                    ), ) 
                  )
                ),
            ],
          )
        ],
      ));
    }
  }

Future _Scroll123(BuildContext context) async{
    
        setState(()=> cargando = true);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context){
              return Center(child: CircularProgressIndicator(color: Colors.green),);
            },
          );
          await _uploadFile(context);
        Navigator.of(context, rootNavigator: true).pop();

        final snackBar = SnackBar(content: Text("Los cambios se guardaron, porfavor vuelva a logearse"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(()=> cargando = false);
        
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInPage()));
        
}

  Future _uploadFile(BuildContext context) async{
   usuarios123 userModel = usuarios123();
        setState(()=> cargando = true);
        
         if (image != null) {
           final path = 'UsuariosAppFotos/${Usuario_logeado.correo}/${Usuario_logeado.uid}.png';
           final file = File(image!.path);
           final ref = FirebaseStorage.instance.ref().child(path);
          setState(() {
            uploadTask =  ref.putFile(file);
          });

          final snapshot = await uploadTask!.whenComplete(() {});
          final URLFoto = await snapshot.ref.getDownloadURL();

              userModel.FotoMomentanea = URLFoto;

        if (userModel.FotoMomentanea != null) {
              print('salio bien:  ${userModel.FotoMomentanea}');
        } else {
          print('nada loco pipipippippipi');
        }
            setState(() {
              uploadTask = null;
            });
         } if (image == null){
          userModel.FotoMomentanea = Usuario_logeado.foto;
         }
         
      
        print("Modificación");
        
        try {
          
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
        documentReference
            .update({
              "foto" : userModel.FotoMomentanea.toString(),
              if(_nombrecontroller.text.isNotEmpty)
              "nombre" : _nombrecontroller.text,
              if(_nombrecontroller.text.isEmpty)
              "nombre": Usuario_logeado.nombre,
              if(_apellidocontroller.text.isNotEmpty)
              "apellido": _apellidocontroller.text,
              if(_apellidocontroller.text.isEmpty)
              "apellido": Usuario_logeado.apellido,
            })
            
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
            
          print('Nueva Foto: ${userModel.FotoMomentanea}');

          if (Usuario_logeado.familia != ''){
            _familiaWrapper(context);
          } else {
            return null;
          }


        } catch (e) {
          print(e);
        }
        

  }

  Future _familiaWrapper(BuildContext context) async{
    
    print(Usuario_logeado.familia);
    
      String usuarionombre = '';
      String usuarioapellido = '';

      if (_nombrecontroller.text.isEmpty) {
        usuarionombre = familiamodel.nombre!;
      } if(_nombrecontroller.text.isNotEmpty){
        usuarionombre = _nombrecontroller.text;
      }
      
      if (_apellidocontroller.text.isEmpty) {
        usuarioapellido = familiamodel.apellido!;
      } if (_apellidocontroller.text.isNotEmpty) {
        usuarioapellido = _apellidocontroller.text;
      }


    print(usuarionombre);
    try {
      DocumentReference documentReference2 =
            FirebaseFirestore.instance.collection(familiamodel.familia!).doc('${familiamodel.nombre} ${familiamodel.apellido}');
        documentReference2
            .delete()           
            .then((value) => print("User Updated${familiamodel.nombre}${familiamodel.apellido}"))
            .catchError((error) => print("Failed to update user: $error"));
    } catch (e) {
      print("asdasdasdadasasdas");
    }

    try {
      FirebaseFirestore firebaseFirestore2 = FirebaseFirestore.instance;
          // writing all the values
        if(_nombrecontroller.text.isNotEmpty)
        familiamodel.nombre = _nombrecontroller.text;
        if(_nombrecontroller.text.isEmpty)
        familiamodel.nombre = familiamodel.nombre;
        if(_apellidocontroller.text.isNotEmpty)
        familiamodel.apellido = _apellidocontroller.text;
        if(_apellidocontroller.text.isEmpty)
        familiamodel.apellido = familiamodel.apellido;
        familiamodel.arbol = familiamodel.arbol;
        familiamodel.familia = Usuario_logeado.familia;

          await firebaseFirestore2
            .collection(Usuario_logeado.familia!)
            .doc('${usuarionombre} ${usuarioapellido}')
            .set(familiamodel.toMap());

        } catch (e) {
          print(e);
          print("Fallo pipippipipipipi");
        }

     

  }

 /* ChangeUserFoto() {
    print("Modificación");
    usuarios123 userModel2 = usuarios123();
       print(userModel2.FotoMomentanea);
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("UsuariosApp").doc(Usuario_logeado.uid);
    documentReference
        .update({
          "foto" : userModel2.FotoMomentanea.toString(),
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  } */

    // User? user1 = FirebaseAuth.instance.currentUser!;
    UserModel Usuario_logeado = UserModel();
    Familiamodel familiamodel = Familiamodel();
    final user= FirebaseAuth.instance.currentUser!;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final style1 = TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
    usuarios123 userModel123 = usuarios123();
    final outlineInputBorder_enabled =OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 2.5),);
    final OutlineInputBorder_focused = OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3));
    final labelstyle1 = TextStyle(color: Colors.black45, fontSize: 18);
    final TextEditingController _passwordcontroller = TextEditingController();
    final TextEditingController _confirmpasswordcontroller = TextEditingController();
    final TextEditingController _nombrecontroller = TextEditingController();
    final TextEditingController _apellidocontroller = TextEditingController();
    bool _nombreedit = true;
    bool _apellidoedit = true;
    bool cargando = false;
    final _formKey = GlobalKey<FormState>();

    @override
    void dispose() {
      _passwordcontroller.dispose();
      _confirmpasswordcontroller.dispose();
      _apellidocontroller.dispose();
      _nombrecontroller.dispose();
      super.dispose();
    }

    @override
    void initState() {
        super.initState();
        FirebaseFirestore.instance
            .collection("UsuariosApp")
            .doc(user.uid)
            .get()
            .then((value) {
          this.Usuario_logeado = UserModel.fromMap(value.data());
          setState(() {});
        
        FirebaseFirestore.instance
            .collection(Usuario_logeado.familia!)
            .doc("${Usuario_logeado.nombre} ${Usuario_logeado.apellido}")
            .get()
            .then((value) {
          this.familiamodel = Familiamodel.fromMap(value.data());
          setState(() {});
        });
        });
      }
  


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Editar Perfil', style: GoogleFonts.balooPaaji2(textStyle:TextStyle(color: Colors.black, fontSize: 25))),
        leading: IconButton(
          onPressed: (){
             Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_sharp, color: Colors.lightGreen, size: 30,)),
      ),
      body:
        SafeArea(
          child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    const SizedBox(height: 30.0,),
                    Stack(
                      children:<Widget>[
                        Stack(
                          children:[
                        image!= null?
                            ClipOval(
                              child: Image.file(image!,
                              width: 220,
                              height: 220,
                              fit: BoxFit.cover,),
                            ): CircleAvatar(
                                    radius: 110.0,
                                    backgroundImage: NetworkImage(
                                      Usuario_logeado.foto.toString(),
                                      
                                    ),
                                  ),
                            
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [],
                                ),
                              ),
                            Container(
                              width: 220,
                              height: 220,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.white,
                                      child: InkWell(
                                        onTap:() {
                                            pickImage();
                                            },
                                        child: Icon(Icons.photo_camera, size: 70, color: Colors.greenAccent,),
                                      ),
                                    ),
                                  ],
                                )
                              
                            ),
                          
                          ]
                        )
                        //Image.file(image!, width: 100, height: 100,) 
                                               
                      ],
                    ),
                    
                      const SizedBox(height: 30.0,),
                    
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: _nombreedit?TextField(
                              enableInteractiveSelection: false,
                              focusNode: AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                labelText: Usuario_logeado.nombre,
                                labelStyle: labelstyle1,
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 3),),
                                contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _nombreedit = !_nombreedit;
                                    });
                                  }, 
                                  icon:Icon(Icons.edit))
                              ),
                            ): TextFormField(
                              controller: _nombrecontroller,
                              validator: validatenombre,
                              autofocus: true,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)) ,
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 15),
                                labelText: 'Nombre',
                                hintText: "${Usuario_logeado.nombre}",
                                hintStyle: TextStyle(color: Colors.black87, fontSize: 18),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.edit_off_rounded, 
                                    color: Colors.red ,),
                                  onPressed: (){
                                    setState(() {
                                      _nombreedit = !_nombreedit;
                                    });
                                  },
                                )
                    
                              ),
                              onChanged: (value){
                    
                              },
                            ),
                          ),
                      const SizedBox(height: 15.0,),
            
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: _apellidoedit?TextField(
                              enableInteractiveSelection: false,
                              focusNode: AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                labelText: Usuario_logeado.apellido,
                                labelStyle: labelstyle1,
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12, width: 3),),
                                contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 15),
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _apellidoedit = !_apellidoedit;
                                    });
                                  }, 
                                  icon:Icon(Icons.edit))
                              ),
                            ):TextFormField(
                              controller: _apellidocontroller,
                              validator: validateapellido,
                              autofocus: true,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent, width: 3)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 3)) ,
                                enabledBorder: outlineInputBorder_enabled,
                                focusedBorder: OutlineInputBorder_focused,
                                contentPadding: EdgeInsets.fromLTRB(20, 16, 20, 15),
                                labelText: 'Apellido',
                                hintText: "${Usuario_logeado.apellido}",
                                labelStyle: labelstyle1,
                                hintStyle: TextStyle(color: Colors.black87, fontSize: 18),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.edit_off_rounded, 
                                    color: Colors.red ,),
                                  onPressed: (){
                                    setState(() {
                                      _apellidoedit = !_apellidoedit;
                                    });
                                  },
                                )
                    
                              ),
                              onChanged: (value){
                    
                              },
                            ),
                          ),
            
                      const SizedBox(height: 25.0,),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Wrap(
                        spacing: 15,
                        children: [
                          RaisedButton(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                         builder: (context) =>
                                          HomePage123()));
                            },
                            child: const Text("CANCELAR",
                                style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Alertdialogconfirm(context);
                            },
                            color: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "GUARDAR",
                              style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                     /* Padding(
                      padding:EdgeInsets.only(top: 20),
                      child: IconButton(
                        onPressed:() {
                          ChangeUserFoto();
                        },
                        icon: Icon(Icons.person_add, size: 20,),
                        iconSize: 30,
                      ), ),*/
                    
                              ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
  

  bool passwordConfirmed(){
    if (_passwordcontroller.text.trim() == _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  } 
  
}