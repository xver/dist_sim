compile_verilator_sv:
	cd ../bin && ${VERILATOR}  -Wall  --trace -I../../../rtl  -I../../../include $(SHUNT_VERILATOR_FLAGS)  -f ../../../include/$(MANIFEST_INC) -f ../../../rtl/top_split_srv.f +define+split  +define+FRNG_N_OF_DST=$(FRNG_N_OF_DST) --exe ../../../makedir/sim_main.cpp	
	cd ../bin && make -C obj_dir -j -f Vshunt_verilator_dpi.mk Vshunt_verilator_dpi
.PHONY: clean
clean:	
	cd ../bin && rm -rf *
all: compile_verilator_sv
