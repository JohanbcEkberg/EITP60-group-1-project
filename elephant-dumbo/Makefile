TARGET = elephant_dumbo
ARCH_FLAGS = -mthumb -mcpu=cortex-m0 -msoft-float
PREFIX ?= arm-none-eabi
CC = $(PREFIX)-gcc
LD = $(PREFIX)-gcc
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
ELMOASMFUNCTIONS = elmoasmfunctions.o

CFLAGS = -Os -g -Wall -Wextra -Wshadow -Wconversion -fno-common -ffunction-sections -fdata-sections
CPPFLAGS = -MD
LDFLAGS = --static -nostartfiles -T$(TARGET).ld -Wl,-Map=$(TARGET).map -Wl,--gc-sections
LDLIBS = -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group

all: $(TARGET).bin $(TARGET).list

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -Obinary $< $@

$(TARGET).list: $(TARGET).elf
	$(OBJDUMP) -S $< > $@

$(TARGET).elf: $(TARGET).o vector.o $(ELMOASMFUNCTIONS) $(TARGET).ld
	$(LD) $(LDFLAGS) vector.o $(ARCH_FLAGS) $(TARGET).o $(ELMOASMFUNCTIONS) $(LDLIBS) -o $@

$(TARGET).o: $(TARGET).c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(ARCH_FLAGS) -c $< -o $@

vector.o:
	cp ../thirdparty/elmo/Examples/DPATraces/MBedAES/vector.o $@

elmoasmfunctions.o: ../thirdparty/elmo/Examples/elmoasmfunctions.o
	ln -sfn $< $@

clean:
	rm -f $(TARGET).o $(TARGET).d $(TARGET).elf $(TARGET).bin $(TARGET).list $(TARGET).map vector.o elmoasmfunctions.o
