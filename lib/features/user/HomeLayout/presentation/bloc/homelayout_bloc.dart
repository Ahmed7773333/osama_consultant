import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/id_slot_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_slot_by_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/eror/failuers.dart';
import '../../../../admin/Meetings Control/data/models/all_schedules_model.dart';
import '../../../../admin/Meetings Control/domain/usecases/get_all_schedule.dart';
import '../../../../admin/Meetings Control/domain/usecases/get_schedule_by_id.dart';
import '../../domain/usecases/confirem_booking.dart';

part 'homelayout_event.dart';
part 'homelayout_state.dart';

class HomelayoutBloc extends Bloc<HomelayoutEvent, HomelayoutState> {
  static HomelayoutBloc get(context) => BlocProvider.of(context);
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Duration? _meetingDuration;
  Duration? _notificationDuration;
  final ConfirmBookingUseCase _confirmBookingUseCase;
  String id = '';
  GetAllSchedules getAllSchedules;
  GetScheduleById getScheduleById;
  GetSlotById getSlotById;

  List<ScheduleModel> daysOfWeek = [];
  List<SlotModel> timesOfDay = [];
  int selectedDay = 0;
  int selectedTime = 0;
  SlotIDModel? slotDetails;
  HomelayoutBloc(this._confirmBookingUseCase, this.getAllSchedules,
      this.getScheduleById, this.getSlotById)
      : super(HomelayoutInitial()) {
    on<HomelayoutEvent>((event, emit) async {
      if (event is PickDateEvent) {
        _selectedDate = event.date;
        emit(DatePickedState(event.date));
      } else if (event is GetNotificationsEvent) {
        try {
          SharedPreferences pref = await SharedPreferences.getInstance();
          id = pref.getString('email') ?? '';
          NotificationService().listenToFirestoreChanges(id);

          emit(ChatLoaded());
        } catch (e) {
          emit(ChatError(e.toString()));
        }
      } else if (event is PickTimeEvent) {
        _selectedTime = event.time;
        emit(TimePickedState(event.time));
      } else if (event is PickDurationEvent) {
        _meetingDuration = event.duration;
        emit(DurationPickedState(event.duration));
      } else if (event is PickNotificationDurationEvent) {
        _notificationDuration = event.duration;
        emit(NotificationDurationPickedState(event.duration));
      } else if (event is ConfirmBookingEvent) {
        if (_selectedDate != null &&
            _selectedTime != null &&
            _meetingDuration != null &&
            _notificationDuration != null) {
          await _confirmBookingUseCase.call(
            selectedDate: _selectedDate!,
            selectedTime: _selectedTime!,
            meetingDuration: _meetingDuration!,
            notificationDuration: _notificationDuration!,
            context: event.context,
          );

          emit(BookingConfirmedState(
            DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            ),
            _meetingDuration!,
            _notificationDuration!,
          ));
        } else {
          // Handle error case
        }
      } else if (event is GetAllSchedulesUserEvent) {
        emit(HomelayoutLoading());
        var result = await getAllSchedules();
        result.fold((l) {
          print(l.message);

          emit(GettingErrorUserState(l));
        }, (r) {
          daysOfWeek = r.data ?? [];
          emit(GeetingAllUserSuccessState(r.data ?? []));
        });
      } else if (event is GetScheduleByIdUserEvent) {
        emit(HomelayoutLoading());

        var result = await getScheduleById(event.id);
        result.fold((l) {
          emit(GettingErrorUserState(l));
        }, (r) {
          timesOfDay = r.data?.slots ?? [];
          selectedDay = (r.data?.id ?? 1) - 1;
          emit(GeetingbyIdUserSuccessState());
        });
      } else if (event is GetSlotByIdUserEvent) {
        emit(HomelayoutLoading());

        var result = await getSlotById(event.id);
        result.fold((l) {
          print(l.message);
          emit(GettingErrorUserState(l));
        }, (r) {
          selectedTime = (r.data?.id ?? 1) - 1;
          slotDetails = r.data;
          emit(GeetingbyIdUserSuccessState());
        });
      }
    });
  }
}
