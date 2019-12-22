include ./Sim.mk
-include ../../../../utils/makefile.init

export FRNG_N_OF_DST ?= 1

export SHUNT_VERILATOR_FLAGS

ifeq (${VERILATOR},)
export VERILATOR = verilator
endif

ifeq ($(MANIFEST_INC),)
export MANIFEST_INC = inc.f 
endif

export SIM ?= verilator
################
###SHUNT
# check shunt environment setting
check_shunt:
	$(MAKE) -f ../../../../utils/makefile.init
# build Shunt 
build_shunt: check_shunt
	cd ${SHUNT_HOME}/utils/makedir && $(MAKE) all

.PHONY: clean_shunt
clean_shunt:
	cd ${SHUNT_HOME}/bin && rm -rf *
################
###ORIGIN 
.PHONY: make_all_origin
make_all_origin: clean_origin  build_shunt build_origin_sv run_origin

.PHONY: make_origin
make_origin: build_shunt build_origin_sv run_origin

.PHONY: clean_origin
clean_origin:
	cd ../origin/makedir &&  $(MAKE) clean

build_origin_sv: 
ifeq ($(SIM),verilator)
	cd ../origin/makedir && $(MAKE) compile_$(SIM)_sv
endif

.PHONY: run_origin
run_origin:
	cd ../origin/makedir  && ./$(SIM)_run

#######################
###MODIFIED
.PHONY: make_all_modified
make_all_modified: clean_modified  build_shunt build_modified_sv run_modified

.PHONY: make_modified
make_modified: build_shunt build_modified_sv run_modified

.PHONY: clean_modified
clean_modified:
	cd ../modified/makedir &&  $(MAKE) clean

build_modified_sv: 
ifeq ($(SIM),verilator)
	cd ../modified/makedir && $(MAKE) compile_$(SIM)_sv
endif

.PHONY: run_modified
run_modified:
	cd ../modified/makedir  && ./$(SIM)_run

####################
.PHONY: build_insert_db
build_insert_db:
	./insert_db_init.py ../modified/bin/modf.log  ../include/db_init_template.svi ../include/db_init.svi
###################
###Anchor
.PHONY: make_all_anchor
make_all_anchor: clean_anchor  build_shunt build_anchor_sv run_anchor

.PHONY: make_anchor
make_anchor: build_shunt build_anchor_sv run_anchor

.PHONY: clean_anchor
clean_anchor:
	cd ../anchor/makedir      &&  $(MAKE) clean
	cd ../anchor/makedir_srv  &&  $(MAKE) clean

build_anchor_sv: 
ifeq ($(SIM),verilator)
	cd ../anchor/makedir     &&  $(MAKE) compile_$(SIM)_sv
	cd ../anchor/makedir_srv &&  $(MAKE) compile_$(SIM)_sv
endif

.PHONY: run_anchor
run_anchor:
	cd ../anchor/makedir_srv  && ./$(SIM)_run
	cd ../anchor/makedir      && ./$(SIM)_run
###################
###split
.PHONY: make_all_split
make_all_split: clean_split  build_shunt build_split_sv run_split

.PHONY: make_split
make_split: build_shunt build_split_sv run_split

.PHONY: clean_split
clean_split:
	cd ../split/makedir &&  $(MAKE) clean

build_split_sv: 
ifeq ($(SIM),verilator)
	cd ../split/makedir &&  $(MAKE) clean && $(MAKE) compile_$(SIM)_sv
endif

.PHONY: run_split
run_split:
	echo "run ./verilator_run_split"
###################
###ALL
#build_split: build_c 
#ifeq ($(SIM),verilator)
#	cd ../split/makedir && $(MAKE) build_split
#endif

.PHONY:	clean_all
clean_all: clean_origin clean_modified clean_anchor clean_split

.PHONY: build_all
build_all: build_shunt build_origin_sv run_origin build_modified_sv run_modified build_insert_db build_anchor_sv build_split_sv run_split
###################

