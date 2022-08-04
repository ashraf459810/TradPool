import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';

Widget textform(
    {TextEditingController controller,
    Function function,
    Key key,
    String hint,
    Color hintColor,
    double hintsize,
    String validation,
    EdgeInsetsGeometry padding,
    int maxlines,
    bool issecure}) {
  return TextFormField(
   
    key: key,
    style: TextStyle(color: Colors.black, fontSize: 14.sp),
    obscureText: issecure ?? false,
    keyboardType: validation == "number"
        ? TextInputType.phone
        : validation == "name"
            ? TextInputType.name
            : validation == "email"
                ? TextInputType.emailAddress
                : TextInputType.text,
    decoration: InputDecoration(
    
        errorStyle: TextStyle(fontSize: 10.sp),
        contentPadding: padding ?? EdgeInsets.all(w(5)),
        border: InputBorder.none,
        hintText: hint,
        isDense: true,
        hintStyle: TextStyle(
          color: hintColor ?? Colors.black,
          fontSize: hintsize ?? 12.sp,
        )),
    controller: controller,

    validator: validation == "password"
        ? passwordvalidator
        : validation == "email"
            ? emailvalidator
            : validation == "number"
                ? numbervalidator
                : defaultvalidation,
    // expands: true,
    maxLines: maxlines ?? 1,
    minLines: null,
    onChanged: (value) {
      function(value);
    },
  );
}

String passwordvalidator(String value) {
  if (value.isEmpty) {
    return "enter your password";
  }
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regExp = RegExp(pattern);
  bool validpassword = regExp.hasMatch(value);
  if (validpassword == true) {
    return null;
  } else {
    return "passwrod lenght 8 contains numbers capital and small letters";
  }
}

String emailvalidator(String value) {
  if (value.isEmpty) {
    return 'Enter Your Email';
  }

  bool emailValid = EmailValidator.validate(value);

  if (emailValid == true) {
    return null;
  } else {
    return "Enter a valid email";
  }
}

String numbervalidator(String value) {
  if (value.isEmpty) {
    return "please enter a number";
  }
  if (int.parse(value) <= 0) {
    return "please Enter Positive Number";
  }
  return null;
}

String defaultvalidation(String value) {
  return value;
}
