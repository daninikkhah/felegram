import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chat screen'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('/chats/V8m4e91CRW1I1jvtatwg/messages')
                    .snapshots(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  final documents = streamSnapshot.data.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, i) =>
                        Text(documents[i].data()['text']),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.animation),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/V8m4e91CRW1I1jvtatwg/messages')
              .add({'text': 'dummy message'});
        },
      ),
    );
  }
}
