create:
	vagrant destroy -f base && \
	vagrant up base --provision && \
	vagrant vbguest base --status && \
	vagrant vbguest base --do install --auto-reboot && \
	vagrant reload && \
	vagrant vbguest base --status && \
	vagrant package --output ../base.box && \
	vagrant box add base ../base.box -f && \
	rm -rf ../base.box && \
	vagrant destroy -f base && \
	rm -rf .vagrant/
