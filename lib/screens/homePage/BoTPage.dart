import "dart:convert";
import 'package:drone_market/screens/homePage/Messages.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:dialog_flowtter/dialog_flowtter.dart';


class BotPage extends StatefulWidget {
  const BotPage({Key? key}) : super(key: key);

  @override
  _BotPageState createState() => _BotPageState();
}

class _BotPageState extends State<BotPage> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bot'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.deepPurple),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                  )),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      // Send user message to Flask API
      await sendUserMessageToFlask(text);
    }
  }

  sendUserMessageToFlask(String text) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.2:5000/chat'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'message': text,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          addMessage(Message(text: DialogText(text: [data['response']])));
        });
      } else {
        throw Exception('Failed to load response from Flask API');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error as needed
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
