import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/eror/failuers.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/data/models/all_schedules_model.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/add_slot.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_all_schedule.dart';
import 'package:osama_consul/features/admin/Meetings%20Control/domain/usecases/get_schedule_by_id.dart';

part 'meetings_control_event.dart';
part 'meetings_control_state.dart';

class MeetingsControlBloc
    extends Bloc<MeetingsControlEvent, MeetingsControlState> {
  static MeetingsControlBloc get(context) => BlocProvider.of(context);
  AddSlotUseCase addSlotUseCase;
  GetAllSchedules getAllSchedules;
  GetScheduleById getScheduleById;
  List<ScheduleModel> daysOfWeek = [];
  List<SlotModel> timesOfDay = [];
  int selectedDay = 0;
  MeetingsControlBloc(
      this.addSlotUseCase, this.getAllSchedules, this.getScheduleById)
      : super(MeetingsControlInitial()) {
    on<MeetingsControlEvent>((event, emit) async {
      if (event is GetAllSchedulesEvent) {
        emit(GettingLoadingState());
        var result = await getAllSchedules();
        result.fold((l) {
          emit(GettingErrorState(l));
        }, (r) {
          daysOfWeek = r.data ?? [];
          emit(GeetingAllSuccessState(r.data ?? []));
        });
      } else if (event is GetScheduleByIdEvent) {
        emit(GettingLoadingState());

        var result = await getScheduleById(event.id);
        result.fold((l) {
          emit(GettingErrorState(l));
        }, (r) {
          timesOfDay = r.data?.slots ?? [];
          selectedDay = (r.data?.id ?? 1) - 1;
          emit(GeetingbyIdSuccessState(r.data?.slots ?? []));
        });
      } else if (event is AddSlotEvent) {
        emit(GettingLoadingState());

        var result = await addSlotUseCase(event.slot);
        result.fold((l) {
          emit(GettingErrorState(l));
        }, (r) {
          add(GetScheduleByIdEvent(r.data?.scheduleId ?? 0));
          emit(AddSuccessState());
        });
      }
    });
  }
}
