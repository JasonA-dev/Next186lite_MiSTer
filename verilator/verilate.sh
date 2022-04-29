verilator \
-cc -exe --public \
--compiler msvc +define+SIMULATION=1 \
-O3 --x-assign fast --x-initial fast --noassert \
--converge-limit 6000 \
-Wno-fatal \
--top-module top sim.v \
../rtl/next186.sv \
../rtl/rom.v \
../rtl/bram.sv \
../rtl/bramcache.sv \
../rtl/common/cache_controller.v \
../rtl/common/KB_8042.v \
../rtl/common/PIC_8259.v \
../rtl/common/unit186.v \
../rtl/common/sram.v \
../rtl/common/timer8253.v \
../rtl/ZXUno/seg_map_2MB.sv \
../rtl/ZXUno/system_2MB.v \
-I../rtl/jtopl2/hdl/ \
-I../rtl/graphics-gremlin/ \
../rtl/ipcore/BRAM_8KB_BIOS.v \
../rtl/ipcore/BRAM_32KB_CRTC.v \
../rtl/ipcore/cache.v \
../rtl/Next186/Next186_ALU.v \
../rtl/Next186/Next186_BIU_2T_delayread.v \
../rtl/Next186/Next186_CPU.v \
../rtl/Next186/Next186_Regs.v
