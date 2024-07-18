// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:osama_consul/features/HomeLayout/presentation/bloc/homelayout_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../core/network/firebase_helper.dart';
// import '../../../Home Layout Admin/presentation/widgets/message_bubble.dart';

// class ChatTabb extends StatefulWidget {
//   const ChatTabb({super.key});

//   @override
//   State<ChatTabb> createState() => _ChatTabbState();
// }

// class _ChatTabbState extends State<ChatTabb> {
//   final controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text('Chat'),
//         ),
//         body: BlocBuilder<HomelayoutBloc, HomelayoutState>(
//             builder: (context, state) {
//           if (state is ChatLoaded) {
//             return Column(
//               children: <Widget>[
//                 Expanded(
//                     child: ListView.builder(
//                   reverse: true,
//                   itemCount: state.messages.length,
//                   itemBuilder: (ctx, index) {
//                     // final message = Message.fromDocument(chatDocs[index]);
//                     // final isMe = message.senderId == _auth.currentUser!.uid;
//                     final isMe = (HomelayoutBloc.get(context).id) ==
//                         (state.messages[index].senderId);
//                     return MessageBubble(
//                         state.messages[index].text ?? '', isMe);
//                   },
//                 )),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: <Widget>[
//                       IconButton(
//                         icon: const Icon(Icons.mic),
//                         onPressed: () {},
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.stop),
//                         onPressed: () {},
//                       ),
//                       Expanded(
//                         child: TextField(
//                           controller: controller,
//                           decoration: const InputDecoration(
//                               labelText: 'Send a message...'),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.send),
//                         onPressed: () async {
//                           SharedPreferences pref =
//                               await SharedPreferences.getInstance();

//                           controller.text.trim().isNotEmpty
//                               ? FirebaseHelper().sendMessage(
//                                   pref.getString('email')!, controller.text)
//                               : null;
//                           controller.clear();
//                           HomelayoutBloc.get(context).add(GetMessagesEvent());
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return const CircularProgressIndicator();
//           }
//         }));
//   }
// }
