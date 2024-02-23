#!/bin/bash

# passwall2
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2/ ./luci-app-passwall2
mv ./luci-app-passwall2/luci-app-passwall2/* ./luci-app-passwall2/
rm -rf ./luci-app-passwall2/luci-app-passwall2/

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
