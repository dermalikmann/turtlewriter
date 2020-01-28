#!/usr/bin/env python3
import os
import sys
import subprocess
import time

scriptdir = str(os.path.dirname(os.path.realpath(__file__)))

hostname_prefix = "turtlebot" 
hostname_id = 1
current_hostname = ""

def new_hostname():
    global current_hostname
    global hostname_id
    global hostname_prefix
    current_hostname = hostname_prefix + str(hostname_id)
    hostname_id = hostname_id + 1

if os.getuid() != 0:
    print('Please run this scipt as root/with sudo.')
    sys.exit(2)

base_image_path = str(input('Enter the path to the base image [./base.img]: '))
#tmp_mount_point = str(input('Enter the temporary mount point [/tmp/trutlewriter]: ') or '/tmp/turtlewriter')
tmp_mount_point = subprocess.check_output('mktemp -d', shell=True).decode("UTF-8").rstrip()

if base_image_path == '':
    base_image_path = './base.img'

#build = int(input('Should be the project be build on first boot? (0|1) [1]') or 1)
count = int(input('Please enter how many turtles you want to write [1]: ') or 1)
hostname_id = int(input('Please enter wich ID should be started with [1]: ') or 1)
device_id = str(input('Please insert SD card and enter device identifier [/dev/mmcblk0]: ') or '/dev/mmcblk0')
subprocess.run(['sync'])

print()

for x in range(count):
    new_hostname()

    input('Please insert new sd card and press <ENTER>')
    print('Flashing...')
    print('    Writing basimage... ', end='')
    sys.stdout.flush()
    with open(os.devnull, 'w') as devnull:
        subprocess.run(['sync'])
        subprocess.run(['dd', 'if=' + base_image_path, 'of=' + device_id, 'bs=4M'], stdout=devnull, stderr=devnull)
        #subprocess.run(['dd', 'if=' + base_image_path, 'of=' + device_id, 'bs=4M'])
        subprocess.run(['sync'])
    print('Done')

    print('    Remounting Drive...', end='')
    subprocess.run(['partprobe'])
    
    time.sleep(1)

    subprocess.run(['mount', device_id + 'p2' if 'mmcblk' in device_id else device_id + '2', tmp_mount_point])

    print('Done')

    print('    Copying overlay... ')

    subprocess.run(['rsync', '-a',
                scriptdir + '/overlay/',
                tmp_mount_point + '/'])

    print('    Setting file permissions...')

    #if build == 1:
    #    with (tmp_mount_point + '/opt/firstrun/scripts/nobuildnoinstall', 'w') as bf:
    #        bf.write('1')

    with open('permissions.txt', 'r') as permfile:
        line = permfile.readline().strip()
        while line:
            print('        ' + line)
            permission, owner, path = line.split(' ')
            subprocess.run(['chmod', '-R', permission, tmp_mount_point + path])
            subprocess.run(['chown', '-R', owner, tmp_mount_point + path])
            line = permfile.readline().strip()

    print('    Writing new hostname \'' + current_hostname + '\'... ', end='')
    with open(tmp_mount_point + '/etc/hostname', 'w+') as f:
        f.write(current_hostname + '\n')
        f.close()

    with open(tmp_mount_point + '/etc/hosts', 'w+') as f:
        f.write('127.0.0.1  localhost\n')
        f.write('127.0.1.1  ' + current_hostname + '\n')
        f.write('\n')

        f.write('# The following lines are desirable for IPv6 capable hosts\n')
        f.write('::1     ip6-localhost ip6-loopback\n')
        f.write('fe00::0 ip6-localnet\n')
        f.write('ff00::0 ip6-mcastprefix\n')
        f.write('ff02::1 ip6-allnodes\n')
        f.write('ff02::2 ip6-allrouters\n')
        f.close()

    print()

print('Done')
