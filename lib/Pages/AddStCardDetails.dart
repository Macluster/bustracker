import 'package:bustracker/Models/StCardModel.dart';
import 'package:bustracker/Pages/StCardReviewPage.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Components/Button1.dart';
import '../Components/DropDownList.dart';
import '../backend/data.dart';

class AddStCardDetails extends StatefulWidget {
  String action;
  AddStCardDetails(this.action);
  @override
  State<AddStCardDetails> createState() => _AddStCardDetailsState();
}

class _AddStCardDetailsState extends State<AddStCardDetails> {
  var institutionName = TextEditingController();
  var institutuionPlace = TextEditingController();
  var HomePlace = TextEditingController();
  var issueDate = TextEditingController();
  var expiryDate = TextEditingController();
  var course = TextEditingController();
  var courseDuration = TextEditingController();
   var SearchedbusStops=[];

  String currentBusStop1 = "";
  String destinationStop1 = "";

  String currentBusStop2 = "";
  String destinationStop2 = "";

  String currentBusStop3 = "";
  String destinationStop3 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBustops();
  }

    void getBustops()async
  {
       SearchedbusStops= await SupaBaseDatabase().getBusStopName();
       setState(() {
         
       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Enter Details",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: institutionName,
                          decoration: InputDecoration(hintText: "Institutuion Name", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: institutuionPlace,
                          decoration: InputDecoration(hintText: "Instituion Place", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: course,
                          decoration: InputDecoration(hintText: "Course", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: courseDuration,
                          decoration: InputDecoration(hintText: "Course Duration", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: HomePlace,
                          decoration: InputDecoration(hintText: "Address", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: issueDate,
                          decoration: InputDecoration(hintText: "Issue Date", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.bodySmall,
                          controller: expiryDate,
                          decoration: InputDecoration(hintText: "Expiry Date", hintStyle: Theme.of(context).textTheme.bodySmall),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("Route 1"),
                        DropDownList(SearchedbusStops, currentBusStop1, "From", (e) {
                          setState(() {
                            currentBusStop1 = e.toString();
                          });
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        DropDownList(SearchedbusStops, destinationStop1, "TO", (e) {
                          setState(() {
                            destinationStop1 = e.toString();
                          });
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("Route 2"),
                        DropDownList(SearchedbusStops, currentBusStop2, "From", (e) {
                          setState(() {
                            currentBusStop2 = e.toString();
                          });
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        DropDownList(SearchedbusStops, destinationStop2, "TO", (e) {
                          setState(() {
                            destinationStop2 = e.toString();
                          });
                        }),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                    Button1("Submit", () async {
                      var obj = SupaBaseDatabase();
                      var userID = await obj.getCurrentUserId();

                      StCardModel model = StCardModel(0, userID, institutionName.text, institutuionPlace.text, HomePlace.text, issueDate.text, expiryDate.text, "pending", course.text, courseDuration.text);
                  
                      await obj.AddStCardDetails(model,widget.action);
                      int Stid = await obj.GetStIDOFStCard();
                      print(Stid);
                      await obj.AddToStudentRoutes(Stid, currentBusStop1, destinationStop1, currentBusStop2, destinationStop2,widget.action);
               
                    
                      

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StCardReviewPage("pending")));
                    })
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
