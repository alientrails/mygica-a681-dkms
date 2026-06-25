KDIR ?= /lib/modules/$(KERNELRELEASE)/build

obj-m += mygica_a681.o
mygica_a681-objs := cxusb.o mn88436.o

ccflags-y += -I$(src) -DCONFIG_DVB_MN88436_MODULE

all:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean
