import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loadbalancer/buttons.dart';
import 'package:loadbalancer/request.dart';
import 'package:loadbalancer/textfields.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class EndUser extends StatefulWidget {
  
  const EndUser({super.key});
  @override
  State<EndUser> createState() => _EndUserState();
}

class _EndUserState extends State<EndUser> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Map<String, dynamic> loginData = {
    "email": "",
    "password": ""
  };

void clearTextFields(){
    loginFormKey.currentState!.reset();
}


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: loginFormKey,
      child: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: <Widget>[
          const Text(
            'End User',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          
          Textfields(placeholder: "Username", containWidth: 300, fieldDescription: "", controller: userNameController, validator: (value){
            if(value == null || value.isEmpty){
              return "Please enter a valid username";
            }
            return null;
          }),
          //const SizedBox(height: 10),
          //TextFormField()
          Textfields(placeholder: "Password", containWidth: 300, fieldDescription: "", controller: passwordController, validator: (value){
            if(value == null || value.isEmpty){
              return "Please enter a valid password";
            }
            return null;
          }),
          const SizedBox(height: 30),

          // GestureDetector(
          //   onTap: () {
          //     submitRequest();
          //     //sendMessage(messageController.text);
          //   },
          //   child: Buttons(btnName: "Submit Request", colour: Colors.black, containWidth: 300, containHeight: 50, radius: 20),
          // ),

         
          // StreamBuilder(
          //     stream: request.stream,
          //     builder: (context, snapshot) {
          //       return Text(snapshot.hasData ? '${snapshot.data}' : '');
          //     },
          //   );
          
          Buttons(
            btnName: "Submit", 
            colour: Colors.black, 
            containWidth: 500, 
            containHeight: 50,
            radius: 30, 
            onPressed: (){

              // if(loginFormKey.currentState!.validate()){
              //   loginData["email"] = userNameController.text;
              //   loginData["password"] = passwordController.text;
              //   postLoginRequest("http://192.168.0.13:8080/api/v1/auth/authenticate", loginData).then((value){
                String username = userNameController.text;
              //   if (value != null) {
              //   print(value);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text("Login Successful"),
                      content: Text("Welcome $username"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              // } else {
              //   print("Received null value from server");
              // }
              // }).catchError((error) {
              //     print("Error: $error");
              //   // });
                
              //   print("Login Successful");
              // }

              clearTextFields();
            }),
          
        ],
      ),
      
      ),
      ),
    );
  }
}