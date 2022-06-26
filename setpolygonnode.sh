cat >/root/.forta/config.yml <<EOF
chainId: 137

scan:
  jsonRpc:
#    url: https://polygon-mainnet.g.alchemy.com/v2/1PujIdxTuq4PdIAZZQRFLKZgtUY84sm1
     url: https://polygon-rpc.com/
trace:
  enabled: false
EOF

sudo systemctl restart forta
