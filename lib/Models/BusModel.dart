class BusModel {
  String busName = "";
  int busId = 0;
  int busroute = 0;
  String busNumber = "";
  String busCurrentLocation = "";
  int startStop = 0;
  int endStop = 0;
  String startingTime = "";
  int availableSeats=0;
  int averageSpeed=0;
  int distanceLeft=0;
  
  BusModel(this.busId, this.busName, this.busroute, this.busNumber,
      this.busCurrentLocation, this.startStop, this.endStop, this.startingTime,this.availableSeats,this.averageSpeed,this.distanceLeft);
}
