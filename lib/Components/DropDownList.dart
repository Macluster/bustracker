
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropDownList extends StatefulWidget
{
  List data=[];
  String content="";
  String placeholder="";
  var onChangedFun;
  DropDownList(this.data,this.content,this.placeholder,this.onChangedFun);

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    var  screenWidth = MediaQuery.of(context).size.width;
    
    return  Container(
                    width: screenWidth - 10,
                    child: DropdownButton(
                        iconSize: 30,
                        iconEnabledColor: Colors.white,
                        hint: Text(
                          widget.content == ""
                              ? widget.placeholder
                              : widget.content,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        items: widget.data
                            .map((item) => DropdownMenuItem(
                                  value: item['name'].toString(),
                                  child: Text(
                                    item['name'].toString(),
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ))
                            .toList(),
                        onChanged: (e) {
                          setState(() {
                            widget.onChangedFun(e.toString());
                           
                          });
                        }));
  }
}