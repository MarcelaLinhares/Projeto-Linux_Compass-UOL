#!/bin/bash

URL="http://10.0.2.15"
WEBHOOK="MEU_WEBHOOK_DO_DISCORD_AQUI"
LOG="/var/log/monitoramento.log"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
DATAHORA=$(date "+%d/%m/%Y %H:%M:%S")

if [ "$STATUS" -ne 200 ]; then
    echo "$DATAHORA | ERRO | Site fora do ar (status code: $STATUS)" >> $LOG
    curl -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"⚠️ ALERTA: O site está fora do ar (status $STATUS) - $DATAHORA\"}" \
         $WEBHOOK
else
    echo "$DATAHORA | OK | Site online (status code: $STATUS)" >> $LOG
fi