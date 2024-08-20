import 'package:osama_consul/core/api/api_manager.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';
import 'package:osama_consul/features/user/Edit%20Profile/data/datasources/remote_edit_ds.dart';

import '../../../../../core/api/end_points.dart';

class RemoteEditDsImpl extends RemoteEditDs {
  final ApiManager apiManager;
  RemoteEditDsImpl(this.apiManager);
  @override
  Future<void> updateProfile(String name, String phone) async {
    final int id = (await UserPreferences.getId()) ?? -1;
    await apiManager.putData(
      EndPoints.editProfile,
      body: {"id": id, "name": name, "phone": phone},
      data: {'Authorization': 'Bearer ${await UserPreferences.getToken()}'},
    );
  }
}
