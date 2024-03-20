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
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      clipBehavior: Clip.hardEdge,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/temp.jpg",
                                fit: BoxFit.fill,
                                height: 130,
                                width: double.infinity),
                            RowHelper(
                                title: "Location : ",
                                subTitle:
                                    "${state.model.location.name} , ${state.model.location.region} - ${state.model.location.country}"),
                            const SizedBox(height: 10),
                            RowHelper(
                              title: "Date & Time : ",
                              subTitle: state.model.current.lastUpdated,
                            ),
                            const SizedBox(height: 10),
                            RowHelper(
                              title: " Current Temperature in Celsius : ",
                              subTitle: state.model.current.tempC.toString(),
                            ),
                            const SizedBox(height: 10),
                            RowHelper(
                              title: "Current Temperature in Fern-hit : ",
                              subTitle: state.model.current.tempF.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
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

class RowHelper extends StatelessWidget {
  final String title;
  final String subTitle;

  const RowHelper({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          subTitle,
          style: const TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
