import 'package:flutter/material.dart';
import 'dart:async';
import 'package:volume/volume.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VolumeDemo(title: 'Volume Plugin example app'),
    );
  }
}

VolumeDemoState pageState;

class VolumeDemo extends StatefulWidget {
  VolumeDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  VolumeDemoState createState() {
    pageState = VolumeDemoState();
    return pageState;
  }
}

class VolumeDemoState extends State<VolumeDemo> {
  AudioManager audioManager;
  int maxVol, currentVol;

  @override
  void initState() {
    super.initState();
    audioManager = AudioManager.STREAM_SYSTEM;
    initPlatformState(AudioManager.STREAM_VOICE_CALL);
    updateVolumes();
  }

  Future<void> initPlatformState(AudioManager am) async {
    await Volume.controlVolume(am);
  }

  void updateVolumes() async {
    maxVol = await Volume.getMaxVol;
    currentVol = await Volume.getVol;
    print("maxVol: $maxVol, currentVol: $currentVol");
    setState(() {});
  }

  void setVol(int i) async {
    await Volume.setVol(i);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("Max Volume: $maxVol"),
                    Text("Current Volume: $currentVol"),
                  ],
                ),
              ),
              DropdownButton(
                value: audioManager,
                items: [
                  DropdownMenuItem(
                    child: Text("In Call Volume"),
                    value: AudioManager.STREAM_VOICE_CALL,
                  ),
                  DropdownMenuItem(
                    child: Text("System Volume"),
                    value: AudioManager.STREAM_SYSTEM,
                  ),
                  DropdownMenuItem(
                    child: Text("Ring Volume"),
                    value: AudioManager.STREAM_RING,
                  ),
                  DropdownMenuItem(
                    child: Text("Media Volume"),
                    value: AudioManager.STREAM_MUSIC,
                  ),
                  DropdownMenuItem(
                    child: Text("Alarm Volume"),
                    value: AudioManager.STREAM_ALARM,
                  ),
                  DropdownMenuItem(
                    child: Text("Notifications Volume"),
                    value: AudioManager.STREAM_NOTIFICATION,
                  ),
                ],
                isDense: true,
                onChanged: (AudioManager am) async {
                  print(am.toString());
                  initPlatformState(am);
                  updateVolumes();
                  audioManager = am;
                },
              ),
              (currentVol != null || maxVol != null)
              ? Slider(
                value: currentVol / 1.0,
                divisions: maxVol,
                max: maxVol / 1.0,
                min: 0,
                onChanged: (double d) {
                  setVol(d.toInt());
                  updateVolumes();
                },
              )
              : Container(),
            ],
          ),
        ),
      ),
    );
  }
}