import 'package:dartz/dartz.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/repositories/home_user_repo.dart';
import '../../../../../core/eror/failuers.dart';
import '../../data/models/quote_model.dart';

class GetAllQuotesUseCase {
  HomeUserRepo repo;
  GetAllQuotesUseCase(this.repo);
  Future<Either<Failures, List<QuoteModel>>>call () =>
      repo.getAllQuotes();
}
