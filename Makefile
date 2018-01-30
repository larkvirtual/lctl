install:
	@cp lctl /usr/bin
	-@grep -q "altlinux" /etc/os-release 2> /dev/null; \
if [ $$? = 0 ]; then \
echo "Installing required package bash4, as existing /bin/bash is version 3"; \
apt-get install bash4 -y && \
sed -i 's/\#\!\/bin\/bash/\#\!\/bin\/bash4/' /usr/bin/lctl; \
fi
	@if [ `uname` = FreeBSD ]; then \
echo "Installing required package bash, as bash (any version) is missing"; \
pkg install bash; \
sed 's/\#\!\/bin\/bash/\#\!\/usr\/local\/bin\/bash/' /usr/bin/lctl > /usr/local/bin/lctl; \
sed -i '' 's/\/usr\/bin\/lctl\.version/\/usr\/local\/bin\/lctl\.version/' /usr/local/bin/lctl; \
chmod a+x /usr/local/bin/lctl; \
rm -f /usr/bin/lctl; fi

uninstall:
	@if [ `uname` = FreeBSD ]; then \
rm -f /usr/local/bin/lctl; \
else rm -f /usr/bin/lctl; fi
# if distro is altlinux, then bash4 package should be removed
# if os is freebsd, then bash package should be removed

update:
	sudo make uninstall && git pull && sudo make install
