#!/bin/sh

# terminate on errors
set -e

# Check if volume is empty
if [ ! "$(ls -A "/var/www/html/wp-content" 2>/dev/null)" ]; then
    echo 'Setting up wp-content volume'
    # Copy wp-content from Wordpress src to volume
    cp -r /usr/src/wordpress/wp-content /var/www/html
    chown -R nobody.nobody /var/www/html

    # Generate secrets
    curl -f https://api.wordpress.org/secret-key/1.1/salt/ >> /usr/src/wordpress/wp-secrets.php
fi