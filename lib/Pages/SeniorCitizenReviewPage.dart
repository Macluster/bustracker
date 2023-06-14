

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SeniorCitizenReviewPage extends StatefulWidget
{

String isDoneReview="";
String displayData="";
String assistanceText="";
String contentAnimation="";
 SeniorCitizenReviewPage(this.isDoneReview)
    {
      if(isDoneReview=="pending")
      {
          displayData="Your Senior Citizen card Application is being reviewed";
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
  State<SeniorCitizenReviewPage> createState() => _SeniorCitizenReviewPageState();
}

class _SeniorCitizenReviewPageState extends State<SeniorCitizenReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
          Lottie.asset(widget.contentAnimation,height: 200),
          SizedBox(height: 20,),
      
          Text(widget.displayData,style:TextStyle(fontSize: 35,letterSpacing: 1,),textAlign: TextAlign.center,),
          SizedBox(height: 50,),
          
          
          Text(widget.assistanceText, style: TextStyle(color: Colors.grey,fontSize: 20),)
       
        ],),
      ),
    ) ,);
  }
}