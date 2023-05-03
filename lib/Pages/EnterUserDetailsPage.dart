import 'package:bustracker/Components/Button1.dart';
import 'package:bustracker/Models/UserModel.dart';
import 'package:bustracker/backend/SupaBaseDatabase.dart';
import 'package:flutter/material.dart';

class EnterUserDetailsPage extends StatefulWidget {
  @override
  State<EnterUserDetailsPage> createState() => _EnterUserDetailsPageState();
}

class _EnterUserDetailsPageState extends State<EnterUserDetailsPage> {
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var dob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: dob,
                        decoration: InputDecoration(
                            hintText: "DOB",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: phone,
                        decoration: InputDecoration(
                            hintText: "Phone Number",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: address,
                        decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        style: Theme.of(context).textTheme.bodySmall,
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: Theme.of(context).textTheme.bodySmall),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                  Button1("Submit", () {
                    var model = UserModel(0, name.text, address.text, dob.text,
                        phone.text, email.text);
                    SupaBaseDatabase().AddUserDetails(model);
                  })
                ],
              ),
            )),
      ),
    );
  }
}
