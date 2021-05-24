# Overview

A simple docker image for creating backups of the openldap base and save them into s3.

# Configure s3
Use ENV-variable to configure rclone settings. At least you need **AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY**.

The full set of the variables can be found at [rclone docs](https://rclone.org/s3/).
