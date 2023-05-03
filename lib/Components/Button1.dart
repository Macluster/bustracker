
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget
{
  String content="";
  var  ontap;
  Button1(this.content,this.ontap);
 
  @override
  Widget build(BuildContext context) {

      return   GestureDetector(
                          onTap: (){
                            ontap();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.infinity,
                            color: Colors.amber,
                            child: Text(content),
                          ),
                        );
  }

}