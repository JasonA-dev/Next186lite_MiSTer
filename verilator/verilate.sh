verilator \
-cc -exe --public --trace --savable \
--compiler msvc +define+SIMULATION=1 \
-O3 --x-assign fast --x-initial fast --noassert \
--converge-limit 6000 \
-Wno-UNOPTFLAT \
--top-module top sim.v \
../rtl/next186.sv \
../rtl/rom.v \
../rtl/bram.sv \
../rtl/bramcache.sv \
../rtl/ZXUno/system_2MB.v \
../rtl/common/cache_controller.v \
../rtl/common/KB_8042.v \
../rtl/common/PIC_8259.v \
../rtl/common/unit186.v \
../rtl/ZXUno/seg_map_2MB.sv \
../rtl/common/timer8253.v \
../rtl/jtopl2/hdl/jtopl.v \
../rtl/jtopl2/hdl/jtopl_acc.v \
../rtl/jtopl2/hdl/jtopl_csr.v \
../rtl/jtopl2/hdl/jtopl_div.v \
../rtl/jtopl2/hdl/jtopl_eg.v \
../rtl/jtopl2/hdl/jtopl_eg_comb.v \
../rtl/jtopl2/hdl/jtopl_eg_cnt.v \
../rtl/jtopl2/hdl/jtopl_eg_ctrl.v \
../rtl/jtopl2/hdl/jtopl_eg_final.v \
../rtl/jtopl2/hdl/jtopl_eg_pure.v \
../rtl/jtopl2/hdl/jtopl_eg_step.v \
../rtl/jtopl2/hdl/jtopl_exprom.v \
../rtl/jtopl2/hdl/jtopl_lfo.v \
../rtl/jtopl2/hdl/jtopl_logsin.v \
../rtl/jtopl2/hdl/jtopl_mmr.v \
../rtl/jtopl2/hdl/jtopl_noise.v \
../rtl/jtopl2/hdl/jtopl_op.v \
../rtl/jtopl2/hdl/jtopl_pm.v \
../rtl/jtopl2/hdl/jtopl_pg.v \
../rtl/jtopl2/hdl/jtopl_pg_inc.v \
../rtl/jtopl2/hdl/jtopl_pg_comb.v \
../rtl/jtopl2/hdl/jtopl_pg_rhy.v \
../rtl/jtopl2/hdl/jtopl_pg_sum.v \
../rtl/jtopl2/hdl/jtopl_reg.v \
../rtl/jtopl2/hdl/jtopl_sh.v \
../rtl/jtopl2/hdl/jtopl_sh_rst.v \
../rtl/jtopl2/hdl/jtopl_single_acc.v \
../rtl/jtopl2/hdl/jtopl_timers.v \
../rtl/jtopl2/hdl/jtopl2.v \
../rtl/graphics-gremlin/cga_attrib.v \
../rtl/graphics-gremlin/cga_composite.v \
../rtl/graphics-gremlin/cga_pixel.v \
../rtl/graphics-gremlin/cga_scandoubler.v \
../rtl/graphics-gremlin/cga_sequencer.v \
../rtl/graphics-gremlin/cga_top.v \
../rtl/graphics-gremlin/cga_vgaport.v \
../rtl/graphics-gremlin/cga.v \
../rtl/graphics-gremlin/crtc6845.v \
../rtl/common/sram.v \
../rtl/ipcore/BRAM_8KB_BIOS.v \
../rtl/ipcore/BRAM_32KB_CRTC.v \
../rtl/ipcore/cache.v \
../rtl/Next186/Next186_ALU.v \
../rtl/Next186/Next186_BIU_2T_delayread.v \
../rtl/Next186/Next186_CPU.v \
../rtl/Next186/Next186_Regs.v