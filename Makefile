include $(TOPDIR)/rules.mk

LUCI_TITLE:=QEMU Virtual Machine Manager
LUCI_PKGARCH:=all

PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage