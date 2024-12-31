import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/core/network/check_internet.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';
import 'package:osama_consul/features/general/Chat%20Screen/data/models/chat_model.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/logout.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/cache/shared_prefrence.dart';

part 'home_layout_admin_event.dart';
part 'home_layout_admin_state.dart';

class HomeLayoutAdminBloc
    extends Bloc<HomeLayoutAdminEvent, HomeLayoutAdminState> {
  List<ChatModel> chats = [];
  bool isAll = true;
  int selected = 0;
  static HomeLayoutAdminBloc get(context) => BlocProvider.of(context);
  LogoutUseCase logoutUseCase;
  HomeLayoutAdminBloc(this.logoutUseCase) : super(HomeLayoutAdminInitial()) {
    on<HomeLayoutAdminEvent>((event, emit) async {
      if (event is GetAllChatsEvent) {
        try {
          emit(AllChatsLoadingState());

          bool isConnect = await ConnectivityService().getConnectionStatus();
          if (isConnect) {
            var snapshot = await FirebaseFirestore.instance
                .collection(FirebaseHelper.chatCollection)
                .get();
            isAll = true;
            selected = 0;
            chats = snapshot.docs
                .map((doc) => ChatModel.fromDocument(doc))
                .toList();
          }
          emit(AllChatsSuccessState());
        } catch (e) {
          emit(ChatsError(e.toString()));
        }
      } else if (event is SearchChatsEvent) {
        try {
          emit(SearchChatsLoadingState());
          final filteredChats = chats.where((chat) {
            return (chat.chatName ?? '')
                .toLowerCase()
                .contains(event.searchQuery.toLowerCase());
          }).toList();
          emit(SearchChatsState(filteredChats));
        } catch (e) {
          emit(ChatsError(e.toString()));
        }
      } else if (event is GetUnReadChatsEvent) {
        try {
          emit(UnReadChatsLoadingState());
          bool isConnect = await ConnectivityService().getConnectionStatus();

          if (isConnect) {
            var snapshot = await FirebaseFirestore.instance
                .collection(FirebaseHelper.chatCollection)
                .where(FirebaseHelper.chatCountUnRead, isNotEqualTo: 0)
                .get();
            isAll = false;
            selected = 1;
            chats = snapshot.docs
                .map((doc) => ChatModel.fromDocument(doc))
                .toList();
          }
          emit(UnReadChatsSuccessState());
        } catch (e) {
          emit(ChatsError(e.toString()));
        }
      } else if (event is LogoutAdminEvent) {
        emit(LogoutAdminLoadingState());
        await logoutUseCase().then((v) {
          emit(LogoutAdminSuccessState());
        }).catchError((e) {
          emit(LogoutAdminErrorState());
        });
      } else if (event is AddQuoteEvent) {
        emit(AddQuoteLoadingState());
        try {
          await ApiManager().postDataa(
            EndPoints.getQuotes,
            body: {"text": event.text, "image": event.image},
            data: {
              'Authorization': 'Bearer ${await UserPreferences.getToken()}'
            },
          );

          emit(AddQuoteSuccessState());
        } catch (e) {
          emit(AddQuoteErrorState());
        }
      } else if (event is AddMemberEvent) {
        emit(AddMemberLoadingState());
        try {
          await ApiManager().postDataa(
            EndPoints.addMember,
            body: {
              "email": event.email,
              "password": event.password,
              "name": event.name,
              "role": event.role,
            },
            data: {
              'Authorization': 'Bearer ${await UserPreferences.getToken()}'
            },
          );

          emit(AddMemberSuccessState());
        } catch (e) {
          emit(AddMemberErrorState());
        }
      }
    });
  }
}
