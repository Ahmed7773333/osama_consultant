import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/quote_model.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/get_all_quotes_usecase.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/logout.dart';

part 'homelayout_event.dart';
part 'homelayout_state.dart';

class HomelayoutBloc extends Bloc<HomelayoutEvent, HomelayoutState> {
  static HomelayoutBloc get(context) => BlocProvider.of(context);
  String id = '';
  LogoutUseCase logoutUseCase;
  GetAllQuotesUseCase getAllQuotesUseCase;
  List<QuoteModel> quotes = [];

  HomelayoutBloc(this.logoutUseCase, this.getAllQuotesUseCase)
      : super(HomelayoutInitial()) {
    on<HomelayoutEvent>((event, emit) async {
      if (event is LogoutEvent) {
        emit(LogoutLoadingState());
        await logoutUseCase().then((v) {
          emit(LogoutSuccessState());
        }).catchError((e) {
          emit(LogoutErrorState());
        });
      }
      if (event is GetQuotesEvent) {
        emit(QuotesLoadingState());
        await getAllQuotesUseCase().then((value) => value.fold((l) {
              emit(GetQuotesErrorState());
            }, (r) {
              quotes = r;
              emit(QuotesSuccessState());
            }));
      }
    });
  }
}

String getDateForDay(int day) {
  DateTime now = DateTime.now();
  int currentDay = now.weekday; // Monday is 1, Sunday is 7

  int difference = ((day - 2) - currentDay) % 7;
  if (difference < 0) {
    difference += 7;
  }

  DateTime targetDate = now.add(Duration(days: difference));
  return DateFormat('yyyy-MM-dd').format(targetDate);
}
