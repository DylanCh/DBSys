$ cat backup_db_encrypted.sh
#!/bin/bash
# #######################
#   openssl smime -decrypt -in my_database.sql.sql.bz2.enc -binary -inform DEM -inkey private.pem | bzcat >  my_database.sql.sql
#
# #######################

# Database Name
database_name="$1"

backup_public_key="/iscape/etc/backup_key.pem.pub"

# Location to place backups.
backup_dir="/iscape/backups/database/"

# Numbers of days you want to keep copies of your databases
number_of_days=30

if [ -z ${database_name} ]
then
 echo "Please specify a database name as the first argument"
 exit 1
fi

# String to append to the name of the backup files
backup_date=`date +%Y-%m-%d-%H-%M-%S`

DB=backup_date
# converting a table to csv file
psql -Atc "select tablename from pg_tables" $DB |\
  while read TBL; do
    psql -c "COPY $SCHEMA.$TBL TO STDOUT WITH CSV" $DB > $TBL.csv
  done

echo "Dumping ${database_name} to ${backup_dir}${database_name}\_$TBL.csv.bz2.enc"
pg_dump ${database_name}|bzip2|openssl smime -encrypt \
 -aes256 -binary -outform DEM \
 -out ${backup_dir}${database_name}\_${backup_date}.sql.bz2.enc \
 "${backup_public_key}"

find ${backup_dir} -type f -prune -mtime \
    +${number_of_days} -exec rm -f {} \;