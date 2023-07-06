import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/Pages/PostPayamentPage.dart';
import 'package:bustracker/Pages/TicketPage.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
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
  int fare = 0;

  bool stCardSwitch = false;
  bool stCardSwitchValue = false;

  bool ElderCardSwitch = false;
  bool ElderCardSwitchValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    var value = await SupaBaseDatabase().lookIfStConssesionAvailable();
    var value2 = await SupaBaseDatabase().lookIfElderConssesionAvailable();
    setState(() {
      stCardSwitch = value;
      ElderCardSwitch = value2;
      model = context.read<PayementProvider>().getPayementData();
      fare = model.fare;
    });
  }

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
              children: [
                Text(
                  "Select a payment Method",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 40,
                ),
                stCardSwitch == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Apply StCard Conssesion"),
                          Switch(
                              value: stCardSwitchValue,
                              onChanged: (value) {
                                if (value == true) {
                                  setState(() {
                                    fare = ((30 / 100) * model.fare).round();
                                    stCardSwitchValue = value;
                                  
                                  });
                                } else {
                                  setState(() {
                                    fare = model.fare;
                                    stCardSwitchValue = value;
                               
                                  });
                                }
                              }),
                        ],
                      )
                    : Container(),
                ElderCardSwitch == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Apply Elder Conssesion"),
                          Switch(
                              value: ElderCardSwitchValue,
                              onChanged: (value) {
                                if (value == true) {
                                  setState(() {
                                    fare = ((30 / 100) * model.fare).round();
                                    ElderCardSwitchValue = value;
                                  });
                                
                                } else {
                                  setState(() {
                                    fare = model.fare;
                                    ElderCardSwitchValue = value;
                                  });
                               
                                }
                              }),
                        ],
                      )
                    : Container(),
                fare == fare ? AmountoToPay() : Container(),
                const SizedBox(
                  height: 40,
                ),
                PaymentMethodCard("PayPal", 'assets/icons/paypal.png',fare),
                const SizedBox(
                  height: 10,
                ),
                PaymentMethodCard("Visa", 'assets/icons/visa.png',fare),
                const SizedBox(
                  height: 10,
                ),
                PaymentMethodCard("UPI", 'assets/icons/upi.png',fare)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget AmountoToPay() {
    
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
          ],
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        "$fare Rs",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  String title;
  String icon;
  int fare;

  PaymentMethodCard(this.title, this.icon,this.fare);

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
            onTap: () {
                context
                                        .read<PayementProvider>()
                                        .setFare(fare);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostPaymentPage()));
            },
            child: Icon(Icons.arrow_forward)),
      ),
    );
  }
}
