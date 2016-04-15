#!/usr/bin/env ruby
######## Back up last 3 days or more databases file ##########

today = Time.now.strftime("%Y-%m-%d") 

# change keep_file_number if you want to keep more backup versions
keep_file_number = 3
old_date = (Time.now-(keep_file_number*24*3600)).strftime("%Y-%m-%d")

backup_dir = "#{Dir.home}/sqldump"

Dir.mkdir(backup_dir) unless Dir.exist?(backup_dir)
db_config = {
  :username=>'mysql user name',
  :password=>'mysql password',
  :host=>'mysql host',
  :database=>'the database you want to backup'
}

options = "--skip-extended-insert --hex-blob --lock-tables=false"
backup_file = "#{backup_dir}/#{db_config[:database]}_#{today}.sql"
`mysqldump -h#{db_config[:host]} -u#{db_config[:username]} -p#{db_config[:password]} #{options} #{db_config[:database]} | gzip -c > #{backup_file}.gz`

old_file = "#{backup_dir}/#{db_config[:database]}_#{old_date}.sql"
`rm -f #{old_file}`
