import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_states.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BonusesBloc extends Bloc<BonusesEvent, BonusesState> {
  bool bonusesApplied;

  BonusesBloc(this.bonusesApplied) : super(BonusesDeletedState()) {
    on<BonusesChange>((event, emit) async {
      bonusesApplied = event.bonusesApplied;
      if (event.userBonuses != 0) {
        if (bonusesApplied == false) {
          emit(BonusesDeletedState());
        } else {
          if (event.userBonuses! <= event.basketPrice * 0.15)
            emit(BonusesAppliedState(event.userBonuses));
          else if (event.userBonuses! > event.basketPrice * 0.15) {
            emit(BonusesAppliedState(event.basketPrice * 0.15 as int));
          }
        }
      } else {
        emit(NoBonusesState());
      }
    });
  }
}
