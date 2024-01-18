part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.failure,
  });

  final String? failure;

  @override
  List<Object?> get props => [failure];
}
