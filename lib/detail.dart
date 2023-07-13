import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Detail extends StatefulWidget {
  final String? arti;
  final String? asma;
  final String? audio;
  final String? keterangan;
  final String? nama;

  Detail({
    Key? key,
    this.arti,
    this.asma,
    this.audio,
    this.keterangan,
    this.nama,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final AudioPlayer audioPlayer = AudioPlayer();
  PlayerState _playerState =
      PlayerState.STOPPED; // Tambahkan state pemutar musik

  @override
  void dispose() {
    audioPlayer.release(); // Hentikan pemutar musik saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            '(${widget.arti})',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.mosque_outlined,
                              size: 50,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.nama} (${widget.asma})',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.keterangan}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(),
                        Text('asma: ${widget.asma}'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.mic_none_outlined,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            // Pemutar Musik
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (_playerState == PlayerState.STOPPED) {
                                    audioPlayer.play('${widget.audio}');
                                    setState(() {
                                      _playerState = PlayerState.PLAYING;
                                    });
                                  } else if (_playerState ==
                                      PlayerState.PLAYING) {
                                    audioPlayer.pause();
                                    setState(() {
                                      _playerState = PlayerState.PAUSED;
                                    });
                                  } else if (_playerState ==
                                      PlayerState.PAUSED) {
                                    audioPlayer.resume();
                                    setState(() {
                                      _playerState = PlayerState.PLAYING;
                                    });
                                  }
                                },
                                child: Text(
                                  '${widget.audio}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _playerState == PlayerState.PLAYING
                                    ? Icons.stop
                                    : Icons.play_arrow,
                              ),
                              onPressed: () {
                                if (_playerState == PlayerState.PLAYING) {
                                  audioPlayer.stop();
                                  setState(() {
                                    _playerState = PlayerState.STOPPED;
                                  });
                                } else {
                                  audioPlayer.play('${widget.audio}');
                                  setState(() {
                                    _playerState = PlayerState.PLAYING;
                                  });
                                }
                              },
                            ),
                            // Akhir Pemutar
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

enum PlayerState {
  PLAYING,
  PAUSED,
  STOPPED,
}
