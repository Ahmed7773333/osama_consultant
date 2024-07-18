import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';

abstract class AdminRemoteDs {
  Future<Either<Failures, QuerySnapshot>> getChats();
}
