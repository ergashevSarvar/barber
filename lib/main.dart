import 'package:barber/l10n/l10n.dart';
import 'package:barber/l10n/local_string.dart';
import 'package:barber/presentation/blocs/langs/lang_bloc.dart';
import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/blocs/register/register_bloc.dart';
import 'package:barber/routes.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:barber/presentation/controller/init_controller.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => RegisterBloc()),
          BlocProvider(create: (context) => LogoutBloc()),
          BlocProvider(create: (context) => LangBloc()),
        ],
        child: GetMaterialApp(
          title: 'Barber management app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: color2022),
            useMaterial3: true,
          ),
          initialRoute: Routes.login,
          translations: LocalString(),
          locale: Locale("ru"),
          builder: EasyLoading.init(),
          onGenerateRoute: Routes.generateRoute,
        )
    );
  }
}