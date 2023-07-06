
import 'package:dropdown_textfield/dropdown_textfield.dart';
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
    
    return   DropDownTextField(
                    enableSearch: true,
                    searchDecoration: InputDecoration(
                      hintText:widget.placeholder),
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  dropDownList: [
                    for(var item in widget.data)
                    DropDownValueModel(name: item, value: item)
                  ],
                  onChanged: (ele){widget.onChangedFun(ele.value);},
                  
                  );
  }
}