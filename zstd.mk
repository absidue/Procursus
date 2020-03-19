ifneq ($(CHECKRA1N_MEMO),1)
$(error Use the main Makefile)
endif

ZSTD_VERSION := 1.4.4

ifneq ($(wildcard $(BUILD_WORK)/zstd/.build_complete),)
zstd:
	@echo "Using previously built zstd."
else
zstd: setup lz4 xz
	$(SED) -i s/'($$(shell uname), Darwin)'/'($$(shell test -n),)'/ $(BUILD_WORK)/zstd/lib/Makefile
	$(MAKE) -C $(BUILD_WORK)/zstd install \
		PREFIX=/usr \
		DESTDIR=$(BUILD_STAGE)/zstd
	$(MAKE) -C $(BUILD_WORK)/zstd install \
		PREFIX=/usr \
		DESTDIR=$(BUILD_BASE)
	$(MAKE) -C $(BUILD_WORK)/zstd/contrib/pzstd install \
		PREFIX=/usr \
		DESTDIR=$(BUILD_STAGE)/zstd
	touch $(BUILD_WORK)/zstd/.build_complete
endif

.PHONY: zstd
