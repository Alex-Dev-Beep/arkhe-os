SRC_DIR = src
BUILD_DIR = build
ASM = nasm
QEMU = qemu-system-i386

.PHONY: all run clean

all: $(BUILD_DIR)/main_floppy.img

$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	copy /B $(BUILD_DIR)\main.bin $(BUILD_DIR)\main_floppy.img
	fsutil file seteof $(BUILD_DIR)\main_floppy.img 1474560

$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin

run: all
	$(QEMU) -fda $(BUILD_DIR)/main_floppy.img

clean:
	del /Q $(BUILD_DIR)\*.bin $(BUILD_DIR)\*.img
