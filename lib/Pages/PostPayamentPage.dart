import 'package:bustracker/Components/Button1.dart';
import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Pages/Homepage.dart';
import 'package:bustracker/Providers/UserProvider.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Providers/PaymentProvider.dart';

class PostPaymentPage extends StatelessWidget {
  PostPaymentPage();

  void addData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Payment Page",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Card Number"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "CVV"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Expiry Date",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 50,
                          child: TextField(
                            decoration: InputDecoration(hintText: "day"),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("/"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 50,
                          child: TextField(
                            decoration: InputDecoration(hintText: "day"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    int id = await SupaBaseDatabase().getCurrentUserId();
                    var model =
                        context.read<PayementProvider>().getPayementData();
                    //SupaBaseDatabase().Addpayement(
                     ///   id, model.busId, model.fare, model.from, model.to);
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>PayementDonePage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    color: Colors.amber,
                    width: double.infinity,
                    child: Text("Pay Now"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PayementDonePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  
    return Scaffold(
      body: SafeArea(
        child: SizedBox(width: double.infinity, 
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
        
                 Container(
                  margin: EdgeInsets.all(20),
                  child: Text("Payment done",style: TextStyle(fontSize: 40),)),
              Center(child: Lottie.asset("assets/lottie/done.json",height: 250)),
              Button1("Okay", (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));
              })
            ],
          ),
        ),),
      ),
    );
  }

}
