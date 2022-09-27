#!/bin/bash

mkdir lang

# golang 1.18+
svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang ./lang/golang

# smartdns
svn co https://github.com/VergilGao/openwrt-smartdns/trunk ./smartdns
svn co https://github.com/VergilGao/luci-app-smartdns/trunk ./luci-app-smartdns
# vssr 和他的依赖
svn co https://github.com/jerrykuku/lua-maxminddb/trunk ./maxminddb
for i in "naiveproxy" "shadowsocks-rust" "shadowsocksr-libev" "simple-obfs" "tcping" "trojan" "v2ray-core" "v2ray-plugin" "xray-core" "xray-plugin" "hysteria"; do \
  svn co "https://github.com/fw876/helloworld/trunk/$i" "$i"; \
done
for i in "dns2socks" "microsocks" "ipt2socks" "pdnsd-alt" "redsocks2"; do \
  svn co "https://github.com/immortalwrt/packages/trunk/net/$i" "$i"; \
done
svn co https://github.com/jerrykuku/luci-app-vssr/trunk ./luci-app-vssr
sed -i "s/ --no-check-certificate / /g" `grep wget-ssl -rl ./luci-app-vssr`
sed -i "s/wget-ssl/wget/g" `grep wget-ssl -rl ./luci-app-vssr`
# argon主题（适配最新版本luci）
svn co https://github.com/jerrykuku/luci-theme-argon/trunk ./luci-theme-argon
svn co https://github.com/jerrykuku/luci-app-argon-config/trunk ./luci-app-argon-config
# ddns_pod
svn co https://github.com/VergilGao/ddns-scripts-dnspod/trunk ./ddns-scripts-dnspod
# ddns_aliyun
svn co https://github.com/VergilGao/ddns-scripts-aliyun/trunk ./ddns-scripts-aliyun
# uu加速器
svn co https://github.com/coolsnowwolf/packages/trunk/net/uugamebooster
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-uugamebooster
# 修改语言包适配
/tmp/convert.sh .
# 修改 luci.mk 文件路径
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' `find ./ -name Makefile`

# 统一清理
find ./*/ -name '.svn' | xargs rm -rf
find ./*/ -name '.git' | xargs rm -rf
find ./*/ -name '.github' | xargs rm -rf
find ./*/ -name '.gitattributes' | xargs rm -rf
find ./*/ -name '.gitignore' | xargs rm -rf
rm README.md

exit 0
