import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/controller/bloc/get_weather_data_event.dart';
import 'package:weather_app/controller/bloc/get_weather_data_state.dart';
import 'package:weather_app/model/weather_model.dart';

import '../../utils/api_controller.dart';

class GetWeatherDataBloc
    extends Bloc<GetWeatherDataEvent, GetWeatherDataState> {
  GetWeatherDataBloc() : super(GetWeatherDataInitial()) {
    on<GetDataEvent>(_getWeatherData);
  }

  _getWeatherData(GetDataEvent event, Emitter<GetWeatherDataState> emit) async {
    try {
      Response response = await APIController.getData(
          "https://bhagavad-gita3.p.rapidapi.com/v2/chapters/");
      if (response.statusCode == 200) {
        log(response.body);
        WeatherModel data = WeatherModel.fromJson(jsonDecode(response.body));
        emit(GetWeatherDataSuccess(model: data));
      } else {
        emit(GetWeatherDataFailure(msg: response.body));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
