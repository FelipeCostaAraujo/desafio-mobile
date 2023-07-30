import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:words_app/core/error/domain_errors.dart';
import 'package:words_app/features/splash/domain/usecases/verify_user_loggedin.dart';
import 'package:words_app/features/splash/presentation/bloc/splash_cubit_state.dart';

class SplashCubit extends Cubit<SplashCubitState> {
  SplashCubit({required this.verifyUser})
      : super(const SplashCubitState(status: SplashCubitStateStatus.loading));

  VerifyUserLoggedIn verifyUser;

  void onInit() async {
    try {
      await verifyUser();
      emit(state.copyWith(status: SplashCubitStateStatus.authenticated));
    } on DomainError catch (e) {
      emit(state.copyWith(
        status: SplashCubitStateStatus.unauthenticated,
        error: e.description,
      ));
    }
  }
}

class SplashCubitProvider extends BlocProvider<SplashCubit> {
  SplashCubitProvider({
    Key? key,
    Widget? child,
  }) : super(
          key: key,
          create: (_) => SplashCubit(
            verifyUser: GetIt.instance<VerifyUserLoggedIn>(),
          )..onInit(),
          child: child,
        );

  static SplashCubit of(BuildContext context) =>
      BlocProvider.of<SplashCubit>(context);
}
