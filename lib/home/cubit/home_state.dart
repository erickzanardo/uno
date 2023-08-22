part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.levels = const [],
  });

  final List<String> levels;

  @override
  List<Object?> get props => [levels];
}
