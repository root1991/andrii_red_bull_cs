import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:red_bull_case_study/blocs/blocs.dart';
import 'package:red_bull_case_study/constants.dart';
import 'package:red_bull_case_study/di/app_module.dart';
import 'package:red_bull_case_study/presentation/screens/screens.dart';
import 'package:red_bull_case_study/presentation/widgets/redbull_text_field_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

GoRouter getRouter(AppModule appModule) {
  return GoRouter(routes: <RouteBase>[
    GoRoute(
      path: RedBullRoutes.auth,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RedBullTextFieldCubit(),
            ),
            BlocProvider(
              create: (context) => AuthCubit(),
            )
          ],
          child: const AuthScreen(),
        );
      },
    ),
    GoRoute(
      path: RedBullRoutes.folders,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => FoldersCubit(),
          child: const FoldersScreen(),
        );
      },
    ),
    GoRoute(
      path: RedBullRoutes.folderContent,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => FolderContentBloc(appModule.folderContentRepo)
            ..add(LoadItemsEvent(
                state.pathParameters[RedBullConstants.folderName] ?? '')),
          child: FolderContentScreen(
            folderName: state.pathParameters[RedBullConstants.folderName] ?? '',
          ),
        );
      },
    ),
  ]);
}

class RedBullApplication extends StatelessWidget {
  final AppModule appModule;

  const RedBullApplication({super.key, required this.appModule});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        var router = getRouter(appModule);

        return MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
          ],
        );
      },
    );
  }
}
