import 'package:bustracker/Components/Button1.dart';
import 'package:bustracker/backend/SupaBaseStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplyStCard extends StatefulWidget {
  @override
  State<ApplyStCard> createState() => _ApplyStCardState();
}

class _ApplyStCardState extends State<ApplyStCard> {
  bool isDoneUploadingBirth = false;
  bool isDoneUploadingIdcard = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialise();
  }

  void initialise() async {
 var birth = await SupabaseStorage().checkItemExist("birthCertificate.jpg");
   var id = await SupabaseStorage().checkItemExist("IdCard.jpg");
    setState(() {
        isDoneUploadingBirth=birth;
        isDoneUploadingIdcard=id;

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
                      content: "Birth Certificate",
                      image: "assets/icons/award.png",
                      ontap: (val) {
                        setState(() {
                          isDoneUploadingBirth = val;
                        });
                      },
                      isDoneUploading: isDoneUploadingBirth,
                    orderKey:  UniqueKey()
                    ),
                    RequirementCard(
                      content: "School Id Card",
                      image: "assets/icons/id-card.png",
                      ontap: (val) {
                        setState(() {
                          isDoneUploadingIdcard = val;
                        });
                      },
                      isDoneUploading: isDoneUploadingIdcard,
                      orderKey: UniqueKey()
                    ),
                  ],
                ),
                isDoneUploadingBirth && isDoneUploadingIdcard ? Button1("Continue", () {}) : Container()
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

  RequirementCard({required this.content, required this.image, required this.ontap, required this.isDoneUploading,required this.orderKey}): super(key: orderKey);

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
        if (widget.content == "Birth Certificate") {
          bool result = await SupabaseStorage().uploadBirthCertificate();
          isDoneUploading = result;

          widget.ontap(isDoneUploading);
          setState(() {});
        } else {
          bool result = await SupabaseStorage().uploadIdCard();
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
                    height: 80,
                    width: 80,
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
