#!/bin/bash
# Downloads every starred repo from a user. 
# Mostly incase they go down, so you can have a backup.
#

user="eugenekolo"
pages=$(curl -I https://api.github.com/users/$user/starred | sed -nr 's/^Link:.*page=([0-9]+).*/\1/p')

for page in $(seq 0 $pages); do
    curl "https://api.github.com/users/$user/starred?page=$page&per_page=100" | awk '/^ {4}"html_url"/&&$0=$4' FS='"' |
    while read rp; do
      git clone $rp
    done
done
