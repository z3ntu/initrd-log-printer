remotecompile:
	$(info Copying main.c to rpi)
	@scp -q initrd-log-printer.c pi3_vps:/tmp/initrd-log-printer.c
	$(info Letting the rpi compile)
	@ssh -q pi3_vps "gcc -static /tmp/initrd-log-printer.c -o /tmp/initrd-log-printer"
	$(info Copying the executable back)
	@scp -q pi3_vps:/tmp/initrd-log-printer .

upload:
	pv ./initrd-log-printer | nc 172.16.42.1 60000

receive:
	@echo "Run 'nc -v -l -p 60000 > initrd-log-printer' on the target device."

clean:
	@rm ./initrd-log-printer

.PHONY: remotecompile
