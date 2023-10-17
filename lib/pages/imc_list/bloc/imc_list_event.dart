part of 'imc_list_bloc.dart';

sealed class IMCListEvent {
  const IMCListEvent();
}

class IMCListStarted extends IMCListEvent {
  const IMCListStarted();
}