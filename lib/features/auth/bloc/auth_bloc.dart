import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Викликаємо метод логіну
        final result = await authRepository.login(event.email, event.password);

        // Обробляємо результат
        if (result['success']) {
          // Успішний логін
          emit(AuthSuccess(uid: result['uid'] ?? ''));
        } else {
          // Помилка логіну
          emit(AuthFailure(error: result['error']));
        }
      } catch (e) {
        // Невідома помилка
        emit(AuthFailure(error: 'An unexpected error occurred: $e'));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result =
            await authRepository.register(event.email, event.password);

        if (result['success']) {
          emit(AuthSuccess(uid: result['uid'] ?? ''));
        } else {
          emit(AuthFailure(error: result['error']));
        }
      } catch (e) {
        emit(AuthFailure(error: 'An unexpected error occurred: $e'));
      }
    });
  }
}
