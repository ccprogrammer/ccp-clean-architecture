import 'package:bloc/bloc.dart';
import 'package:ccp_clean_architecture/core/errors/exceptions.dart';
import 'package:ccp_clean_architecture/core/testing/repository/testing_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'testing_event.dart';
part 'testing_state.dart';

class TestingBloc extends Bloc<TestingEvent, TestingState> {
  final auth = TestingRepo();

  TestingBloc() : super(TestingInitial()) {
    on<OnTapTestingEvent>(_onTesting);
  }

  _onTesting(OnTapTestingEvent event, Emitter emit) async {
    final response = await auth.getTesting();
    if (response is ServerException) {
      Logger().w(response.message);

      return;
    }

    final data = (response as Response).data;
  }
}
