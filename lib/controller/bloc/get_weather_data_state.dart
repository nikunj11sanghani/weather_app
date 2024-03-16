import 'package:equatable/equatable.dart';
import 'package:weather_app/model/weather_model.dart';

class GetWeatherDataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherDataInitial extends GetWeatherDataState {}

class GetWeatherDataLoading extends GetWeatherDataState {}

class GetWeatherDataSuccess extends GetWeatherDataState {
  final WeatherModel model;

  GetWeatherDataSuccess({required this.model});
}

class GetWeatherDataFailure extends GetWeatherDataState {
  final String msg;

  GetWeatherDataFailure({required this.msg});
}
