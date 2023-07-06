

import 'package:bustracker/Components/Button1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StCardReviewPage extends StatefulWidget
{

String isDoneReview="";
String displayData="";
String assistanceText="";
String contentAnimation="";
    StCardReviewPage(this.isDoneReview)
    {
      if(isDoneReview=="pending")
      {
          displayData="Your ST Card Application is being reviewed";
          assistanceText="May Take 1-2 Days to review";
          contentAnimation="assets/lottie/verifying.json";
       
      }
      else{
        displayData=isDoneReview;
        assistanceText="Call at 9895348904";
         contentAnimation="assets/lottie/error.json";
         
      }
    }

  @override
  State<StCardReviewPage> createState() => _StCardReviewPageState();
}

class _StCardReviewPageState extends State<StCardReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
           
              
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [

              SizedBox(height: 150,),

              Lottie.asset(widget.contentAnimation,height: 200),
              SizedBox(height: 20,),
      
              Text(widget.displayData,style:TextStyle(fontSize: 35,letterSpacing: 1,),textAlign: TextAlign.center,),
              SizedBox(height: 50,),
              
              
              Text(widget.assistanceText, style: TextStyle(color: Colors.grey,fontSize: 20),),
             
       
            ],),
             Button1("ReSubmit", (){Navigator.pop(context);})
          ],
        ),
      ),
    ) ,);
  }
}