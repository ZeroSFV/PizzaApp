import 'package:flutter/cupertino.dart';
import 'package:pizzer_mobile/blocs/delivery_info/delivery_info_events.dart';
import 'package:pizzer_mobile/blocs/delivery_info/delivery_info_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryInfoBloc extends Bloc<DeliveryInfoEvent, DeliveryInfoState> {
  String? address = "";
  String? flat = "";
  String? entrance = "";
  String? floor = "";
  String? phone = "";
  String? comment = "";
  DeliveryInfoBloc() : super(LoadingInfoState()) {
    on<EmptyInfoEvent>((event, emit) async {
      emit(EmptyInfoState());
    });

    on<AddressChangedEvent>((event, emit) async {
      address = event.addressValue;
      if (address == "" &&
          flat == "" &&
          entrance == "" &&
          floor == "" &&
          phone == "" &&
          comment == "")
        emit(EmptyInfoState());
      else if (address != "" &&
          flat != "" &&
          entrance != "" &&
          floor != "" &&
          phone != "")
        emit(FilledAllState(address, flat, entrance, floor, phone, comment));
      else
        emit(FilledInfoState(address, flat, entrance, floor, phone, comment));
    });

    on<FlatChangedEvent>((event, emit) async {
      flat = event.flatValue;
      if (address == "" &&
          flat == "" &&
          entrance == "" &&
          floor == "" &&
          phone == "" &&
          comment == "")
        emit(EmptyInfoState());
      else if (address != "" &&
          flat != "" &&
          entrance != "" &&
          floor != "" &&
          phone != "")
        emit(FilledAllState(address, flat, entrance, floor, phone, comment));
      else
        emit(FilledInfoState(address, flat, entrance, floor, phone, comment));
    });

    on<EntranceChangedEvent>((event, emit) async {
      entrance = event.entranceValue;
      if (address == "" &&
          flat == "" &&
          entrance == "" &&
          floor == "" &&
          phone == "" &&
          comment == "")
        emit(EmptyInfoState());
      else if (address != "" &&
          flat != "" &&
          entrance != "" &&
          floor != "" &&
          phone != "")
        emit(FilledAllState(address, flat, entrance, floor, phone, comment));
      else
        emit(FilledInfoState(address, flat, entrance, floor, phone, comment));
    });

    on<FloorChangedEvent>((event, emit) async {
      floor = event.floorValue;
      if (address == "" &&
          flat == "" &&
          entrance == "" &&
          floor == "" &&
          phone == "" &&
          comment == "")
        emit(EmptyInfoState());
      else if (address != "" &&
          flat != "" &&
          entrance != "" &&
          floor != "" &&
          phone != "")
        emit(FilledAllState(address, flat, entrance, floor, phone, comment));
      else
        emit(FilledInfoState(address, flat, entrance, floor, phone, comment));
    });

    on<PhoneChangedEvent>((event, emit) async {
      // if (phone.toString().length < event.phoneValue.toString().length) {
      //   String startWord = phone.toString();

      //   final startIndex = event.phoneValue.toString().indexOf(startWord);
      //   //final endIndex = input.indexOf(endWord, startIndex + startWord.length);
      //   phone = startWord +
      //       event.phoneValue
      //           .toString()
      //           .substring(startIndex, event.phoneValue.toString().length);
      // } else if (phone.toString().length > event.phoneValue.toString().length) {
      //   //final endIndex = input.indexOf(endWord, startIndex + startWord.length);
      //   phone = event.phoneValue;
      // }
      //phone = phone.toString() + event.phoneValue.toString().substring(5);
      //phone = phone.toString() + event.phoneValue.toString();
      phone = event.phoneValue.toString();
      if (address == "" &&
          flat == "" &&
          entrance == "" &&
          floor == "" &&
          phone == "" &&
          comment == "")
        emit(EmptyInfoState());
      else if (address != "" &&
          flat != "" &&
          entrance != "" &&
          floor != "" &&
          phone != "")
        emit(FilledAllState(address, flat, entrance, floor, phone, comment));
      else
        emit(FilledInfoState(address, flat, entrance, floor, phone, comment));
    });

    on<CommentChangedEvent>((event, emit) async {
      comment = event.commentValue;
      if (address == "" &&
          flat == "" &&
          entrance == "" &&
          floor == "" &&
          phone == "" &&
          comment == "")
        emit(EmptyInfoState());
      else if (address != "" &&
          flat != "" &&
          entrance != "" &&
          floor != "" &&
          phone != "")
        emit(FilledAllState(address, flat, entrance, floor, phone, comment));
      else
        emit(FilledInfoState(address, flat, entrance, floor, phone, comment));
    });
  }
}
