all: anim mov

anim:
	time nice povray "mirrors[HIGHSQ]"

mov:
	ffmpeg -y -framerate 25 -pattern_type glob -i 'mirrors???.png' -c:v libx264 -r 30 -pix_fmt yuv420p mirrors.mov
	ffmpeg -y -f concat -i mirrors-loop.txt -c copy mirrors-loop.mov

mp4:
	ffmpeg -y -framerate 25 -pattern_type glob -i 'mirrors???.png' -c:v libx264 -r 30 -pix_fmt yuv420p mirrors.mp4

clean:
	/bin/rm -f mirrors???.png mirrors.mov
