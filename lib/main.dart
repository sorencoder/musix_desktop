import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_desktop/logic/cubit/made_for_you/made_for_you_cubit.dart';
import 'package:musix_desktop/logic/cubit/song_cubit/song_cubit.dart';
import 'package:musix_desktop/firebase_options.dart';
import 'package:musix_desktop/logic/provider/audio_provider/audio_provider.dart';
import 'package:musix_desktop/navigations/tabbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => SongCubit(),
        ),
        BlocProvider(
          create: (context) => MadeForYouCubit(),
        ),
        ChangeNotifierProvider<AudioProvider>(
            create: (context) => AudioProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white10,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white38,
            ),
          ),
          home: const Tabbar(),
        );
      },
    );
  }
}
