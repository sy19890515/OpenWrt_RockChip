# tar -czvf everything.tar.gz /etc/ /tmp/ /usr/

cd /home/y29shi/OpenWrt_RockChip
chmod +x immortalwrt/*.sh
/home/y29shi/OpenWrt_RockChip/immortalwrt/system-Information.sh

git clone --depth 1 https://github.com/immortalwrt/immortalwrt -b openwrt-25.12 openwrt

cd openwrt
# sed -i '1i src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main\n' feeds.conf.default
# sed -i '1i src-git passwall_luci https://github.com/Openwrt-Passwall/openwrt-passwall.git;main\n' feeds.conf.default
# sed -i '1i src-git passwall2_luci https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main\n' feeds.conf.default
./scripts/feeds update -a

# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang feeds/packages/lang/golang
# Fix wget APK packaging error (remove invalid @wget-any virtual package syntax)
sed -i 's/PROVIDES:=wget @wget-any/PROVIDES:=wget/' feeds/packages/net/wget/Makefile

./scripts/feeds install -a


cd ..
chmod +x immortalwrt/*.sh && cd openwrt
../immortalwrt/diy-part1.sh

cd ..
[ -e "immortalwrt/rockchip/defconfig" ] && cat "immortalwrt/rockchip/defconfig" > openwrt/.config
chmod +x immortalwrt/*.sh && cd openwrt
../immortalwrt/diy-part2.sh

echo '
CONFIG_DOCKER_CGROUP_OPTIONS=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_DOCKER_STO_EXT4=y
CONFIG_PACKAGE_docker=y
CONFIG_PACKAGE_docker-compose=y
CONFIG_PACKAGE_dockerd=y
CONFIG_PACKAGE_luci-app-dockerman=y
CONFIG_PACKAGE_luci-app-netspeedtest=y
CONFIG_PACKAGE_luci-i18n-dockerman-zh-cn=y
CONFIG_PACKAGE_luci-lib-docker=y
' >> .config
make defconfig
make download -j$(nproc)
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;

rm ../build.log
make -j$(nproc) 2>&1 | tee ../build.log || make -j1 2>&1 | tee -a ../build.log || make -j1 V=sc 2>&1 | tee -a ../build.log

cd bin
find packages/ -type f -name '*.*pk' | zip targets/rockchip/armv8/packages.zip -@