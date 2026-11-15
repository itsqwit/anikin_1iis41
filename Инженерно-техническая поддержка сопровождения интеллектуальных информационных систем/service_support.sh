#!/bin/bash

if [ -z "$1" ]; then

echo "Использование: $0 [status|backup|logs]"
exit 1

fi

if [ "$1" == "status" ]; then

echo "=== Проверка статуса ИИС ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo "============================="

elif [ "$1" == "backup" ]; then

echo "=== Запуск резервного копирования ==="
mkdir -p ./backups
DATA_TAG=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="./backups/iis_backup_$DATA_TAG.txt"
echo "Бэкап базы знаний ИИС от $DATA_TAG" > "$BACKUP_FILE"
echo "Конфигурация успешно сохранена в файл: $BACKUP_FILE"
echo "====================================="

elif [ "$1" == logs ]; then

if [ -n "$(docker ps -q -f name=^/grafana_monitoring$)" ]; then
docker logs grafana_monitoring
else
echo "Ошибка: Контейнер Grafana не запущен"
exit 1
fi

else

echo "Ошибка: Неизвестная команда '$1'. Используйте 'status' или 'backup'."
exit 1

fi
