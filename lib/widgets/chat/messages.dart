import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalchat1/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        //isEqualTo: "user2@gmail.com"      .orderBy("createdAt",descending: true)

      stream: FirebaseFirestore.instance
          .collection('chat').where('Receved_email', whereIn: [user.email+"doctor2@gmail.com","doctor2@gmail.com"+user.email]).snapshots(),
      builder: (ctx , snapShot){
        if(snapShot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        final docs = snapShot.data.docs ;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            /*
            docs[index]['text'],
            "hat",
            true,
            key: ValueKey('dghhk'),

             */

            docs[index]['text'],
            docs[index]['username'],
            docs[index]['userId'] == user.uid ,
            docs[index]['email'],
            key: ValueKey('GQ3RIx7ETMiCIFaz72Yh'),

            //key: ValueKey(docs[index].documentID),

          ), //Container
        );
      },
    );
  }
}
