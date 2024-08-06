import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Picture Frame',
      debugShowCheckedModeBanner: false,
      home: PictureFrame(),
    );
  }
}

class PictureFrame extends StatefulWidget {
  @override
  _PictureFrameState createState() => _PictureFrameState();
}

class _PictureFrameState extends State<PictureFrame> {
  List<String> _imageUrls = [
    'https://myappsush.s3.amazonaws.com/1d.jpg',
    'https://myappsush.s3.amazonaws.com/la_la_land_banner.jpg',
    'https://myappsush.s3.amazonaws.com/queen.jpg',
    'https://myappsush.s3.amazonaws.com/logo1.jpg',
  ];

  int _currentIndex = 0;
  bool _isPaused = false;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (!_isPaused) {
        _nextImage();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _imageUrls.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _imageUrls.length) % _imageUrls.length;
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Photo Gallery',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 10,
                ),
                image: DecorationImage(
                  image: NetworkImage(_imageUrls[_currentIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10), // Space between image and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: _previousImage,
                ),
                SizedBox(width: 10), // Space between buttons
                ElevatedButton(
                  onPressed: _togglePause,
                  child: Text(_isPaused ? 'Resume' : 'Pause'),
                ),
                SizedBox(width: 10), // Space between buttons
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
                  onPressed: _nextImage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
