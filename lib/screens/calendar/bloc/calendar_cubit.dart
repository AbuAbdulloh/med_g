import 'package:bloc/bloc.dart';

class CalendarCubit extends Cubit<int>{
  CalendarCubit():super(0);
  void updateIndexPrevious(){
    if(state!=0){
      emit(state-1);
    }
  }
  void updateIndexNext(){
    if(state!=2){
      emit(state+1);
    }
  }
}