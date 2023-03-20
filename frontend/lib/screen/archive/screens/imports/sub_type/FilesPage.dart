// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:file_picker/file_picker.dart';

// class FilesPage extends StatefulWidget {
//   final List<PlatformFile> files;
//   final ValueChanged<PlatformFile> onOpenFile;
//   const FilesPage({super.key, required this.files, required this.onOpenFile});

//   @override
//   State<FilesPage> createState() => _FilesPageState();
// }

// class _FilesPageState extends State<FilesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: GridView.builder(
              
//       padding: EdgeInsets.all(16),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        
//         crossAxisCount: 2,
//         mainAxisSpacing: 8,
//         crossAxisSpacing: 8,
//       ),
//       itemCount: widget.files.length,
//       itemBuilder: (context, index) {
//         final file = widget.files[index];
//         return buildFile(file);
//       },
//     )
    
//     ));
//   }

//   Widget buildFile(PlatformFile file) {
//     final kb = file.size / 1024;
//     final mb = kb / 1024;
//     final fileSize =
//         mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toString()} kb';
//     final extension = file.extension ?? 'none'; // Ahmad Ammar Almohmmad so

//     // final color =getColor(extension);
//     return InkWell(
//       onTap: () {
//         widget.onOpenFile(file);
//       },
//       child: Container(
//         padding: EdgeInsets.all(8),
//         margin: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//                 child: Container(
//               alignment: Alignment.center,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 72, 71, 71),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '$extension',
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 9, 0, 0)),
//               ),
//             )),
//             const SizedBox(
//               height: 8,
//             ),
//             Text(
//               file.name,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                   color: Color.fromARGB(255, 2, 0, 0)),
//             ),
//             Text(
//               fileSize,
//               style: TextStyle(
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                   color: Color.fromARGB(255, 3, 0, 0)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
