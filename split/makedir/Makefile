export FRNG_N_OF_DST ?= 1
export LINK_NAME ?= link
export VERILATOR ?= verilator
compile_verilator_sv: build_srv build_link compile_srv compile_link


.PHONY: build_srv
build_srv:
	mkdir -p ../srv ;
	mkdir -p ../srv/bin ;
	mkdir -p ../srv/makedir ;
	cp srv.mk ../srv/makedir/Makefile
	cp verilator_run.scr ../srv/makedir/verilator_run

.PHONY: build_link
build_link: 
	echo "export FRNG_N_OF_DST=$(FRNG_N_OF_DST)" > FRNG_N_OF_DST 
	number=0; while [ "$$number" -lt $(FRNG_N_OF_DST) ]; do \
	DIR_NAME=$(LINK_NAME)_$$number;\
	echo "DIR_NAME=$$DIR_NAME" ;\
	mkdir -p ../$$DIR_NAME ;\
	mkdir -p ../$$DIR_NAME/bin ;\
	mkdir -p ../$$DIR_NAME/makedir ;\
	cp ./link.mk ../$$DIR_NAME/makedir/Makefile ;\
	cp verilator_run.scr ../$$DIR_NAME/makedir/verilator_run ;\
	echo "export SPLIT_LINK_ID ?="$$number >> ../$$DIR_NAME/makedir/Makefile ;\
	number=$$((number + 1));\
  done

compile_srv:
	cd ../srv/makedir && $(MAKE) compile_$(SIM)_sv

compile_link:
	number=0; while [ "$$number" -lt $(FRNG_N_OF_DST) ]; do \
	DIR_NAME=$(LINK_NAME)_$$number;\
	echo "COMPILE DIR_NAME=$$DIR_NAME PWD=$(PWD)" ;\
	$(MAKE) -C ../$$DIR_NAME/makedir compile_$(SIM)_sv ;\
	number=$$((number + 1));\
  done

.PHONY: build_split
build_split: clean build_srv build_link compile_srv compile_link

.PHONY: verilator_run
verilator_run:
	pwd;ls
	./verilator_run		
#	cd ../srv/makedir  && ./$(SIM)_run \
#	cd ../link_0/makedir  && ./$(SIM)_run \
#	cd ../link_1/makedir  && ./$(SIM)_run
#	number=0; while [ "$$number" -lt $(FRNG_N_OF_DST) ]; do \
#	DIR_NAME=$(LINK_NAME)_$$number;\
#	echo "RUN DIR_NAME=$$DIR_NAME PWD=$(PWD)" ;\
#	$(MAKE) -C ../$$DIR_NAME/makedir $(SIM)_run ;\
#	number=$$((number + 1));\
#  done

.PHONY: clean
clean:	
	rm -rf ../link* ../srv

