import 'package:equatable/equatable.dart';

class GetWeatherDataEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetDataEvent extends GetWeatherDataEvent {
  final String location;

  GetDataEvent({required this.location});
}
