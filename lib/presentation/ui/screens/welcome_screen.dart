import 'package:exit_travil/core/helpers/helper_functions.dart';
import 'package:exit_travil/presentation/controller/app_bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/videos/vlogo.mp4',
    );
   _controller.setLooping(true);
    _initializeVideoPlayerFuture = _controller.initialize().then((value) => _controller.play());
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //..startNavigationPage(context)
      create: (context) => AppCubit()
      ..startNavigationPage(context),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const ImageAssetWidget(
                          image: "assets/images/4.jpg",
                          flex: 4,
                        ),
                        sizedHeight(2),
                        const ImageAssetWidget(
                          image: "assets/images/5.jpg",
                          flex: 5,
                        ),
                      ],
                    )),
                    sizedWidth(2),
                    Expanded(
                        child: Column(
                      children: [
                        const ImageAssetWidget(
                            image: "assets/images/1.jpg"),
                        sizedHeight(2),
                        const ImageAssetWidget(
                            image: "assets/images/2.jpg"),
                        sizedHeight(2),
                        const ImageAssetWidget(
                            image: "assets/images/3.jpg"),
                      ],
                    )),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                   height: 120,
                   
                    margin: EdgeInsets.only(top: 25),
                    decoration: BoxDecoration(
                      
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return AspectRatio(
                            
                            aspectRatio:1.5,
                            // Use the VideoPlayer widget to display the video.
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                          },
                        ),
                       
                          Container(
                            height: 40,
                            margin: EdgeInsets.only(top: 0),
                            width: double.infinity,
                            alignment: Alignment.center,
                            color:  Color(0xff312b32),
                            child: Text(
                                            "EzyTravel",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                          ),
                                   
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ImageAssetWidget extends StatelessWidget {
  final String image;
  final int flex;
  const ImageAssetWidget({required this.image, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Image.asset(
          image,
          fit: BoxFit.fill,
          width: widthScreen(context),
        ));
  }
}
