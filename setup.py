import os
import sys
import subprocess

scriptdir = str(os.path.dirname(os.path.realpath(__file__)))

hostname_prefix = "turtlebot" 
current_hostname_id = 1
current_hostname = ""

def new_hostname():
    current_hostname = get_hostname()
    save_hostname(current_hostname)

def get_hostname():
    new_hostname = hostname_prefix + str(current_hostname_id)
    current_hostname_id = current_hostname_id + 1
    return new_hostname

def save_hostname(hostname):
    with open('turtles.txt', 'a+') as f:
        f.write('%s\n',hostname)
    f.close()

if os.getuid() != 0:
    print('Please run this scipt as root/with sudo.')
    sys.exit(2)

base_image_path = str(input('Enter the path to the base image [./base.img]: '))
tmp_mount_point = str(input('Enter the temporary mount point [/tmp/trutlewriter]: ') or '/tmp/turtlewriter')
disk_image_offset = ''

if base_image_path == '':
    base_image_path = './base.img'
    while disk_image_offset == '':
        print('\r')
        disk_image_offset = int(input('Please enter the partition offset (sector count x sector size): ', end=''))

print('Preparing image... ', end='')

subprocess.run(['mkdir', ' -p', tmp_mount_point])
subprocess.run(['mount', '-o', 'loop,offset=' + disk_image_offset, base_image_path, tmp_mount_point])

subprocess.run(['cp', '-rf',
            scriptdir + '/scripts/firstrun.sh',
            tmp_mount_point + '/etc/init.d/'])

subprocess.run(['cp', '-rf',
            scriptdir + '/scripts/firstrun/',
            tmp_mount_point + '/etc/init.d/'])

subprocess.run(['cp', '-rf',
            scriptdir + '/conf/*',
            tmp_mount_point + '/'])

print('Done')

count = int(input('Please enter how many turtles you want to write [1]: ') or 1)
current_hostname_id = int(input('Please enter witch ID should be started with [1]:') or 1)

for x in range(current_hostname_id + 1):

    device_id = str(input('Please new insert SD card and enter device identifier [/dev/mmcblk0]') or '/dev/mmcblk0')

    print('Wrinting hostname... ', end='')
    new_hostname()
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

    print('Done')

    print('Writing to card. Please wait... ', end='')
    subprocess.run(['dd', '', 'if=' + base_image_path, 'of=' + device_id, 'bs=4M', ' >& /dev/null'])
    subprocess.run(['sync'])
    print('Done')