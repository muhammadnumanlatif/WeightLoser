// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_uploader/flutter_uploader.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meta/meta.dart';
// import 'package:path/path.dart';
//
// import '../utils/AppConfig.dart';
//
// const String title = "Ultimate Selfie";
// const String uploadURL = "$apiUrl/api/selfie";
//
// const String uploadBinaryURL = "";
//
// class UploadItem {
//   final String id;
//   final String tag;
//   final MediaType type;
//   final int progress;
//   final UploadTaskStatus status;
//
//   UploadItem({
//     this.id,
//     this.tag,
//     this.type,
//     this.progress = 0,
//     this.status = UploadTaskStatus.undefined,
//   });
//
//   UploadItem copyWith({UploadTaskStatus status, int progress}) => UploadItem(
//       id: this.id,
//       tag: this.tag,
//       type: this.type,
//       status: status ?? this.status,
//       progress: progress ?? this.progress);
//
//   bool isCompleted() =>
//       this.status == UploadTaskStatus.canceled ||
//       this.status == UploadTaskStatus.complete ||
//       this.status == UploadTaskStatus.failed;
// }
//
// enum MediaType { Image, Video }
//
// class UploadScreen extends StatefulWidget {
//   UploadScreen({Key key}) : super(key: key);
//
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }
//
// class _UploadScreenState extends State<UploadScreen> {
//   FlutterUploader uploader = FlutterUploader();
//   StreamSubscription _progressSubscription;
//   StreamSubscription _resultSubscription;
//   Map<String, UploadItem> _tasks = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _progressSubscription = uploader.progress.listen((progress) {
//       final task = _tasks[progress.tag];
//       print("progress: ${progress.progress} , tag: ${progress.tag}");
//       if (task == null) return;
//       if (task.isCompleted()) return;
//       setState(() {
//         _tasks[progress.tag] =
//             task.copyWith(progress: progress.progress, status: progress.status);
//       });
//     });
//     _resultSubscription = uploader.result.listen((result) {
//       print(
//           "id: ${result.taskId}, status: ${result.status}, response: ${result.response}, statusCode: ${result.statusCode}, tag: ${result.tag}, headers: ${result.headers}");
//
//       final task = _tasks[result.tag];
//       if (task == null) return;
//
//       setState(() {
//         _tasks[result.tag] = task.copyWith(status: result.status);
//       });
//     }, onError: (ex, stacktrace) {
//       print("exception: $ex");
//       print("stacktrace: $stacktrace" ?? "no stacktrace");
//       final exp = ex as UploadException;
//       final task = _tasks[exp.tag];
//       if (task == null) return;
//
//       setState(() {
//         _tasks[exp.tag] = task.copyWith(status: exp.status);
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _progressSubscription?.cancel();
//     _resultSubscription?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(height: 20.0),
//             Text(
//               'multipart/form-data uploads',
//               //style: Theme.of(context).textTheme.subhead,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 MaterialButton(
//                   onPressed: () => getImage(binary: false),
//                   child: Text("upload image"),
//                 ),
//                 Container(width: 20.0),
//                 MaterialButton(
//                   onPressed: () => getVideo(binary: false),
//                   child: Text("upload video"),
//                 )
//               ],
//             ),
//             Container(height: 20.0),
//             Text(
//               'binary uploads',
//               //style: Theme.of(context).textTheme.subhead,
//             ),
//             Text('this will upload selected files as binary'),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 MaterialButton(
//                   onPressed: () => getImage(binary: true),
//                   child: Text("upload image"),
//                 ),
//                 Container(width: 20.0),
//                 MaterialButton(
//                   onPressed: () => getVideo(binary: true),
//                   child: Text("upload video"),
//                 )
//               ],
//             ),
//             Expanded(
//               child: ListView.separated(
//                 padding: EdgeInsets.all(20.0),
//                 itemCount: _tasks.length,
//                 itemBuilder: (context, index) {
//                   final item = _tasks.values.elementAt(index);
//                   print("${item.tag} - ${item.status}");
//                   return UploadItemView(
//                     item: item,
//                     onCancel: cancelUpload,
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return Divider(
//                     color: Colors.black,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _uploadUrl({bool binary}) {
//     if (binary) {
//       return uploadBinaryURL;
//     } else {
//       return uploadURL;
//     }
//   }
//
//   Future getImage({@required bool binary}) async {
//     var image =
//         await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       final String filename = basename(image.path);
//       final String savedDir = dirname(image.path);
//       final tag = "image upload ${_tasks.length + 1}";
//       var url = _uploadUrl(binary: binary);
//       String fileName = image.path.split('/').last;
//       FormData formdata = new FormData();
//       //var datetime = DateTime.fromMillisecondsSinceEpoch(
//       //  start.millisecondsSinceEpoch,
//       //isUtc: true);
//       //String fileName = imageFile.path.split('/').last;
//       formdata = FormData.fromMap({
//         "UserId": 1,
//         "Weight": 80,
//         "Waist": 36,
//         "Dated": DateTime.now(),
//         "ImageFile": await MultipartFile.fromFile(
//           image.path,
//           filename: fileName,
//         )
//       });
//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//       );
//       var imageFile = await MultipartFile.fromFile(
//         image.path,
//         filename: fileName,
//       );
//
//       print("fileName:" + filename);
//       var taskId = await uploader.enqueue(
//         url: url,
//         data: {
//           "UserId": "1",
//           "Weight": "80",
//           "Waist": "36",
//           "Dated": DateTime.now().toIso8601String(),
//           "ImageFile": fileItem.toString()
//         },
//         files: [fileItem],
//         method: UploadMethod.POST,
//         tag: tag,
//         showNotification: true,
//       );
//
//       setState(() {
//         _tasks.putIfAbsent(
//             tag,
//             () => UploadItem(
//                   id: taskId,
//                   tag: tag,
//                   type: MediaType.Video,
//                   status: UploadTaskStatus.enqueued,
//                 ));
//       });
//     }
//   }
//
//   Future getVideo({@required bool binary}) async {
//     var video =
//         await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       final String savedDir = dirname(video.path);
//       final String filename = basename(video.path);
//       final tag = "video upload ${_tasks.length + 1}";
//       final url = _uploadUrl(binary: binary);
//
//       var fileItem = FileItem(
//         filename: filename,
//         savedDir: savedDir,
//         fieldname: "file",
//       );
//
//       var taskId = binary
//           ? await uploader.enqueueBinary(
//               url: url,
//               file: fileItem,
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             )
//           : await uploader.enqueue(
//               url: url,
//               data: {"name": "john"},
//               files: [fileItem],
//               method: UploadMethod.POST,
//               tag: tag,
//               showNotification: true,
//             );
//
//       setState(() {
//         _tasks.putIfAbsent(
//             tag,
//             () => UploadItem(
//                   id: taskId,
//                   tag: tag,
//                   type: MediaType.Video,
//                   status: UploadTaskStatus.enqueued,
//                 ));
//       });
//     }
//   }
//
//   Future cancelUpload(String id) async {
//     await uploader.cancel(taskId: id);
//   }
// }
//
// typedef CancelUploadCallback = Future<void> Function(String id);
//
// class UploadItemView extends StatelessWidget {
//   final UploadItem item;
//   final CancelUploadCallback onCancel;
//
//   UploadItemView({
//     Key key,
//     this.item,
//     this.onCancel,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final progress = item.progress.toDouble() / 100;
//     final widget = item.status == UploadTaskStatus.running
//         ? LinearProgressIndicator(value: progress)
//         : Container();
//     final buttonWidget = item.status == UploadTaskStatus.running
//         ? Container(
//             height: 50,
//             width: 50,
//             child: IconButton(
//               icon: Icon(Icons.cancel),
//               onPressed: () => onCancel(item.id),
//             ),
//           )
//         : Container();
//     return Row(
//       children: <Widget>[
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Text(item.tag),
//               Container(
//                 height: 5.0,
//               ),
//               Text(item.status.description),
//               Container(
//                 height: 5.0,
//               ),
//               widget
//             ],
//           ),
//         ),
//         buttonWidget
//       ],
//     );
//   }
// }
