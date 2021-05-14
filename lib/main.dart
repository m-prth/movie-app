import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/presentation/widgets/movie_app.dart';
import 'package:pedantic/pedantic.dart';
import 'package:movie_app/di/get_it_di.dart' as getIt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(getIt.init());
  runApp(MovieApp());
}
