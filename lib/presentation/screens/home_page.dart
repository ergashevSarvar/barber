import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/login/login_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
      'isLowRamDevice': build.isLowRamDevice,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            verticalSpace(250),
            Text(
              "BOSH SAHIFA",
              style: GoogleFonts.montserrat(
                  fontSize: 30, fontWeight: FontWeight.w600),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<LogoutBloc>(context).add(
                              LogOutRequest(state.token)
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: kTextGreen2,
                            child: Text(
                              "Tizimdan chiqish",
                              style: GoogleFonts.montserrat(fontSize: 20),
                            ),
                          ),
                        ),
                        Text(
                          "message: ${state.message}",
                          style: GoogleFonts.montserrat(fontSize: 20),
                        ),
                        Text("token: ${state.token}",
                            style: GoogleFonts.montserrat(fontSize: 20)),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
