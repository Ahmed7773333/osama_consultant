import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/data/models/chat_model.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/logout.dart';

part 'home_layout_admin_event.dart';
part 'home_layout_admin_state.dart';

class HomeLayoutAdminBloc
    extends Bloc<HomeLayoutAdminEvent, HomeLayoutAdminState> {
  List<ChatModel> chats = [];

  static HomeLayoutAdminBloc get(context) => BlocProvider.of(context);
  LogoutUseCase logoutUseCase;
  HomeLayoutAdminBloc(this.logoutUseCase) : super(HomeLayoutAdminInitial()) {
    on<HomeLayoutAdminEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      HomeLayoutAdminEvent event, Emitter<HomeLayoutAdminState> emit) async {
    if (event is GetChatsEvent) {
      await _getChatsEvent(emit);
    } else if (event is LogoutAdminEvent) {
      emit(LogoutAdminLoadingState());
      await logoutUseCase().then((v) {
        emit(LogoutAdminSuccessState());
      }).catchError((e) {
        emit(LogoutAdminErrorState());
      });
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
