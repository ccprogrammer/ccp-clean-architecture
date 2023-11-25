part of 'testing_bloc.dart';

sealed class TestingEvent extends Equatable {
  const TestingEvent();

  @override
  List<Object> get props => [];
}

class OnTapTestingEvent extends TestingEvent {
  const OnTapTestingEvent();
}
