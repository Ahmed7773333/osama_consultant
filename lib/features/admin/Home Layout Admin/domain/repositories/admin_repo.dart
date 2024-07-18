import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/eror/failuers.dart';

abstract class AdminRepo {
  Future<Either<Failures, QuerySnapshot>> getChats();
}
