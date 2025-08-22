TARGET ?= linux

OUT=out/game

ifeq ($(TARGET), linux)
	CC := gcc -c
	LD := gcc
	CFLAGS  :=
	LDFLAGS :=
	LIBS    := -lraylib -lGL -lm
else ifeq ($(TARGET), html5)
	CC := emcc -c
	LD := emcc
	CFLAGS  := -Os -DPLATFORM_WEB 
	LDFLAGS :=  -s USE_GLFW=3 --shell-file ext/rl_$(TARGET)/minshell.html
	LIBS    := -lraylib
	OUT:=$(addsuffix .html, $(OUT))
else
	$(error TARGET '$(TARGET)' is not supported, choose between: linux, html5)
endif

CFLAGS  += -Wall -Wextra -Iext/rl_$(TARGET)/include
LDFLAGS += -Lext/rl_$(TARGET)

SRC=$(shell find src -name "*.c")
OBJ=$(SRC:%=%.o)

.PHONY: all clean always

run: all
ifeq ($(TARGET), html5)
	python3 -m http.server -d out 
else
	./$(OUT)
endif

all: always  $(OUT)

$(OUT): $(OBJ)
	$(LD) $(LDFLAGS) $^ -o $@ $(LIBS)

%.c.o: %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -rf out $(OBJ)

always:
	mkdir -p out
