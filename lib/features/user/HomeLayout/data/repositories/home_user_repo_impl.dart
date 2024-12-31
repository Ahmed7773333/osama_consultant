import 'package:dartz/dartz.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/user/HomeLayout/data/datasources/home_ds_remote.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/quote_model.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/repositories/home_user_repo.dart';

class HomeUserRepoImpl extends HomeUserRepo {
  HomeDsRemote homeDsRemote;
  HomeUserRepoImpl(this.homeDsRemote);
  @override
  Future<Either<Failures, List<QuoteModel>>> getAllQuotes() {
    return homeDsRemote.getAllQuotes();
  }

  @override
  Future<void> logout() {
    return homeDsRemote.logout();
  }
}
