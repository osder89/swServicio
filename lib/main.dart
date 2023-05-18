import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:swdeservicio/providers/user_provider.dart';
import 'package:swdeservicio/responsive/mobile_screen_layout.dart';
import 'package:swdeservicio/responsive/responsive_layout_screen.dart';
import 'package:swdeservicio/responsive/web_screen_layout.dart';
import 'package:swdeservicio/screens/login_screen.dart';
import 'package:swdeservicio/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCtTMZt7OdCL-v0gorrcwxD_71tkbB1AZI',
            appId: '1:858593510484:web:14d80da15db30a81c059c1',
            messagingSenderId: '858593510484',
            projectId: 'swservicio-59f82',
            storageBucket: 'swservicio-59f82.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  await ScreenProtector.preventScreenshotOn();
  //await FirebaseMessaging.instance.subscribeToTopic('myTopic');
  FirebaseMessaging.instance.getToken().then((token) {
    print('Token: $token');
  }).catchError((e) {
    print('Error al obtener token: $e');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event Fot',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        /*home: PreventScreend()*/
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              return const LoginScreen();
            }),
      ),
    );
  }
}
