#!/bin/bash
#
# Modify default IP
sed -i 's/192.168.1.1/192.168.4.1/g' package/base-files/files/bin/config_generate
# sed -i "s/ImmortalWrt/OpenWrt/g" package/base-files/files/bin/config_generate

# Modify package version
# sed -i 's/4.50.1/4.44.3/g' packages/utils/yq/Makefile
# sed -i 's/ec55f107fbfe1d8226c1d4d74def734672f9aa58165029819ddfb771339e53a1/ea950f5622480fc0ff3708c52589426a737cd4ec887a52922a74efa1be8f2fbf/g' packages/utils/yq/Makefile
# sed -i 's/25.12.8/1.8.24/g' packages/net/xray-core/Makefile
# sed -i 's/d4519b2d9bb1871f4d7612aa7a8db1c451573b5a44ac824219bb44d63f404e61/86e3e388c77cda4d8457a607356416c201c1f18bbed53f0a9e76a228508ff298/g' packages/net/xray-core/Makefile
# sed -i 's/0.2.2/0.2.0/g' packages/net/geoview/Makefile
# sed -i 's/631d90187ad50263971d8eea4a539c30991a1cf3249b1bbdeca599060194f11c/27bf61e0ee36e551ef3a19c792ac0e1a2864e5f960513c8329d0e3ec4926da33/g' packages/net/geoview/Makefile
# sed -i 's/0.1.32-1/0.1.32/g' package/community/istore/luci/luci-app-store/Makefile
# sed -i 's/PKG_RELEASE:=/PKG_RELEASE:=1/g' package/community/istore/luci/luci-app-store/Makefile