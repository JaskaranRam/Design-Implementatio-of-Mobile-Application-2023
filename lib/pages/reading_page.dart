import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ReadingPage extends StatefulWidget {
  final String storyText;
  final String language;

  const ReadingPage(
      {super.key, required this.storyText, required this.language});

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    // Imposta la lingua corretta in base al parametro 'language'
    _flutterTts.setLanguage(widget.language == 'Italiano' ? 'it-IT' : 'en-US');
    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  void _toggleTts() async {
    if (_isPlaying) {
      await _flutterTts.pause();
    } else {
      await _flutterTts.speak(widget.storyText);
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _resetTts() async {
    await _flutterTts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        _resetTts();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reading Page'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sfondo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: Markdown(data: widget.storyText),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "play",
              onPressed: _toggleTts,
              child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: "restart",
              onPressed: _resetTts,
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isPlaying) {
      _flutterTts.stop();
    }
    super.dispose();
  }
}
