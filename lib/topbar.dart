import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
 // final String searchText;
  final Function() onPressedSearch;
  final Function() onPressedLocation;
  final Function(String text) handlSubmit;
  final Function(String text) onChange;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TopBar({
    super.key,
    required this.onPressedSearch, 
    required this.onPressedLocation, 
    required this.controller,
    required this.handlSubmit,
    required this.onChange,
    required this.focusNode,
  });


  
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        IconButton(
          onPressed: onPressedSearch,
          icon:const Icon(
          Icons.search,
          size: 35,
          color: Color.fromARGB(255, 245, 243, 243),
          ),
        ),
      Expanded(
        child: Container(
              padding: const EdgeInsets.only(bottom: 5.0),
              // padding: const EdgeInsets.all(10.0),
              // margin: EdgeInsets.all(10.0),
              child: TextField(
                  controller: controller,
                  onSubmitted: handlSubmit,
                  focusNode: focusNode,
                  onChanged: onChange,
                  // onTap:()=> focusNode.requestFocus(),
                  // autofocus: true,
                  style:const TextStyle(color: Color.fromARGB(255, 251, 250, 250),fontSize: 20.0),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 3.0),
                    
                    focusedBorder:UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 147, 148, 149), width: 2.0),
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.grey, width: 1.0)
                    // ),
            
                    border: InputBorder.none,
                    hintText: "Search Location...",
                    hintStyle: TextStyle(color: Color.fromARGB(255, 169, 167, 167))
                  ),     
                ),
              ), 
      ),
      Container(
        color: const Color.fromARGB(255, 204, 202, 202),
        width: 1.0,
        height: 40.0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
      ),
      IconButton(
        icon:const Icon(Icons.navigation, color:Color.fromARGB(255, 253, 252, 252),size: 40.0,),
        onPressed: onPressedLocation,
      ),
      ],
    );
  }
}