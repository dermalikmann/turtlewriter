
[English version below](#english)

## Vorbereitung

Bevor du mit diesem Script deine Turtlebots beschreiben kannst, muss du 2 Dinge erledigen:

1. Klone das Repo

   ```bash
   mkdir -p ~/Dokumente/sources/turtlewriter && cd $_
   git clone https://github.com/M4lik/turtlewriter .
   ```
   
2. Lade das Base-Image von http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/ herunter.

   > :warning: Wichtig! Lade das Image "Raspberry Pi 3 (Hard-Float) preinstalled server image" herunter!
   
   > :thumbsup: Empfohlen ist es das Image in den gleichen Ordner wie das Script zu legen und in `base.img` umzubenennen.



## Handhabung

> :warning: Bitte das Script mit sudo/root-Rechten ausführen, da es sonst nicht funktioniert!

```
> sudo python3 setup.py
Enter the path to the base image [./base.img]: 
Please enter how many turtles you want to write [1]: 
Please enter wich ID should be started with [1]: 
Please insert SD card and enter device identifier [/dev/mmcblk0]:

Please insert new sd card and press <ENTER>
[...]
```

Beim ausführen des Scripts wird man nach mehreren Sachen gefragt. Dahinter steht der Standardwert in eckigen Klammern.

- `Enter the path to the base image:` Hier den Relativen oder absoluten Pfad zum Baseimage angeben. 
- `Please enter how many turtles you want to write:` Hier die Anzahl der zu schreibenden SD Karten eintragen.
- `Please enter wich ID should be started with:` Hier die ID des ersten Bots eintragen
- `Please insert SD card and enter device identifier:` Hier muss der Gerätepfad angegeben werden.

### Als Beispiel:

Wir wollen Bots 4-8 aufsetzen und haben das Baseimage im Home des Benutzers unter `base-armhf.img`abgespeichert.

```
> sudo python3 setup.py
Enter the path to the base image [./base.img]: ~/base-armhf.img
Please enter how many turtles you want to write [1]: 5
Please enter wich ID should be started with [1]: 4
Please insert SD card and enter device identifier [/dev/mmcblk0]: 

Please insert new sd card and press <ENTER>
Flashing...
    Writing basimage... Done
    Remounting Drive... Done
    Copying overlay... 
    Setting file permissions...
        755 root: /opt
        755 root: /etc
        774 root: /opt/firstrun
        +x root: /opt/firstrun/main.sh
        644 root: /etc/systemd/system/firstrun.service
        755 root: /etc/systemd/system/multi-user.target.wants
    Writing new hostname 'turtlebot4'... 

Please insert new sd card and press <ENTER>
[...]

```

## Was danach?

Nach dem das Script durchgelaufen ist kann man die SD Karte in eine der Bot stecken und ihn einschalten.

Nach dem ersten Boot wird das `firstrun` Script ausgeführt. Dies übernimmt verschiedene Funktionen, wie das Einrichten eines Nutzers `turtle`, das Aktualisieren des Systems, installieren von verschiedenen Tools und ros, und noch einige Sachen mehr.  Dies dauert ca 20 min und kann überwacht werden indem man sich per ssh mit dem `turtle`-Nutzer anmeldet (das Passwort ist standardmäßig auch `turtle`) und `journalctl -fu firstrun` ausführt. Bei Fertigstellung kommt eine Meldung, dass das Script beendet wurde.

Das Script liegt unter [overlay/opt/firstrun/](https://github.com/M4lik/turtlewriter/tree/master/overlay/opt/firstrun/) und ist eine Kollektion von (ba)sh-Skripten. 



# English

## Preperations

1. Clone the repo

   ```bash
   mkdir -p ~/Dokumente/sources/turtlewriter && cd $_
   git clone https://github.com/M4lik/turtlewriter .
   ```

2. Download and unpack the base image from [here](http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/)

   > :warning: Important! Download the "Raspberry Pi 3 (Hard-Float) preinstalled server image", as ros needs hard float!
   
   > :thumbsup: I suggest renaming the unpacked file to `base.img` and moving it in the scripts' folder.


## Usage

> :warning: Please run the script with root/sudo permissions!

```
> sudo python3 setup.py
Enter the path to the base image [./base.img]: 
Please enter how many turtles you want to write [1]: 
Please enter wich ID should be started with [1]: 
Please insert SD card and enter device identifier [/dev/mmcblk0]:

Please insert new sd card and press <ENTER>
[...]
```

While running the script you get asked a few questions. The default value is in brackets.

- `Enter the path to the base image:` The absolute or relative path to the base image. 
- `Please enter how many turtles you want to write:` How many SD cards do you want to write?
- `Please enter wich ID should be started with:` Please enter here the id of the first bot
- `Please insert SD card and enter device identifier:` Please enter here where the block device is located.

### Example:

We want to setup bot 4 to 8, and the base image is in the users home saved as `base-armhf.img`.

```
> sudo python3 setup.py
Enter the path to the base image [./base.img]: ~/base-armhf.img
Please enter how many turtles you want to write [1]: 5
Please enter wich ID should be started with [1]: 4
Please insert SD card and enter device identifier [/dev/mmcblk0]: 

Please insert new sd card and press <ENTER>
Flashing...
    Writing basimage... Done
    Remounting Drive... Done
    Copying overlay... 
    Setting file permissions...
        755 root: /opt
        755 root: /etc
        774 root: /opt/firstrun
        +x root: /opt/firstrun/main.sh
        644 root: /etc/systemd/system/firstrun.service
        755 root: /etc/systemd/system/multi-user.target.wants
    Writing new hostname 'turtlebot4'... 

Please insert new sd card and press <ENTER>
[...]

```


## What's next?

After the script is finished, insert the sd into one of the bots.

On the first boot the `firstrun` script is executed. It does various things like creating a user called `turtle`, upgrading the system and installing various tools and ROS.
This takes aprox. 20 min and can be watched and checked with `journalctl -fu firstrun`, after logging in (user and pass are both `turtle`).

The script is in [overlay/opt/firstrun/](https://github.com/M4lik/turtlewriter/tree/master/overlay/opt/firstrun/) and is a collection of (ba)sh scripts that are run in
ascending order. 