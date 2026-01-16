import 'package:go_router/go_router.dart';
import 'screens/screen_1.dart';
import 'screens/screen_2.dart';
import 'screens/screen_3.dart';
import 'screens/forgot_password.dart';
import 'screens/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/signup', builder: (context, state) => const Signup()),
    GoRoute(
      path: '/forgot',
      builder: (context, state) => const ForgotPassword(),
    ),
    GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);
