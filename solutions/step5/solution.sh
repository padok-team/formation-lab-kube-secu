#!/bin/bash

aws s3api list-buckets
aws s3api list-objects --bucket bucket-flag-kube-lab-stancer
aws s3api get-object --bucket bucket-flag-kube-lab-stancer --key my-object.txt flag.txt
