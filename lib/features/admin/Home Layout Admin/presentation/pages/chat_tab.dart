// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/core/utils/componetns.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/bloc/home_layout_admin_bloc.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/presentation/widgets/chipp.dart';
import '../../../../../core/network/check_internet.dart';
import '../../../../general/Chat Screen/data/models/chat_model.dart';
import 'package:badges/badges.dart' as badges;

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeLayoutAdminBloc, HomeLayoutAdminState>(
      bloc: HomeLayoutAdminBloc.get(context),
      builder: (context, state) {
        if (HomeLayoutAdminBloc.get(context).chats.isEmpty &&
            state is AllChatsLoadingState) {
          return Components.shrimList();
        } else {
          return SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    HomeLayoutAdminBloc.get(context)
                        .add(SearchChatsEvent(value));
                  },
                  decoration: InputDecoration(
                      hintText: 'Search by name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _searchController.clear();
                            HomeLayoutAdminBloc.get(context)
                                .add(GetAllChatsEvent());
                          },
                          icon: Icon(Icons.close))),
                ),
                Divider(thickness: 2.h, color: Colors.black),
                state is SearchChatsState
                    ? Expanded(
                        child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final ChatModel i = state.filteredChats[index];
                          return Card(
                            elevation: 20,
                            child: ListTile(
                              onTap: () async {
                                bool isConnect = await ConnectivityService()
                                    .getConnectionStatus();
                                if (isConnect) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.chatScreenAdmin,
                                    arguments: {
                                      'id': i,
                                      'isadmin': true,
                                    },
                                  );
                                } else
                                  Components.showMessage(context,
                                      content: 'No Internet',
                                      icon: Icons.error,
                                      color: Colors.red);
                              },
                              title: Text(i.chatName ?? ''),
                              subtitle: Text(i.chatOwner ?? ''),
                              trailing: badges.Badge(
                                showBadge: (i.unReadCount ?? 0) != 0,
                                badgeContent: Text(
                                  '${i.unReadCount}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10.h);
                        },
                        itemCount: state.filteredChats.length,
                      ))
                    : Expanded(
                        child: Column(children: [
                          Row(
                            children: [
                              chipp(() {
                                HomeLayoutAdminBloc.get(context)
                                    .add(GetAllChatsEvent());
                              }, 0, HomeLayoutAdminBloc.get(context).selected),
                              chipp(() {
                                HomeLayoutAdminBloc.get(context)
                                    .add(GetUnReadChatsEvent());
                              }, 1, HomeLayoutAdminBloc.get(context).selected)
                            ],
                          ),
                          Divider(thickness: 2.h, color: Colors.black),
                          Expanded(
                            child: Components.reloadPull(
                              child: ListView.separated(
                                itemBuilder: (BuildContext context, int index) {
                                  final ChatModel i =
                                      HomeLayoutAdminBloc.get(context)
                                          .chats[index];
                                  return Card(
                                    elevation: 20,
                                    child: ListTile(
                                      onTap: () async {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          Routes.chatScreenAdmin,
                                          arguments: {'id': i, 'isadmin': true},
                                        );
                                      },
                                      title: Text(i.chatName ?? ''),
                                      subtitle: Text(i.chatOwner ?? ''),
                                      trailing: badges.Badge(
                                        showBadge: (i.unReadCount ?? 0) != 0,
                                        badgeContent: Text(
                                          '${i.unReadCount}',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(height: 10.h);
                                },
                                itemCount: HomeLayoutAdminBloc.get(context)
                                    .chats
                                    .length,
                              ),
                              onLoad: () {
                                if (HomeLayoutAdminBloc.get(context).isAll) {
                                  HomeLayoutAdminBloc.get(context)
                                      .add(GetAllChatsEvent());
                                } else {
                                  HomeLayoutAdminBloc.get(context)
                                      .add(GetUnReadChatsEvent());
                                }
                              },
                            ),
                          ),
                        ]),
                      )
              ],
            ),
          );
        }
      },
    );
  }
}
