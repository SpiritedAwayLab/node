#!/bin/bash
FILE=/root/deploy.sh
[ ! -f "$FILE" ] && curl -o- https://raw.githubusercontent.com/SpiritedAwayLab/node/main/install.sh | bash
