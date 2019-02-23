VASM        = ./vasmm68k_mot
VLINK       = ./vlink
BIN         = rom.bin
SRC         = rom.s
VASM_FLAGS  = -phxass -x -Fbin

.PHONY: all all-before all-after clean clean-custom run run-custom

all: all-before $(BIN) all-after

clean: clean-custom
	rm -rf $(BIN)

$(BIN): $(SRC)
	$(VASM) $(SRC) $(VASM_FLAGS) -o $(BIN)

run: run-custom
	fs-uae --chip_memory=1024 --kickstart_file=`pwd`/$(BIN) --joystick_port_1=none --amiga_model=A1200 --slow_memory=1792 --remote_debugger=200 --use_remote_debugger=true --automatic_input_grab=0
