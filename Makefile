SCENE?=mirrors
INI?=HIGHSQ
POV?=-d

all: img mov

help:
	@echo "usage:"
	@echo "  'SCENE=axis make', 'SCENE=mirrors make', see pov/"
	@echo ""
	@echo " quality settings:"
	@echo "  'SCENE=axis INI=LOWSQ  make'"
	@echo "  'SCENE=axis INI=MEDSQ  make'"
	@echo "  'SCENE=axis INI=HIGHSQ make'"
	@echo ""
	@echo " render for a low quality preview:"
	@echo "  'SCENE=axis INI=LOWSQ POV=+d make'"
	@echo ""
	@echo " render for YouTube upload:"
	@echo "  'SCENE=axis INI=HIGHSQ POV=-d make'"
	@echo ""

img:
	time nice povray +Lpov "${SCENE}[${INI}]" ${POV}

mov:
	time nice ffmpeg -y -framerate 25 -pattern_type glob -i '${SCENE}???.png' -c:v libx264 -r 30 -pix_fmt yuv420p ${SCENE}.mov
	time nice ffmpeg -y -f concat -i ${SCENE}-loop.txt -c copy ${SCENE}-loop.mov

mp4:
	time nice ffmpeg -y -framerate 25 -pattern_type glob -i '${SCENE}???.png' -c:v libx264 -r 30 -pix_fmt yuv420p ${SCENE}.mp4

clean:
	/bin/rm -f *.pov-state *.mp4 *.mov *.png
