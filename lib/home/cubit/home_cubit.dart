import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required LevelRepository levelRepository,
  })  : _levelRepository = levelRepository,
        super(const HomeState());

  final LevelRepository _levelRepository;
}
