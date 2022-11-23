import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vedioplayer/cubit/cubit.dart';
import 'package:vedioplayer/cubit/states.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerCubit()
        ..initial()
        ..initialNetwork(),
      child: BlocConsumer<PlayerCubit, VedioPlayerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PlayerCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: cubit.controller.value.aspectRatio,
                      child: cubit.controller.value.isInitialized
                          ? VideoPlayer(cubit.controller)
                          : Container()),
                  VideoProgressIndicator(cubit.controller,
                      allowScrubbing: true),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.seekMinus();
                        },
                        child: const Text(
                          "<<",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.playVideo();
                        },
                        child: const Text(
                          "Play",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.pauseVideo();
                        },
                        child: const Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.seekPlus();
                        },
                        child: const Text(
                          ">>",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AspectRatio(
                      aspectRatio: cubit.networkController.value.aspectRatio,
                      child: cubit.networkController.value.isInitialized
                          ? VideoPlayer(cubit.networkController)
                          : Container()),
                  VideoProgressIndicator(cubit.networkController,
                      allowScrubbing: true),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.seekMinusNetwork();
                        },
                        child: const Text(
                          "<<",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.playVideoNetwork();
                        },
                        child: const Text(
                          "Play",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.pauseVideoNetwork();
                        },
                        child: const Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.seekPlusNetwork();
                        },
                        child: const Text(
                          ">>",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (cubit.file != null)
                    AspectRatio(
                        aspectRatio: cubit.fileController!.value.aspectRatio,
                        child: cubit.fileController!.value.isInitialized
                            ? VideoPlayer(cubit.fileController!)
                            : Container()),
                  if (cubit.file != null)
                    VideoProgressIndicator(cubit.fileController!,
                        allowScrubbing: true),
                  if (cubit.file != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (cubit.file == null)
                    MaterialButton(
                      color: Colors.grey[300],
                      onPressed: () async {
                        final picker = await cubit.openFile();
                        if (picker != null) {
                          cubit.initialFile(file: picker);
                        } else {
                          return null;
                        }
                      },
                      child: const Text(
                        "File",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  if (cubit.file == null)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.seekMinusFile();
                        },
                        child: const Text(
                          "<<",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.playVideoFile();
                        },
                        child: const Text(
                          "Play",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.pauseVideoFile();
                        },
                        child: const Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          cubit.seekPlusfile();
                        },
                        child: const Text(
                          ">>",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey[900],
              onPressed: () {
                cubit.muteVideo();
                cubit.muteVideoNetwork();
              },
              tooltip: "isMute",
              child: Icon(cubit.isMute ? Icons.music_off : Icons.music_note),
            ),
          );
        },
      ),
    );
  }
}
