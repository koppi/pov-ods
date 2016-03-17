## Creating Omni-directional Stereo Content – 4K 360 degree VR with POV-Ray 

### Demo-Video

* https://www.youtube.com/watch?v=UEFO5mQ2zeg

### HOWTO create the Demo-Video

Tested on Ubuntu 16.10:

* Download and install at least [POV-Ray 3.7.1-alpha.8509766](https://github.com/POV-Ray/povray/releases/tag/v3.7.1-alpha.8509766%2Bav119).
* Install git, ffmpeg and make.
* To create ```mirrors-loop.mov``` run:
```bash
$ git clone https://github.com/koppi/pov-ods
$ cd pov-ods
$ make
```
* Inject the spatial media metadata into ```mirrors-loop.mov``` for the YouTube ODS upload to work:
```bash
$ git clone https://github.com/google/spatial-media/
$ cd spatial-media/spatialmedia/
$ ./gui.py # opens Spatial Media Metadata Injector GUI
```
* Open ```mirrors-loop.mov``` in the GUI. Set the check-boxes: ```Spherical``` and ```3D top-bottom```.
* Save ```mirrors-loop_injected.mov``` and upload to YouTube.
* Please share your results on http://news.povray.org/

### Reference

* POV-Ray News:
  * [Rendering omnidirectional stereo images for VR headset](http://news.povray.org/povray.text.scene-files/thread/%3C56e3e4b8%241%40news.povray.org%3E/)
* Oculus Forum:
  * [Clodo](https://forums.oculus.com/viewtopic.php?p=340018#p340018)
* YouTube Help Center:
  * [Rendering ODS content](https://developers.google.com/cardboard/jump/rendering-ods-content.pdf)
  * [Upload 360 degree videos](https://support.google.com/youtube/answer/6178631?hl=en)
  * [Spatial media metadata injector](https://github.com/google/spatial-media/blob/master/spatialmedia/README.md)

– March, 2016
