#!/bin/bash

# golang
git clone --depth 1 --filter=blob:none --sparse https://github.com/immortalwrt/packages immortalwrt
cd immortalwrt && git sparse-checkout init --cone && git sparse-checkout set "lang/golang" && mv lang .. && cd .. && rm -rf immortalwrt

# luci-theme-argon
git clone --depth 1 -b master https://github.com/jerrykuku/luci-theme-argon ./luci-theme-argon

# homeproxy
git clone --depth 1 -b master https://github.com/immortalwrt/homeproxy ./luci-app-homeproxy

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
