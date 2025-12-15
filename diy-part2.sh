#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的 192.168.10.1 修改成你想要的就可以了
#sed -i 's/192.168.100.1/10.0.0.253/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/MuFVps_OP/g' package/base-files/files/bin/config_generate

# ttyd 自动登录
# sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages/ttyd/files/ttyd.config

# 添加自定义软件包
# echo '
# CONFIG_PACKAGE_luci-app-mosdns=y
# CONFIG_PACKAGE_luci-app-adguardhome=y
# CONFIG_PACKAGE_luci-app-openclash=y
# ' >> .config
# ---------------------------------------------------------
# 添加 Passwall 插件 (及其依赖)
# ---------------------------------------------------------

# 1. 下载 Passwall 源码
# 注意：Passwall 分为两个包，一个是主程序(luci-app)，一个是核心依赖(packages)，都需要下载
# 这里使用了 xiaorouji 的源码，它是目前更新最及时且兼容性最好的版本
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages

# 2. (可选) 预置编译配置
# 如果你想让固件编译出来默认就选上了 Passwall，不需要手动去菜单勾选，可以把下面这些加上
# 如果不加下面这些，你需要自己进入 make menuconfig -> LuCI -> Applications 手动勾选

echo "CONFIG_PACKAGE_luci-app-passwall=y" >> .config
echo "CONFIG_PACKAGE_luci-i18n-passwall-zh-cn=y" >> .config

# 3. (可选) 开启一些常用的核心组件 (防止运行时缺依赖1)
# 这些是 Passwall 运行通常需要的组件，建议默认开启
echo "CONFIG_PACKAGE_ipt2socks=y" >> .config
echo "CONFIG_PACKAGE_microsocks=y" >> .config
echo "CONFIG_PACKAGE_dns2socks=y" >> .config
echo "CONFIG_PACKAGE_pdnsd-alt=y" >> .config
echo "CONFIG_PACKAGE_chinadns-ng=y" >> .config
echo "CONFIG_PACKAGE_xray-core=y" >> .config
echo "CONFIG_PACKAGE_v2ray-core=y" >> .config
echo "CONFIG_PACKAGE_sing-box=y" >> .config
