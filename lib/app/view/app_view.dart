import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:uno/app/app.dart';
import 'package:uno/home/view/view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: flutterNesTheme(brightness: Brightness.dark),
      home: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppCubit>().state;

    if (state is AppLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (state is AppInitial || state is AppLoadError) {
      return _SelectProject();
    } else if (state is AppLoaded) {
      return const HomePage();
    }

    return const SizedBox();
  }
}

class _SelectProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppLoadError) {
          NesSnackbar.show(
            context,
            text: state.message,
            type: NesSnackbarType.error,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Image.asset(
                'assets/icon.png',
              ),
              const SizedBox(height: 16),
              Text(
                'UNO',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 48),
              NesButton(
                type: NesButtonType.primary,
                child: const Text('Select Project'),
                onPressed: () {
                  context.read<AppCubit>().selectProject();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
