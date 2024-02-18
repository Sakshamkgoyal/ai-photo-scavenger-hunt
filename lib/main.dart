import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scavenger_hunt_repository/scavenger_hunt_repository.dart';

import 'app/app.dart';
import 'photo/photo_picker.dart';

void main() {
  Bloc.observer = const _AppBlocObserver();

  final photoPicker = PhotoPicker(imagePicker: ImagePicker());

  final client = ScavengerHuntClient.vertexAi(
    apiKey: const String.fromEnvironment('API_KEY'),
    projectUrl: const String.fromEnvironment('VERTEX_AI_PROJECT_URL'),
  );
  final repository = ScavengerHuntRepository(client: client);

  runApp(App(photoPicker: photoPicker, repository: repository));
}

class _AppBlocObserver extends BlocObserver {
  const _AppBlocObserver();

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint(transition.toString());
  }
}
