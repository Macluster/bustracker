
import 'package:flutter/material.dart';

class Button2 extends StatelessWidget
{
  String content="";
  var  ontap;
  Button2(this.content,this.ontap);
 
  @override
  Widget build(BuildContext context) {

      return   GestureDetector(
                          onTap: (){
                            ontap();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: double.infinity,
                            color: Colors.amber,
                            child: Text(content),
                          ),
                        );
  }

}