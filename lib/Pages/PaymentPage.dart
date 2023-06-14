import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Pages/PostPayamentPage.dart';
import 'package:bustracker/Pages/TicketPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/PaymentProvider.dart';

class PayementPage extends StatefulWidget {


  PayementPage();
  @override
  State<PayementPage> createState() => _PayementPageState();
}

class _PayementPageState extends State<PayementPage> {

  late PayementModel model;


  @override
  Widget build(BuildContext context) {

    
      setState(() {
          model=context.read<PayementProvider>().getPayementData();
      });
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "Select a payment Method",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              const   SizedBox(
                  height: 40,
                ),
                AmountoToPay(context,model.fare),
             const   SizedBox(
                  height: 40,
                ),
                PaymentMethodCard("PayPal", 'assets/icons/paypal.png'),
            const    SizedBox(
                  height: 10,
                ),
                PaymentMethodCard("Visa", 'assets/icons/visa.png'),
            const    SizedBox(
                  height: 10,
                ),
                PaymentMethodCard("UPI", 'assets/icons/upi.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget AmountoToPay(BuildContext context,int fare) {
  return Container(
    alignment: Alignment.center,
    height: 200,
    width: double.infinity,
    decoration: const BoxDecoration(
      
      boxShadow: [
      BoxShadow(
          spreadRadius: 5,
          blurRadius: 4,
          color: Color.fromARGB(255, 244, 232, 232))
    ], color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Text(
      "$fare Rs",
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  );
}

class PaymentMethodCard extends StatelessWidget {
  String title;
  String icon;


  PaymentMethodCard(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(color: Colors.white),
      child: ListTile(
        leading: Image.asset(
          icon,
          height: 30,
          width: 30,
        ),
        title: Text(title),
        trailing: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPaymentPage()));
          },
          child: Icon(Icons.arrow_forward)),
      ),
    );
  }
}
