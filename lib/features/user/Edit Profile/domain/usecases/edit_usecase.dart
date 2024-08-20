import 'package:osama_consul/features/user/Edit%20Profile/domain/repositories/edit_repo.dart';

class EditUsecase {
  EditRepo repo;
  EditUsecase(this.repo);
  Future<void> call(String name, String phone) =>
      repo.updateProfile(name, phone);
}
