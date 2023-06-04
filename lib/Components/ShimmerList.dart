import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {

 double height=0;
 double width=0;
Axis   axis=Axis.horizontal;
double ContainerHeight=0;

    ShimmerList({ required this.height,required  this.width,required this.axis,required this.ContainerHeight});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ContainerHeight,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: axis,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Color.fromARGB(255, 236, 234, 234),
                highlightColor: Color.fromARGB(255, 238, 223, 223),
                child: Container(
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 238, 236, 236), borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            );
          }),
    );
  }
}
