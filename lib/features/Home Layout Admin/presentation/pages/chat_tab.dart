// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import '../../data/models/chat_model.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutAdminBloc, HomeLayoutAdminState>(
      builder: (context, state) {
        if (state is ChatsLoaded) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final ChatModel i = state.chats[index];
              return Card(
                elevation: 20,
                child: ListTile(
                  onTap: () async {
                    await HomeLayoutAdminBloc.get(context).close();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.chatScreenAdmin,
                      arguments: {'id': i, 'isadmin': true},
                      (Route<dynamic> route) => false,
                    );
                  },
                  title: Text(i.chatName ?? ''),
                  subtitle: Text(i.chatOwner ?? ''),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.h);
            },
            itemCount: state.chats.length,
          );
        } else if (state is ChatsError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
