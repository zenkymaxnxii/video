import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import 'package:video/model/video.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    MaterialApp(
      home: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: PagewiseListViewExample(),
    );
  }
}

class PagewiseListViewExample extends StatelessWidget {
  // ignore: constant_identifier_names
  static const int PAGE_SIZE = 1;

  const PagewiseListViewExample({super.key});
  @override
  Widget build(BuildContext context) {
    return PagewiseListView<Video>(
        padding: EdgeInsets.zero,
        pageSize: PAGE_SIZE,
        showRetry: false,
        physics: const PageScrollPhysics(),
        itemBuilder: _itemBuilder,
        pageFuture: (pageIndex) =>
            BackendService.getVideos(pageIndex! * PAGE_SIZE, PAGE_SIZE));
  }

  Widget _itemBuilder(context, Video entry, _) {
    late VideoPlayerController controller = VideoPlayerController.network(
      entry.medias!.first.link!,
      videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: false, allowBackgroundPlayback: false),
    );
    controller.setLooping(true);
    controller.initialize();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _BumbleBeeRemoteVideo(
            controller: controller,
            key: GlobalKey(debugLabel: entry.medias!.first.link),
            entry: entry,
          ),
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          spreadRadius: 4,
                          color: Colors.black.withOpacity(0.2))
                    ]),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.2))
                    ]),
                    child: const Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _BumbleBeeRemoteVideo extends StatefulWidget {
  Video entry;
  late VideoPlayerController controller;
  _BumbleBeeRemoteVideo(
      {Key? key, required this.entry, required this.controller})
      : super(key: key);
  @override
  _BumbleBeeRemoteVideoState createState() => _BumbleBeeRemoteVideoState();
}

class _BumbleBeeRemoteVideoState extends State<_BumbleBeeRemoteVideo> {
  late GlobalKey globalKeyCenterButton;
  @override
  void initState() {
    super.initState();
    globalKeyCenterButton =
        GlobalKey(debugLabel: widget.entry.medias!.first.link!);

    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  // double _mathScale(Size size, double aspectRatio) {
  //   final renderBox =
  //       globalKeyCenterButton.currentContext!.findRenderObject() as RenderBox?;

  //   var maxH = 0.0;
  //   var maxW = 0.0;
  //   var minH = 0.0;
  //   var minW = 0.0;
  //   final Size sizeScreen = renderBox?.size ?? size;

  //   minH = sizeScreen.height;
  //   minW = minH * aspectRatio;
  //   maxW = sizeScreen.width;
  //   maxH = maxW / aspectRatio;

  //   if (minW > maxW) {
  //     final tempW = minW;
  //     minW = maxW;
  //     maxW = tempW;

  //     final tempH = minH;
  //     minH = maxH;
  //     maxH = tempH;
  //   }

  //   return maxH / minH;
  // }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        key: globalKeyCenterButton,
        children: <Widget>[
          // (widget.controller.value.aspectRatio > 0.6)
          //     ?

          Semantics(child: VideoPlayer(widget.controller)),
          //     : Center(
          //         child: Transform.scale(
          //             scale: _mathScale(
          //               MediaQuery.of(context).size,
          //               widget.controller.value.aspectRatio,
          //             ),
          //             child: VideoPlayer(widget.controller))),
          // // ClosedCaption(text: widget.controller.value.caption.text),
          _ControlsOverlay(controller: widget.controller),
          VideoProgressIndicator(widget.controller, allowScrubbing: true),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          spreadRadius: -10,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.2))
                    ]),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

class BackendService {
  static var videoJson = [
    {
      "id": 170,
      "userId": 99,
      "type": "film",
      "subject": "a",
      "content": "",
      "typeScope": "public",
      "isNews": 2,
      "parentId": null,
      "createdAt": "2023-02-15T15:57:18.709Z",
      "totalShared": 0,
      "totalReaction": 7,
      "totalComment": 3,
      "totalSaved": 0,
      "isHearted": false,
      "isSaved": false,
      "parent": null,
      "user": {
        "id": 99,
        "avatar":
            "https://res.cloudinary.com/dnixuyeyz/image/upload/v1677342924/vdone/image/ve2lifcvnjnrdjxcjrbf.jpg",
        "pDoneId": "VN0021342424",
        "hexId": "1677822315",
        "displayName": "hieudev1@gmail.com",
        "isPDone": true,
        "isJA": true,
        "isVShop": false,
        "isFriend": false,
        "isFollowed": false
      },
      "medias": [
        {
          "id": 149,
          "link":
              "https://res.cloudinary.com/dnixuyeyz/video/upload/v1676476616/vdone/video/otwunogxexa3lcexsk1n.mp4"
        }
      ]
    },
    {
      "id": 163,
      "userId": 91,
      "type": "film",
      "subject": "o update 022",
      "content": "",
      "typeScope": "public",
      "isNews": 2,
      "parentId": null,
      "createdAt": "2023-02-15T10:17:16.476Z",
      "totalShared": 0,
      "totalReaction": 4,
      "totalComment": 4,
      "totalSaved": 2,
      "isHearted": false,
      "isSaved": false,
      "parent": null,
      "user": {
        "id": 91,
        "avatar":
            "https://res.cloudinary.com/dnixuyeyz/image/upload/v1677936857/vdone/image/vmtm3nayhmoif4gfrxxe.jpg",
        "pDoneId": "VN2662331231",
        "hexId": "1677822307",
        "displayName": "Miii1",
        "isPDone": true,
        "isJA": true,
        "isVShop": true,
        "isFriend": false,
        "isFollowed": false
      },
      "medias": [
        {
          "id": 412,
          "link":
              "https://res.cloudinary.com/dnixuyeyz/video/upload/q_auto/v1679194787/vdone/video/v480dvnyldui4myz8yct.mp4"
        }
      ]
    },
    {
      "id": 487,
      "userId": 228,
      "type": "film",
      "subject": "Mèo",
      "content": "meo meo",
      "typeScope": "public",
      "isNews": 2,
      "parentId": null,
      "createdAt": "2023-03-23T04:31:17.718Z",
      "totalShared": 0,
      "totalReaction": 2,
      "totalComment": 4,
      "totalSaved": 1,
      "isHearted": false,
      "isSaved": false,
      "parent": null,
      "user": {
        "id": 228,
        "avatar":
            "https://res.cloudinary.com/dnixuyeyz/image/upload/v1678875894/vdone/image/b8s1xctaz4yw2revx0fh.jpg",
        "pDoneId": "VND0G9500000",
        "hexId": "2271678419002724",
        "displayName": "Test1",
        "isPDone": true,
        "isJA": true,
        "isVShop": true,
        "isFriend": false,
        "isFollowed": false
      },
      "medias": [
        {
          "id": 419,
          "link":
              "https://res.cloudinary.com/dnixuyeyz/video/upload/q_auto/v1679545873/vdone/video/dasfpieevbgripdnahbu.mp4"
        }
      ]
    }
  ];

  static Future<List<Video>> getVideos(offset, limit) async {
    List<Video> list = [];
    list.addAll(List.from(videoJson.map((e) => Video.fromJson(e))));
    list.addAll(List.from(videoJson.map((e) => Video.fromJson(e))));
    list.addAll(List.from(videoJson.map((e) => Video.fromJson(e))));
    List<Video> list2 = [];
    for (int i = offset; i < offset + limit; i++) {
      list2.add(list[i]);
    }
    return list2;
  }
}
