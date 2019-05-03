import os
import sys
import subprocess

if os.getuid() != 0:
    print('Please run this scipt as root/with sudo.')
    sys.exit(2)

base_image_path = str(input('Enter the path to the base image [./base.img]: '))
tmp_mount_point = str(input('Enter the tompoary mount point [/tmp/trutlewriter]: ') or '/tmp/turtlewriter')
disk_image_offset = ''

if base_image_path == '':
    base_image_path = './base.img'
    while disk_image_offset == '':
        print('\r')
        int(input('Please enter the partition offset (sector count x sector size): ', end=''))

subprocess.run(['mkdir', ' -p', tmp_mount_point])
subprocess.run(['mount', '-o', 'loop,offset=', disk_image_offset, base_image_path, tmp_mount_point])


