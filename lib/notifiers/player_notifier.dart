

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../repository/player_repository.dart';

class PlayerNotifier with ChangeNotifier {
  late PlayerRepository playerRepository;

  PlayerNotifier() {
    playerRepository = PlayerRepository();
    initializeAudio();
  }

  bool _isPlaying = false;
  double _audioVolume = 0.5;
  late AudioPlayer _audioPlayer;
  late StreamSubscription<PlayerState> _playerStateChangedSubscription;

  late Future<Duration?> futureDuration;

  bool get isPlaying => _isPlaying;
  AudioPlayer get audioPlayer => _audioPlayer;
  double get audioVolume => _audioVolume;


  void initializeAudio() async{
    _audioPlayer = AudioPlayer();
    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen(playerStateListener);
    //https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3
    futureDuration = _audioPlayer.setUrl("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
  }

  void updateVolume(double updatedOne) async{
    _audioVolume = updatedOne;
    await _audioPlayer.setVolume(_audioVolume);
    notifyListeners();
  }
  void playerStateListener(PlayerState state) async {
    if (state.processingState == ProcessingState.completed) {
      await reset();
    }
  }

  void togglePlayPause() async {
    if (isPlaying) {
      pause();
    } else {
      play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  @override
  void dispose() {
    _playerStateChangedSubscription.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> play() {
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }

  Future<void> reset() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }
}