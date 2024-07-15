import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/data/models/chat_model.dart';

part 'home_layout_admin_event.dart';
part 'home_layout_admin_state.dart';

class HomeLayoutAdminBloc
    extends Bloc<HomeLayoutAdminEvent, HomeLayoutAdminState> {
  List<ChatModel> chats = [];

  static HomeLayoutAdminBloc get(context) => BlocProvider.of(context);

  HomeLayoutAdminBloc() : super(HomeLayoutAdminInitial()) {
    on<HomeLayoutAdminEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      HomeLayoutAdminEvent event, Emitter<HomeLayoutAdminState> emit) async {
    if (event is GetChatsEvent) {
      await _getChatsEvent(emit);
    }
  }

  Future<void> _getChatsEvent(Emitter<HomeLayoutAdminState> emit) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(FirebaseHelper.chatCollection)
          .get();
      chats = snapshot.docs.map((doc) => ChatModel.fromDocument(doc)).toList();
      emit(ChatsLoaded(chats));
    } catch (e) {
      emit(ChatsError(e.toString()));
    }
  }
}
