FROM alpine:3.13

ENV S6_REL=2.2.0.3 S6_ARCH=amd64 TZ=Asia/Shanghai

LABEL base.maintainer=Roxedus
LABEL base.s6.rel=${S6_REL} base.s6.arch=${S6_ARCH}

RUN \
	set -eux && \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
	apk add --no-cache \
		curl \
		tar \
		bash \
		ca-certificates \
		coreutils \
		shadow \
		tzdata \
		libstdc++ \
		libgcc \
		icu-libs \
		libintl \
		libcap && \
	curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v${S6_REL}/s6-overlay-${S6_ARCH}.tar.gz | tar xzf - -C / &&  \
	groupmod -g 1000 users && \
	useradd -u 1000 -U -d /config -s /bin/false rox && \
	usermod -G users rox && \
	mkdir -p \
		/app \
		/config && \
	rm -rf /tmp/* && \
	mkdir -p /etc/cont-init.d && \
	echo IyEvdXNyL2Jpbi93aXRoLWNvbnRlbnYgYmFzaAoKUFVJRD0ke1BVSUQ6LTEwMDB9ClBHSUQ9JHtQR0lEOi0xMDAwfQoKZ3JvdXBtb2QgLW8gLWcgIiRQR0lEIiByb3gKdXNlcm1vZCAtbyAtdSAiJFBVSUQiIHJveAoKZWNobyAiClVzZXIgdWlkOiAgICAkKGlkIC11IHJveCkKVXNlciBnaWQ6ICAgICQoaWQgLWcgcm94KQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiIKCmNob3duIC1SIHJveDpyb3ggL2FwcApjaG93biAtUiByb3g6cm94IC9jb25maWc= | base64 -d >/etc/cont-init.d/1-prep-env
	
VOLUME [ "/config" ]

ENTRYPOINT ["/init"]