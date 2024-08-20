import 'package:osama_consul/features/user/Edit%20Profile/data/datasources/remote_edit_ds.dart';
import 'package:osama_consul/features/user/Edit%20Profile/domain/repositories/edit_repo.dart';

class EditRepoImpl extends EditRepo {
  RemoteEditDs remoteEditDs;
  EditRepoImpl(this.remoteEditDs);
  @override
  Future<void> updateProfile(String name, String phone) {
    return remoteEditDs.updateProfile(name, phone);
  }
}
