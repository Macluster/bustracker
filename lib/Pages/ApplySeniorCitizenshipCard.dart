import 'package:bustracker/Models/SeniorCitizenModel.dart';
import 'package:bustracker/Models/UserModel.dart';
import 'package:bustracker/Pages/AddSeniorCitizenDetails.dart';
import 'package:bustracker/Pages/SeniorCitizenReviewPage.dart';
import 'package:bustracker/Pages/ShowSeniorCitizenCard.dart';
import 'package:flutter/material.dart';

import '../Components/Button1.dart';
import '../backend/SupaBaseDatabase.dart';
import '../backend/SupaBaseStorage.dart';

class ApplySeniorCitizenshipCard extends StatefulWidget {
  @override
  State<ApplySeniorCitizenshipCard> createState() =>
      _SeniorCitizenshipCardState();
}

class _SeniorCitizenshipCardState extends State<ApplySeniorCitizenshipCard> {

    bool isDoneUploadingAdhar = false;
    bool isRecordExist=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise();
  
  }

  

  void initialise() async {
    var isDoneReview = await SupaBaseDatabase().GetStatusOFSenioCitizenShipCard();
    if(isDoneReview["status"]!="")
    {
      print(isDoneReview);
      isRecordExist=true;

    }
    
    if (isDoneReview['status'] == "pending") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeniorCitizenReviewPage("pending")));
    } else if (isDoneReview['status'] == "done") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ShowSeniorCitizenCard()));
    } else if (isDoneReview['status'] ==
        "error") //Condition When  there is a problem with  application so vale of isDonereview will be the problem with  the application
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SeniorCitizenReviewPage(isDoneReview['message'] as String)));
    }

    var adhar = await SupabaseStorage().checkItemExist("adhar.jpg");

    setState(() {
      isDoneUploadingAdhar = adhar;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Things Required for Senior Citizen Card",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    RequirementCard(
                        content: "Adhar Card",
                        image: "assets/icons/form.png",
                        ontap: (val) {
                          setState(() {
                            isDoneUploadingAdhar = val;
                          });
                        },
                        isDoneUploading: isDoneUploadingAdhar,
                        orderKey: UniqueKey()),
                  ],
                ),
                isDoneUploadingAdhar
                    ? Button1("Continue", () async {
                        var obj = SupaBaseDatabase();
                        var userID = await obj.getCurrentUserId();
                        UserModel userdata = await obj.getUserData();
                        print(userdata.userDob);
                        var age =
                            int.parse(DateTime.now().toString().split("-")[0]) -
                                int.parse(userdata.userDob.split("-")[0]);

                        SeniorCitizenModel model =
                            SeniorCitizenModel(0, userID, "pending", "", age);
                        if(!isRecordExist)
                        {
                              await obj.AddSeniorCitizenDetails(model);
                       
                              setState(() {
                                       isRecordExist=true;
                              });
                        }
                       
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SeniorCitizenReviewPage("pending")));
                      })
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequirementCard extends StatefulWidget {
  String content = "";
  String image;
  var ontap;
  bool isDoneUploading;
  final Key orderKey;

  RequirementCard(
      {required this.content,
      required this.image,
      required this.ontap,
      required this.isDoneUploading,
      required this.orderKey})
      : super(key: orderKey);

  @override
  State<RequirementCard> createState() =>
      _RequirementCardState(this.isDoneUploading);
}

class _RequirementCardState extends State<RequirementCard> {
  bool isDoneUploading;
  @override
  _RequirementCardState(this.isDoneUploading);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool result = await SupabaseStorage().uploadAdhar();
        isDoneUploading = result;

        widget.ontap(isDoneUploading);
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.content,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      isDoneUploading
                          ? const Icon(
                              Icons.done,
                              color: Colors.green,
                            )
                          : const Icon(Icons.arrow_right)
                    ],
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 50, left: 30),
                  child: Image.asset(
                    widget.image,
                    height: 60,
                    width: 60,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
