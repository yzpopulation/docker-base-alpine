# docker-base-alpine

root\etc\cont-init.d\1-prep-env  file

```
#!/usr/bin/with-contenv bash

PUID=${PUID:-1000}
PGID=${PGID:-1000}

groupmod -o -g "$PGID" rox
usermod -o -u "$PUID" rox

echo "
User uid:    $(id -u rox)
User gid:    $(id -g rox)
-------------------------------------
"

chown -R rox:rox /app
chown -R rox:rox /config
```