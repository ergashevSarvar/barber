import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/blocs/register/register_bloc.dart';
import 'package:barber/presentation/screens/login_page.dart';
import 'package:barber/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => LogoutBloc()),
      ],
      child: MaterialApp(
        title: 'Barber management app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.login,
        builder: EasyLoading.init(),
        onGenerateRoute: Routes.generateRoute,
        home: LoginPage(),
      ),
    );
  }
}

