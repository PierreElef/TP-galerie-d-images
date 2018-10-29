#!/bin/bash

imgs=`find ./images -type f  \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" \) | cut -c 10-`

for img in $imgs
do
	chmod 755 images/$img
done

exit 0