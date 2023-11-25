part of 'testing_bloc.dart';

sealed class TestingState extends Equatable {
  const TestingState();
  
  @override
  List<Object> get props => [];
}

final class TestingInitial extends TestingState {}
