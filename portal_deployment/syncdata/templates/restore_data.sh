#!/bin/bash

pg_restore -Fc /home/ubuntu/backups/{{ backup_file }}
