import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/data/datasources/admin_remote_ds.dart';
import 'package:osama_consul/features/admin/Home%20Layout%20Admin/domain/repositories/admin_repo.dart';
import '../../../../../core/eror/failuers.dart';

class AdminRepoImpl implements AdminRepo {
  AdminRemoteDs adminRemoteDs;

  AdminRepoImpl(this.adminRemoteDs);

  @override
  Future<Either<Failures, QuerySnapshot>> getChats() {
    return adminRemoteDs.getChats();
  }
}
