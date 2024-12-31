import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/quote_model.dart';

import '../../../../../core/eror/failuers.dart';

abstract class HomeDsRemote {
  Future<Either<Failures, List<QuoteModel>>> getAllQuotes();
  Future<void> logout();
}
