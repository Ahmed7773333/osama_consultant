import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/Home%20Layout%20Admin/domain/repositories/admin_repo.dart';

import '../../../../core/eror/failuers.dart';

class GetChatList {
  AdminRepo adminRepo;

  GetChatList(this.adminRepo);

  Future<Either<Failures, QuerySnapshot>> call() => adminRepo.getChats();
}
