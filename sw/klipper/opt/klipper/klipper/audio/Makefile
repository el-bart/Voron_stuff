TXT:=$(wildcard *.txt)
MP3:=$(TXT:.txt=.mp3)

.PHONY: all
all: $(MP3)

%.mp3: %.txt Makefile
	@echo "AUDIO $@"
	@trans -download-audio-as "$@" -brief < "$<" > /dev/null

.PHONY: clean
clean:
	rm -fv $(MP3)
