import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osama_consul/config/app_routes.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:osama_consul/features/user/HomeLayout/data/models/meeting_booking.dart';
import 'package:osama_consul/features/user/HomeLayout/domain/usecases/logout.dart';

import '../../../../../core/cache/shared_prefrence.dart';
import '../../../../../core/eror/failuers.dart';
import '../../../../admin/Meetings Control/data/models/all_schedules_model.dart';
import '../../../../admin/Meetings Control/domain/usecases/get_all_schedule.dart';
import '../../../../admin/Meetings Control/domain/usecases/get_schedule_by_id.dart';
import '../../domain/usecases/confirem_booking.dart';

part 'homelayout_event.dart';
part 'homelayout_state.dart';

class HomelayoutBloc extends Bloc<HomelayoutEvent, HomelayoutState> {
  static HomelayoutBloc get(context) => BlocProvider.of(context);
  ConfirmBookingUseCase confirmBookingUseCase;
  String id = '';
  GetAllSchedules getAllSchedules;
  GetScheduleById getScheduleById;
  LogoutUseCase logoutUseCase;
  List<ScheduleModel> daysOfWeek = [];
  List<SlotModel> timesOfDay = [];
  int selectedDay = 0;
  int selectedTime = 0;
  SlotModel? slotDetails;

  HomelayoutBloc(this.confirmBookingUseCase, this.getAllSchedules,
      this.getScheduleById, this.logoutUseCase)
      : super(HomelayoutInitial()) {
    on<HomelayoutEvent>((event, emit) async {
      if (event is GetAllSchedulesUserEvent) {
        emit(HomelayoutLoading());

        var result = await getAllSchedules();
        result.fold((l) {
          debugPrint(l.message);
          emit(GettingErrorUserState(l));
        }, (r) {
          daysOfWeek = r.data ?? [];
          emit(GeetingAllUserSuccessState(r.data ?? []));
        });
      } else if (event is GetScheduleByIdUserEvent) {
        emit(GetScheduleByIdUserLoading());
        var result = await getScheduleById(event.id);
        result.fold((l) {
          emit(GettingErrorUserState(l));
        }, (r) {
          timesOfDay = r.data?.slots ?? [];
          selectedDay = (r.data?.id ?? 1) - 1;
          slotDetails = timesOfDay.isNotEmpty ? timesOfDay.first : null;

          emit(GetScheduleByIdUserSuccessState());
        });
      } else if (event is GetSlotByIdUserEvent) {
        emit(GetSlotByIdUserLoading());
        selectedTime = event.id;
        slotDetails = timesOfDay[event.id];
        emit(GetSlotByIdUserSuccessState());
      } else if (event is ConfirmBookingEvent) {
        emit(BookingConfirmedLoadingState());
        String namee = await UserPreferences.getName() ?? '';
        var result = await confirmBookingUseCase(MeetingBody(
            title: '${await UserPreferences.getEmail()}@#!',
            userId: await UserPreferences.getId(),
            scheduleSlotId: slotDetails?.id,
            meetingDate: getDateForDay(selectedDay + 1)));
        result.fold((l) {
          emit(BookingConfirmedErrorState(l));
        }, (r) {
          NotificationService().pushNotification(
              'New Request',
              'New Request from$namee/${Routes.requestsPage}',
              "admin@chat.com");
          emit(BookingConfirmedState());
        });
      } else if (event is LogoutEvent) {
        emit(LogoutLoadingState());
        await logoutUseCase().then((v) {
          emit(LogoutSuccessState());
        }).catchError((e) {
          emit(LogoutErrorState());
        });
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
