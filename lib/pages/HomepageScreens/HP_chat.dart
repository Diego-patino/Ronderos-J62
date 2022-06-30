import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRonderos extends StatefulWidget {
  const ChatRonderos({Key? key}) : super(key: key);

  @override
  State<ChatRonderos> createState() => _ChatRonderosState();
}

class _ChatRonderosState extends State<ChatRonderos> {

 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 120,
            margin: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Stack(
              children: [
                Container(
                  height: 124.0,
                  margin: EdgeInsets.only(left: 46),
                  constraints: new BoxConstraints.expand(),
                  child: Container(
                  margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0,),
                        
                        Text("data",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0, 
                            fontWeight: FontWeight.w600)
                          ),
                        ),
                        SizedBox(height: 10.0,),

                        Text('Hombres Trabajando',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white, 
                            fontSize: 12.0, 
                            fontWeight: FontWeight.w400)
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      )
                    ]
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  alignment: FractionalOffset.centerLeft,
                  child: Container(
                    height: 92,
                    width: 92,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(
                          "https://media.discordapp.net/attachments/856312697112756247/991186057766899762/unknown.png",
                        ) 
                    ),
                  ),
                )
              ],
            ),

          ),
        ),
      ],
    );
  }
}