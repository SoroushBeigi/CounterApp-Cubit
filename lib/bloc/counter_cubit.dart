import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<int>{

  //We set 0 as default value.
  CounterCubit() : super(0);

  void increase(){
    emit(state + 1);
  }
  
  void decrease(){
    emit(state - 1);
  }

}