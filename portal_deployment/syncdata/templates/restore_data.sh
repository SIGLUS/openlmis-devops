#!/bin/bash

pg_restore -f /home/ubuntu/{{ backup_file }}.log -Fc /home/ubuntu/backups/{{ backup_file }}
