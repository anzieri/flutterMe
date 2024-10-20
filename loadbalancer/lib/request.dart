import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Map<String,dynamic>> postLoginRequest(String url, Map<String, dynamic> data) async {
    try{
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {

      print("Request successful");
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send json');
    }
    }catch(error){
      print('Failed to send json: $error');
      return {"error": error};
    }
  }
  
  Future<String> sendMessage(String tea) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.13:8081/'),
      body: jsonEncode(({"input": tea})),
    );
    if (response.statusCode == 200) {
      return "success";
      //jsonDecode(response.body)['reply'];
    } else {
      throw Exception('Failed to load response');
    }
  }

   Future<String> message(String tea) async {

    final port = 8081;
    final uri = Uri.parse('ws://192.168.0.13:$port');
    final request = WebSocketChannel.connect(uri);
    //echo.websocket.events
    try{
      request.sink.add(tea);
      request.stream.listen((event) {
        request.sink.add(tea);
        //request.sink.close(status.goingAway);
      print(event);
    });
  
    }catch(e){
      print(e);
    }
    
    print('Sent: $tea');
  return "success";
}


  Future<String> missedMessage(String tea) async {
  final port = 8080;
  // final uri = Uri.parse('ws://192.168.0.13:$port/chat'); // Replace with actual endpoint from Java server
  // final channel = WebSocketChannel.connect(uri);

  // try {
  //   channel.sink.add(tea);

  //   channel.stream.listen((event) {
  //     print("Received: $event");
  //   });

  //   return "Success";
  // } catch (e) {
  //   print(e);
  //   return "Error: $e";
  // } finally {
  //   await channel.sink.close();
  // }

  final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.0.13:$port/chat'));

  channel.stream.listen((message) {
    print(message); // Handle incoming messages
  });

  channel.sink.add(jsonEncode({'message': 'Hello from Flutter'}));
  return "success";
}

  Future<String> otherRequest(String tea) async {
  final socket = await Socket.connect('192.168.0.13', 8081);
  try{
    socket.writeln(tea);
    await socket.close();
  }catch(e){
    print(e);
  }
    
    return "success";
  }

//'192.168.0.13'