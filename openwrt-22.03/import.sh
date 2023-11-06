#!/bin/bash

# golang 1.21+
git clone --depth 1 --filter=blob:none --sparse https://github.com/immortalwrt/packages immortalwrt
cd immortalwrt && git sparse-checkout init --cone && git sparse-checkout set "lang/golang" && mv lang .. && cd .. && rm -rf immortalwrt
# vssr 和他的依赖
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb/ ./maxminddb
git clone --depth 1 --branch main --filter=blob:none --sparse https://github.com/fw876/helloworld helloworld
cd helloworld && git sparse-checkout init --cone
for i in "naiveproxy" "shadowsocks-rust" "shadowsocksr-libev" "simple-obfs" "tcping" "trojan" "v2ray-core" "v2ray-plugin" "xray-core" "xray-plugin" "hysteria" "gn"; do \
  git sparse-checkout set "$i" && mv "$i" .. ; \
done
cd .. && rm -rf helloworld
git clone --depth 1 --branch main --filter=blob:none --sparse https://github.com/immortalwrt/packages immortalwrt
cd immortalwrt && git sparse-checkout init --cone
for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt" "redsocks2"; do \
  git sparse-checkout set "$i" && mv "$i" .. ; \
done
cd .. && rm -rf immortalwrt
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr/ ./luci-app-vssr
sed -i "s/ --no-check-certificate / /g" `grep wget-ssl -rl ./luci-app-vssr`
sed -i "s/wget-ssl/wget/g" `grep wget-ssl -rl ./luci-app-vssr`
sed -i "s/+wget/+wget-ssl/g" ./luci-app-vssr/Makefile
sed -i '/luci.model.ipkg/d' ./luci-app-vssr/luasrc/model/cbi/vssr/server.lua
# argon主题（适配最新版本luci）
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon/ ./luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config/ ./luci-app-argon-config
# uu加速器
git clone --depth 1 --filter=blob:none --sparse https://github.com/coolsnowwolf/packages coolsnowwolf
cd coolsnowwolf && git sparse-checkout init --cone && git sparse-checkout set "net/uugamebooster" && mv net/uugamebooster .. && cd .. && rm -rf coolsnowwolf
git clone --depth 1 --filter=blob:none --sparse https://github.com/coolsnowwolf/luci coolsnowwolf
cd coolsnowwolf && git sparse-checkout init --cone && git sparse-checkout set "applications/luci-app-uugamebooster" && mv applications/luci-app-uugamebooster .. && cd .. && rm -rf coolsnowwolf
# chinadns-ng
git clone --depth 1 https://github.com/pexcn/openwrt-chinadns-ng/ ./chinadns-ng
git clone --depth 1 https://github.com/izilzty/luci-app-chinadns-ng/ ./luci-app-chinadns-ng
# smartdns
git clone --depth 1 https://github.com/pymumu/openwrt-smartdns/ ./smartdns
git clone --depth 1 https://github.com/pymumu/luci-app-smartdns/ ./luci-app-smartdns
# 修改语言包适配
/tmp/convert.sh .
# 修改 luci.mk 文件路径
find ./ -iname Makefile -exec sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' {} +

# 统一清理
find ./*/ -name '.svn' | xargs rm -rf
find ./*/ -name '.git' | xargs rm -rf
find ./*/ -name '.github' | xargs rm -rf
find ./*/ -name '.gitattributes' | xargs rm -rf
find ./*/ -name '.gitignore' | xargs rm -rf
rm README.md

exit 0
