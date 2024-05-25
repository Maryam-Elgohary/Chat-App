import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const screenRoute = 'chat_screen';
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messagesStreams() async {
  //   await for (var snapshot in _firestore.collection("messages").snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset(
              "images/logo.png",
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text("MessageMe")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MessageStreamBuilder(),
          Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.orange, width: 2))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextcontroller,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      hintText: "Write your message here...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      messageTextcontroller.clear();
                      _firestore.collection("messages").add({
                        'text': messageText,
                        'sender': signedInUser.email,
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text(
                      "send",
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageLine> messageWidgets = [];

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }

          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUSer = signedInUser.email;

            final messageWidget = MessageLine(
              sender: messageSender,
              text: messageText,
              isMe: currentUSer == messageSender,
            );
            messageWidgets.add(messageWidget);
          }
          return Expanded(
              child: ListView(
                  reverse: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: messageWidgets));
        });
  }
}

class MessageLine extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool isMe;

  const MessageLine({super.key, this.sender, this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.yellow[900]),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? Colors.blue[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
