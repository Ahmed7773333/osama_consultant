import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';

import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/core/network/firebase_helper.dart';

import 'admin_remote_ds.dart';

class AdminRemoteDsImpl extends AdminRemoteDs {
  @override
  Future<Either<Failures, QuerySnapshot>> getChats() async {
    try {
      final r = await FirebaseFirestore.instance
          .collection(FirebaseHelper.chatCollection)
          .get();
      return Right(r);
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
