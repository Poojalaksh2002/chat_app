import 'dart:ffi';

import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
User? user;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messageFieldController = TextEditingController();

  late String textMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  // void getAllMessages() async {
  //   var snapshot = await fireStore.collection('chats').snapshots();
  //   await for (var data in snapshot) {
  //     print('CHATS:: ${data.size}'); // it returns docs object wholly
  //     for (var doc in data.docs) {
  //       print(
  //           'CHATS:: ${doc.data()}'); // it returns data present in a individual doc object
  //     }
  //   }
  // }

  void getCurrentUser() async {
    try {
      var userRes = await auth.currentUser;
      if (userRes != null) {
        user = userRes;

        print('USER:: $user');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                try {
                  await auth.signOut();

                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilderCode(
              fireStore: fireStore,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageFieldController,
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageFieldController.clear();
                      fireStore
                          .collection('chats')
                          .add({'email': user!.email, 'message': textMessage});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamBuilderCode extends StatelessWidget {
  const StreamBuilderCode({
    super.key,
    required this.fireStore,
  });

  final FirebaseFirestore fireStore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('chats').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final docDatas = snapshot.data!.docs.reversed;

            List<messageBubbleContainer> messageList = [];
            for (var docData in docDatas!) {
              var data = docData.data() as Map<String, dynamic>;
              final messageEmail = data['email'];
              final messageText = data['message'];

              final messageListWidget = messageBubbleContainer(
                  messageText: messageText,
                  messageEmail: messageEmail,
                  isMe: messageEmail == user!.email);
              messageList.add(messageListWidget);
            }
            return Expanded(
              child: ListView(
                reverse: true,
                children: messageList,
              ),
            );
          } else {
            if (!snapshot.hasData) {
              return Text('NoData');
            }
          }
          return Center(child: Text('Unexpected state.'));
        });
  }
}

class messageBubbleContainer extends StatelessWidget {
  const messageBubbleContainer({
    super.key,
    required this.isMe,
    required this.messageText,
    required this.messageEmail,
  });
  final bool isMe;
  final String? messageText;
  final String? messageEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Text('$messageEmail'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isMe ? Colors.lightBlueAccent : Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$messageText'),
              )),
        ),
      ],
    );
  }
}
