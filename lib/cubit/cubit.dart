import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedioplayer/cubit/states.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

class PlayerCubit extends Cubit<VedioPlayerStates> {
  PlayerCubit() : super(VedioPlayedInitialStates());
  static PlayerCubit get(context) => BlocProvider.of(context);
  //asset
  late VideoPlayerController controller;
  bool isMute = true;
  Duration? duration;
  late Duration plus;
  late Duration minus;

  void initial() {
    controller = VideoPlayerController.asset("assets/flutter.mp4")
      ..initialize().then((value) {
        emit(VedioPlayedInitializeStates());
      });
  }

  void seekMinus() async {
    duration = await controller.position;
    minus = duration! - const Duration(seconds: 10);
    controller.seekTo(minus);
    emit(VedioPlayedPlusStates());
  }

  void seekPlus() async {
    duration = await controller.position;
    plus = duration! + const Duration(seconds: 10);
    controller.seekTo(plus);
    emit(VedioPlayedMinusStates());
  }

  void muteVideo() {
    controller.setVolume(isMute ? 1 : 0);
    isMute = !isMute;
    emit(VedioPlayedShowStates());
  }

  void playVideo() {
    controller.play();
    emit(VedioPlayedPlayStates());
  }

  void pauseVideo() {
    controller.pause();
    emit(VedioPlayedPauseStates());
  }

// network
  late VideoPlayerController networkController;
  late Duration networkPlus;
  late Duration networkMinus;
  Duration? networkDuration;
  String dataSource =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";

  void initialNetwork() {
    networkController = VideoPlayerController.network(dataSource)
      ..initialize().then((value) {
        emit(VedioPlayedInitializeNetworkState());
      }).catchError((onError) {
        print(onError.toString());
      });
  }

  void seekMinusNetwork() async {
    networkDuration = await networkController.position;
    networkMinus = networkDuration! - const Duration(seconds: 10);
    networkController.seekTo(networkMinus);
    emit(VedioPlayedPlusNetworkState());
  }

  void seekPlusNetwork() async {
    networkDuration = await networkController.position;
    networkPlus = networkDuration! + const Duration(seconds: 10);
    networkController.seekTo(networkPlus);
    emit(VedioPlayedMinusNetworkState());
  }

  void muteVideoNetwork() {
    networkController.setVolume(isMute ? 1 : 0);
    emit(VedioPlayedShowNetworkState());
  }

  void playVideoNetwork() {
    networkController.play();
    emit(VedioPlayedPlayNetworkState());
  }

  void pauseVideoNetwork() {
    networkController.pause();
    emit(VedioPlayedPauseNetworkState());
  }

  //file
  File? file;
  openFile() async {
    var result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false);
    if (result != null) {
      file = File(result.files.single.path.toString());
      print("hi");
      return file;
    }
  }

  VideoPlayerController? fileController;
  late Duration filePlus;
  late Duration fileMinus;
  Duration? fileDuration;

  void initialFile({required File file}) {
    fileController = VideoPlayerController.file(file)
      ..initialize().then((value) {
        emit(VedioPlayedInitializeFileState());
      }).catchError((onError) {
        print(onError.toString());
      });
  }

  void seekMinusFile() async {
    fileDuration = await fileController!.position;
    fileMinus = fileDuration! - const Duration(seconds: 10);
    fileController!.seekTo(fileMinus);
    emit(VedioPlayedPlusFileState());
  }

  void seekPlusfile() async {
    fileDuration = await fileController!.position;
    filePlus = fileDuration! + const Duration(seconds: 10);
    fileController!.seekTo(filePlus);
    emit(VedioPlayedMinusFileState());
  }

  void muteVideofile() {
    fileController!.setVolume(isMute ? 1 : 0);
    emit(VedioPlayedShowFileState());
  }

  void playVideoFile() {
    fileController!.play();
    emit(VedioPlayedPlayFileState());
  }

  void pauseVideoFile() {
    fileController!.pause();
    emit(VedioPlayedPauseFileState());
  }
}
