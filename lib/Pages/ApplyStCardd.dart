import 'package:bustracker/Components/Button1.dart';
import 'package:bustracker/Pages/AddStCardDetails.dart';
import 'package:bustracker/Pages/ShowStCardPage.dart';
import 'package:bustracker/Pages/StCardReviewPage.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:bustracker/backend/SupaBaseStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplyStCard extends StatefulWidget {
  @override
  State<ApplyStCard> createState() => _ApplyStCardState();
}

class _ApplyStCardState extends State<ApplyStCard> {
  bool isDoneUploadingPhoto = false;
  bool isDoneUploadingForm = false;
   bool isRecordExist=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise();
  }

  void initialise() async {
    var isDoneReview = await SupaBaseDatabase().GetStatusOFStCard();
       if(isDoneReview["status"]!="")
    {
      print(isDoneReview);
      isRecordExist=true;

    }
    if (isDoneReview['status'] == "pending") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StCardReviewPage("pending")));
    } else if (isDoneReview['status']  == "done") {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowStCardPage()));
    } else if (isDoneReview['status'] == "error") //Condition When  there is a problem with  application so vale of isDonereview will be the problem with  the application
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StCardReviewPage(isDoneReview['message'] as String )));
    }

    var birth = await SupabaseStorage().checkItemExist("Photo.jpg");
    var id = await SupabaseStorage().checkItemExist("Form.jpg");
    setState(() {
      isDoneUploadingPhoto = birth;
      isDoneUploadingForm = id;
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
                      "Things Required for ST Card",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    RequirementCard(
                        content: "Passport Size Photo",
                        image: "assets/icons/picture.png",
                        ontap: (val) {
                          setState(() {
                            isDoneUploadingPhoto = val;
                          });
                        },
                        isDoneUploading: isDoneUploadingPhoto,
                        orderKey: UniqueKey()),
                    RequirementCard(
                        content: "School Form",
                        image: "assets/icons/form.png",
                        ontap: (val) {
                          setState(() {
                            isDoneUploadingForm = val;
                          });
                        },
                        isDoneUploading: isDoneUploadingForm,
                        orderKey: UniqueKey()),
                  ],
                ),
                isDoneUploadingPhoto && isDoneUploadingForm
                    ? Button1("Continue", () {
                        if(isRecordExist)
                        {
                            
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddStCardDetails("update")));
                              setState(() {
                                       isRecordExist=true;
                              });
                        }
                        else{
                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddStCardDetails("insert")));
                        }
                      
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

  RequirementCard({required this.content, required this.image, required this.ontap, required this.isDoneUploading, required this.orderKey}) : super(key: orderKey);

  @override
  State<RequirementCard> createState() => _RequirementCardState(this.isDoneUploading);
}

class _RequirementCardState extends State<RequirementCard> {
  bool isDoneUploading;
  @override
  _RequirementCardState(this.isDoneUploading);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var result;
        if (widget.content == "Passport Size Photo") {
          bool result = await SupabaseStorage().uploadPhoto();
          isDoneUploading = result;

          widget.ontap(isDoneUploading);
          setState(() {});
        } else {
          bool result = await SupabaseStorage().uploadForm();
          isDoneUploading = result;
          widget.ontap(isDoneUploading);
          setState(() {});
        }
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
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
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
