import 'package:flutter/cupertino.dart';

class ImagePreviewDialog extends StatelessWidget {
  const ImagePreviewDialog({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(middle: Text('Image Preview')),
      child: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(
            imageUrl.replaceAll("kong:8000", '127.0.0.1:54321'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: CupertinoDialogAction(
      //     child: Text('Close'),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      // ),
    );
  }
}
