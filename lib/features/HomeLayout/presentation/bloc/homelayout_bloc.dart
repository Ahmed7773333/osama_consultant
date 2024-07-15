import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/cache/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  HomelayoutBloc(this._confirmBookingUseCase) : super(HomelayoutInitial()) {
    on<PickDateEvent>((event, emit) {
      _selectedDate = event.date;
      emit(DatePickedState(event.date));
    });
    on<GetNotificationsEvent>((event, emit) async {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        id = pref.getString('email') ?? '';
        NotificationService().listenToFirestoreChanges(id);

        emit(ChatLoaded());
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });
    on<PickTimeEvent>((event, emit) {
      _selectedTime = event.time;
      emit(TimePickedState(event.time));
    });

    on<PickDurationEvent>((event, emit) {
      _meetingDuration = event.duration;
      emit(DurationPickedState(event.duration));
    });

    on<PickNotificationDurationEvent>((event, emit) {
      _notificationDuration = event.duration;
      emit(NotificationDurationPickedState(event.duration));
    });
    on<ConfirmBookingEvent>((event, emit) async {
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
    });
  }
}
