import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/quote_model.dart';

abstract class HomeUserRepo {
  Future<Either<Failures, List<QuoteModel>>> getAllQuotes();
  Future<void> logout();
}
