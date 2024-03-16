import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_widgets/custom_app_bar.dart';
import '../controller/bloc/get_weather_data_bloc.dart';
import '../controller/bloc/get_weather_data_event.dart';
import '../controller/bloc/get_weather_data_state.dart';

class DataScreen extends StatefulWidget {
  final String currentAddress;

  const DataScreen({super.key, required this.currentAddress});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  void initState() {
    context
        .read<GetWeatherDataBloc>()
        .add(GetDataEvent(location: widget.currentAddress));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Weather Data"),
      body: Center(
        child: BlocBuilder<GetWeatherDataBloc, GetWeatherDataState>(
          builder: (BuildContext context, GetWeatherDataState state) {
            if (state is GetWeatherDataSuccess) {
              return Column(
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Fetch Data")),
                  Text(state.model.current.tempC.toString()),
                  Text(state.model.current.tempF.toString()),
                ],
              );
            }
            if (state is GetWeatherDataFailure) {
              return Text(state.msg);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
