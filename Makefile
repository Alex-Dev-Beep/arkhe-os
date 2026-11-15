CC = clang
CFLAGS = --target=x86_64-w64-mingw32 -Wall -Wextra

SRC = kernel/main.c
TARGET = build/arkhe.exe

all: $(TARGET)

$(TARGET): $(SRC)
	@if not exist build mkdir build
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

run: $(TARGET)
	.\$(TARGET)

clean:
	if exist build rmdir /s /q build

.PHONY: all run clean
