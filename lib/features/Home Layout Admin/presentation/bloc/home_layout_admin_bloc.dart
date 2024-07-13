import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/data/models/chat_model.dart';

import '../../../HomeLayout/data/models/message.dart';

part 'home_layout_admin_event.dart';
part 'home_layout_admin_state.dart';

class HomeLayoutAdminBloc
    extends Bloc<HomeLayoutAdminEvent, HomeLayoutAdminState> {
  List<ChatModel> chats = [];
  List<MessageModel> messages = [];
  static HomeLayoutAdminBloc get(context) => BlocProvider.of(context);

  HomeLayoutAdminBloc() : super(HomeLayoutAdminInitial()) {
    on<HomeLayoutAdminEvent>((event, emit) async {
      if (event is GetChatsEvent) {
        try {
          var snapshot = await FirebaseFirestore.instance
              .collection(FirebaseHelper.chatCollection)
              .get();
          chats =
              snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
          emit(ChatsLoaded(chats));
        } catch (e) {
          emit(ChatsError(e.toString()));
        }
      }
      if (event is GetChatMessagesEvent) {
        try {
          emit(LoadingState());
          var snapshot = await FirebaseFirestore.instance
              .collection(FirebaseHelper.chatCollection)
              .doc(event.id)
              .collection(FirebaseHelper.messagesCollection)
              .orderBy(FirebaseHelper.time, descending: true)
              .get();
          messages = snapshot.docs
              .map((doc) => MessageModel.fromDocument(doc))
              .toList();
          emit(MessagessLoaded(messages));
        } catch (e) {
          emit(MessagessError(e.toString()));
        }
      }
    });

    FirebaseFirestore.instance
        .collection(FirebaseHelper.chatCollection)
        .snapshots()
        .listen((snapshot) {
      chats = snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
      add(GetChatsEvent());
    });
  }
}
