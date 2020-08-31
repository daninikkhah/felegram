import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'chat screen',
        ),
        actions: [
          DropdownButton(
              icon: Icon(Icons.more_vert),
              iconEnabledColor: Theme.of(context).primaryIconTheme.color,
              items: [
                DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(Icons.exit_to_app),
                        const SizedBox(width: 5),
                        const Text('logout')
                      ],
                    ))
              ],
              onChanged: (value) {
                if (value == 'logout') FirebaseAuth.instance.signOut();
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/chats/V8m4e91CRW1I1jvtatwg/messages')
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, i) => Text(documents[i].data()['text']),
          );
        },
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
