import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/features/HomeLayout/data/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/firebase_helper.dart';
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
  List<MessageModel> messages = [];
  String id = '';
  HomelayoutBloc(this._confirmBookingUseCase) : super(HomelayoutInitial()) {
    on<PickDateEvent>((event, emit) {
      _selectedDate = event.date;
      emit(DatePickedState(event.date));
    });
    on<GetMessagesEvent>((event, emit) async {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        id = pref.getString('email') ?? '';
        var snapshot = await FirebaseFirestore.instance
            .collection(FirebaseHelper.chatCollection)
            .doc(id)
            .collection(FirebaseHelper.messagesCollection)
            .orderBy(FirebaseHelper.time, descending: true)
            .get();
        messages =
            snapshot.docs.map((doc) => MessageModel.fromDocument(doc)).toList();
        emit(ChatLoaded(messages));
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
