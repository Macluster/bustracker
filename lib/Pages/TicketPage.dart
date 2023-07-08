import 'package:bustracker/Models/PaymentModel.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:bustracker/main.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {


  

  PayementModel model;
  TicketPage(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Ticket",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TheTicket(model),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
   MyHomePage(title: "") ), (Route<dynamic> route) => false);
                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    color: Colors.amber,
                    width: double.infinity,
                    child: Text("Save Ticket"),
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

class TheTicket extends StatefulWidget {

  late PayementModel  model;
  TheTicket(this.model);

  @override
  State<TheTicket> createState() => _TheTicketState();
}

class _TheTicketState extends State<TheTicket> {
  String busName="";

  getBusname()async
  {
    busName=await SupaBaseDatabase().getBusNameUsingId(widget.model.busId);
    setState(() {
      
    });
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusname();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      height: 500,
      width: screenWidth,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    spreadRadius: 3,
                    blurRadius: 3,
                    color: Color.fromARGB(255, 240, 230, 230))
              ]),
              height: 500,
              width: screenWidth - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children:  [
                            const    Icon(
                                  Icons.bus_alert_sharp,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                           const     SizedBox(
                                  width: 10,
                                ),
                                Text(busName),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                         const   SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.model.from,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                             const   Icon(
                                  Icons.arrow_forward,
                                  color: Colors.red,
                                ),
                                Text(
                                widget.model.to,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )
                              ],
                            ),
                          const  SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "OCT 21,10:30 Am",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  "OCT 21,10:30 Am",
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          const  SizedBox(
                              height: 50,
                            ),
                            Text(
                              widget.model.fare.toString(),
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),

                            SizedBox(height: 20,),
                            Text("OCT 21,10:30" ,style: TextStyle(fontSize: 17),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Image.asset('assets/icons/barcode.jpg')
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          color: Color.fromARGB(255, 233, 228, 228),
                          offset: Offset(-4, 0))
                    ],
                    color: Color.fromARGB(255, 252, 247, 247),
                    borderRadius: BorderRadius.all(Radius.circular(25)))),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1,
                          color: Color.fromARGB(255, 233, 228, 228),
                          offset: Offset(4, 0))
                    ],
                    color: Color.fromARGB(255, 252, 247, 247),
                    borderRadius: BorderRadius.all(Radius.circular(25)))),
          ),
        ],
      ),
    );
  }
}
