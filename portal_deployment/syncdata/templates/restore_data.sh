#!/bin/bash

pg_restore -Fc -vvv /home/ubuntu/backups/{{ backup_file }}
