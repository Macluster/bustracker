import 'package:bustracker/Models/BusModel.dart';
import 'package:bustracker/Models/PaymentModel.dart';
import 'package:flutter/material.dart';

class PayementProvider extends ChangeNotifier
{

PayementModel model=PayementModel(0,0,0, "","",20);


PayementModel getPayementData()
{
return model;
}


setBusId(int busId)
{
model.busId=busId;
}

setUserId(int userId)
{
  model.userId=userId;
}

setfromBusStop(String from)
{
  model.from=from;
}

setToBusStop(String to)
{
  model.to=to;
}

setFare(int fare)
{
  model.fare=fare;
}


}