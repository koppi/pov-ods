## HOWTO create Omni-directional Stereo Content with POV-Ray

1. Run POV-Ray
2. Run ffmpeg
3. Inject spatial media metadata
4. Upload to YouTube

### Demo-Videos

[Watch 360 degree videos in Cardboard](https://support.google.com/youtube/answer/6239930?hl=en) on Android:

* https://www.youtube.com/watch?v=UEFO5mQ2zeg

### ODS POV-Ray, YouTube HOWTO

– Tested on Ubuntu 16.10:

* Download and install [POV-Ray 3.7.1-alpha.8509766](https://github.com/POV-Ray/povray/releases/tag/v3.7.1-alpha.8509766%2Bav119). For camera settings in ```mirrors.pov``` to work we need to have a [function-based user-defined camera](https://github.com/POV-Ray/povray/commit/c5f8d78e2116a02daed2151e02234095fe4d5642).
* Install git, ffmpeg and make.
* To create ```mirrors-loop.mov``` run:
```bash
$ git clone https://github.com/koppi/pov-ods
$ cd pov-ods
$ make # or "povray mirrors[MEDSQ]" for low quality preview
```
* Inject the spatial media metadata into ```mirrors-loop.mov```:
```bash
$ git clone https://github.com/google/spatial-media/
$ cd spatial-media/spatialmedia/
$ ./gui.py # opens Spatial Media Metadata Injector GUI
```
* Open ```mirrors-loop.mov``` in the GUI. Set the check-boxes: ```Spherical``` and ```3D top-bottom```.
* Save ```mirrors-loop_injected.mov``` and upload to YouTube.
* Please share your results on http://news.povray.org/ .

### Reference

* YouTube Help Center:
  * [Rendering ODS content](https://developers.google.com/cardboard/jump/rendering-ods-content.pdf)
  * [Upload 360 degree videos](https://support.google.com/youtube/answer/6178631?hl=en)
  * [Spatial media metadata injector](https://github.com/google/spatial-media/blob/master/spatialmedia/README.md)
* YouTube ODS content on Android
  * [Watch 360 degree videos in Cardboard](https://support.google.com/youtube/answer/6239930?hl=en)
* Related threads – Oculus Forum:
  * [POV-Ray ODS](https://forums.oculus.com/viewtopic.php?p=340018#p340018)
  * [Resolutions and codec for omnidirectional stereo videos](https://forums.oculus.com/viewtopic.php?f=20&t=30852)
* Related threads – POV-Ray News:
  * [Rendering omnidirectional stereo images for VR headset](http://news.povray.org/povray.text.scene-files/thread/%3C56e3e4b8%241%40news.povray.org%3E/)
  * [The Cave in ODS format (1,4MB)](http://news.povray.org/povray.binaries.images/thread/%3C56e6a09f%40news.povray.org%3E/)

### TODO

* Add [Ambisonics](https://en.wikipedia.org/wiki/Ambisonics) sound – Inspiration, see:
  * https://www.youtube.com/watch?v=eedXpclrKCc
  * https://www.youtube.com/watch?v=lVXmtckavDQ
* Increase frame-rate and resolution targeted for future [HMD](https://en.wikipedia.org/wiki/Head-mounted_display)s – Needs more:
  * HDD space,
  * CPU power,
  * Network bandwidth.

[Jakob Flierl](mailto:jakob.flierl@gmail.com) – March, 2016
