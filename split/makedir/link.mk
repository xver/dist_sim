compile_verilator_sv:
	cd ../bin && ${VERILATOR}  -Wall  --trace -I../../../rtl  -I../../../include $(SHUNT_VERILATOR_FLAGS)  -f ../../../include/$(MANIFEST_INC) -f ../../../rtl/top_split.f +define+split  +define+FRNG_N_OF_DST=$(FRNG_N_OF_DST) +define+SPLIT_LINK_ID=$(SPLIT_LINK_ID) --exe ../../../makedir/sim_main.cpp	
	cd ../bin && make -C obj_dir -j -f Vshunt_verilator_dpi.mk Vshunt_verilator_dpi
.PHONY: clean
clean:	
	cd ../bin && rm -rf *
all: compile_verilator_sv

.PHONY: verilator_run
verilator_run:
	./verilator_run	

show_id: 
	echo $(SPLIT_LINK_ID)
