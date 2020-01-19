import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'auth_event.dart';
import 'auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  AuthState get initialState => AuthInProgress();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authRepository.isSignedIn();
      if (isSignedIn) {
        final currentUser = await _authRepository.getCurrentUser();
        yield AuthSuccess(currentUser);
      } else {
        yield AuthFailure();
      }
    } catch (_) {
      yield AuthFailure();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield AuthSuccess(await _authRepository.getCurrentUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield AuthFailure(); // AuthInProgressではないのか?
    _authRepository.signOut();
  }
}
