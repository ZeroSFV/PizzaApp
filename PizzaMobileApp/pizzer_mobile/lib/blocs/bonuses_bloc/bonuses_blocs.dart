import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_states.dart';
import 'package:pizzer_mobile/blocs/bonuses_bloc/bonuses_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BonusesBloc extends Bloc<BonusesEvent, BonusesState> {
  bool bonusesApplied;
  int? bonuses;

  BonusesBloc(this.bonusesApplied) : super(BonusesDeletedState()) {
    on<BonusesChange>((event, emit) async {
      bonusesApplied = event.bonusesApplied;
      if (event.userBonuses != 0) {
        if (bonusesApplied == false) {
          bonuses = 0;
          emit(BonusesDeletedState());
        } else {
          if (event.userBonuses! <= event.basketPrice * 0.15) {
            bonuses = event.userBonuses as int;
            emit(BonusesAppliedState(event.userBonuses));
          } else if (event.userBonuses! > event.basketPrice * 0.15) {
            bonuses = (event.basketPrice * 0.15).toInt();
            emit(BonusesAppliedState((event.basketPrice * 0.15).toInt()));
          }
        }
      } else {
        bonuses = 0;
        emit(NoBonusesState());
      }
    });
  }
}
