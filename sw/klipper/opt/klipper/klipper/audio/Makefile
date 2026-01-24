TXT:=$(wildcard *.txt)
MP3:=$(TXT:.txt=.mp3)
WAV:=$(TXT:.txt=.wav)

.SECONDARY:
.PHONY: all
all: $(WAV)

%.wav: %.mp3
	@echo "WAV $@"
	@mpg123 -q -w "$@" "$<"

%.mp3: %.txt Makefile
	@echo "MP3 $@"
	@trans -download-audio-as "$@" -brief < "$<" > /dev/null

.PHONY: clean
clean:
	rm -fv $(MP3)
