#!/bin/bash

# golang
git clone --depth 1 --filter=blob:none --sparse https://github.com/immortalwrt/packages immortalwrt
cd immortalwrt && git sparse-checkout init --cone && git sparse-checkout set "lang/golang" && mv lang .. && cd .. && rm -rf immortalwrt

# luci-theme-design
git clone --depth 1 -b js https://github.com/gngpp/luci-theme-design ./luci-theme-design

# luci-theme-argon
git clone --depth 1 -b master https://github.com/jerrykuku/luci-theme-argon ./luci-theme-argon

# passwall2
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2/ ./luci-app-passwall2
mv ./luci-app-passwall2/luci-app-passwall2/* ./luci-app-passwall2/
rm -rf ./luci-app-passwall2/luci-app-passwall2/
git clone --depth 1 --branch main --filter=blob:none --sparse https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages
cd openwrt-passwall-packages && git sparse-checkout init --cone
for i in "tcping" "v2ray-core" "xray-core" "v2ray-geodata" "sing-box"; do \
  git sparse-checkout set "$i" && mv "$i" .. ; \
done
cd .. && rm -rf openwrt-passwall-packages

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
