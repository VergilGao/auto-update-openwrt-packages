#!/bin/bash

# vssr 和他的依赖
svn co https://github.com/jerrykuku/lua-maxminddb/trunk ./maxminddb
for i in "naiveproxy" "shadowsocks-rust" "shadowsocksr-libev" "simple-obfs" "tcping" "trojan" "v2ray-core" "v2ray-plugin" "xray-core" "xray-plugin"; do \
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
# 基于DNS的广告过滤
svn co https://github.com/small-5/luci-app-adblock-plus/trunk ./luci-app-adblock-plus
# ddns_pod
svn co https://github.com/VergilGao/ddns-scripts-dnspod/trunk ./ddns-scripts-dnspod
# uu加速器
svn co https://github.com/coolsnowwolf/packages/trunk/net/uugamebooster
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-uugamebooster
# 修改语言包适配
/tmp/convert.sh .

# 统一清理
rm -rf .svn
rm -rf ./*/.git
rm -rf ./*/.github
rm -rf ./*/.svn 
rm -f .gitattributes .gitignore
rm README.md

exit 0
