import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iot_logger/cubits/files_cubit/files_cubit.dart';
import 'package:iot_logger/cubits/sensor_reading_cubit/sensor_reading_cubit.dart';

class Layout extends StatelessWidget {
  final Widget content;
  const Layout({this.content});

  Widget getSaphiLogo(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // color: Colors.red[40],s
          alignment: Alignment.center,
          height:
              MediaQuery.of(context).size.height * (isLandscape ? 0.1 : 0.15),
          child: SvgPicture.asset(
            'assets/svgs/saphi-logo-white-text.svg',
            width:
                MediaQuery.of(context).size.height * (isLandscape ? 0.3 : 0.15),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/images/land.jpg',
            fit: BoxFit.fill,
          ),
        ),
        // ?
        Container(
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.5),
                Colors.transparent,
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
        ),

        // Back Button
        if (ModalRoute.of(context).settings.name != "/")
          Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                type: MaterialType.button,
                color: Colors.transparent,
                child: BackButton(
                  onPressed: () => {
                    if (ModalRoute.of(context).settings.name == "/readings")
                      {
                        BlocProvider.of<SensorReadingCubit>(context)
                            .closeTimer()
                      },
                    Navigator.pop(context),
                  },
                  color: Colors.white,
                ),
              ),
            ),
          ),
        // Refresh Button
        if (ModalRoute.of(context).settings.name == "/logs")
          Padding(
            padding: EdgeInsets.fromLTRB(0, 42, 20, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  BlocProvider.of<FilesCubit>(context).refresh();
                },
              ),
            ),
          ),

        // Logo and Content
        Container(
          child: Column(
            children: [
              getSaphiLogo(context),
              Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: content,
              ),
            ],
          ),
        )
      ],
    );
  }
}
