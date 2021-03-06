#!/bin/bash

echo "Salvando local:"
# backup Path
BACKUP_PATH=/home/matheus/NetBeansProjects/Turism/backup/arquivo/

# database settings
DB_NAME="turism"
DB_USER="root"
DB_PASS="madsr1411"

# current timestamp
TIMESTAMP=$(date +%s)

FILENAME=${DB_NAME}_${TIMESTAMP}.sql

# svn up the content
cd ${BACKUP_PATH}

# remove previous backups
rm ${BACKUP_PATH}*.sql
rm ${BACKUP_PATH}*.gz

# dump the database using the mysql administrator - so we can see all dbs
#mysqldump -u$DB_USER -p$DB_PASS --opt --routines --skip-extended-insert --compact --force "${DB_NAME}" > "${FILENAME}"
mysqldump -u$DB_USER -p$DB_PASS --force "${DB_NAME}" > "${FILENAME}"

# compress file
tar -czvf bkp_turism_${TIMESTAMP}.tar.gz ${FILENAME}

echo "Salvo e compactado!"

echo "Subindo para Google Drive"

cd /home/matheus/NetBeansProjects/Turism/backup/

python backup_initiator.py --backup-file-name "bkp_turism"

echo -e "\nBackup feito: "${TIMESTAMP} >> ${BACKUP_PATH}log_banco.txt
