import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget(
      {Key? key,
        required this.controller,
        required this.textInputType,
        required this.obscureText,
        required this.labelText,
        this.prefixPath,
        this.padding=10,
        this.hintText,
        this.suffixPath,
        this.suffixIcon,
        this.onTap,
        this.onChange,
        required this.validator,
      })
      : super(key: key);
  TextEditingController controller;
  TextInputType textInputType;
  bool obscureText = false;
  double padding;
  String labelText;
  String? hintText;
  String? prefixPath;
  String? suffixPath;
  Widget? suffixIcon;
  void Function()? onTap;
  String? Function(String?)? validator;
  Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection:TextDirection.rtl ,

      controller: controller,
      keyboardType: textInputType,
      style: TextStyle(color: Colors.deepPurple, fontSize: 16),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:const EdgeInsetsDirectional.only(start: 7),

        labelText: labelText,
        hintText:hintText ,


        //hintTextDirection:TextDecoration. ,
        hintStyle: TextStyle(


          color: Colors.deepPurple,
          fontSize: 16,
        ),
        labelStyle: TextStyle(
          color: Colors.deepPurple,
          fontSize: 16,
        ),
        prefixIcon:prefixPath!=null? iconPrefixOrSuffix(path: prefixPath.toString(),padding: padding):null,
        suffixIcon:
        suffixIcon==null? suffixPath!=null? iconPrefixOrSuffix(path: suffixPath.toString(),padding: padding):null:suffixIcon,



        filled: true,
        errorMaxLines: 3,

        floatingLabelStyle: TextStyle(
          color:  Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
              style: BorderStyle.solid,color:  Colors.deepPurple,width: 1
          ),
          borderRadius: BorderRadius.circular(25),

        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid,color:  Colors.deepPurple,width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide:
          BorderSide(style: BorderStyle.solid, width: 1, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid,color:  Colors.deepPurple,width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(style: BorderStyle.solid,color:  Colors.deepPurple,width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        prefixIconColor:  Colors.deepPurple,
        suffixIconColor:  Colors.deepPurple,
      ),
      onTap: onTap,
      validator: validator,
      onChanged:onChange ,

    );
  }

  Widget iconPrefixOrSuffix({required String path,double padding =10}) {
    return Padding(
      padding:  EdgeInsets.all(padding),
      child: Container(
        width: 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(path), scale: 0.2, fit: BoxFit.contain)),
      ),
    );
  }
}