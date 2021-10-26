# Manuelle Konfiguration

#### Java
Installation von java 8 zur Ausführung der kompilierten armv6hf Programme
> sudo apt update
> 
> sudo apt install openjdk-8-jdk

#### Touchdisplay
Zunächst müssen die Bildschirme angeordnet (Screen Configuration) und gedreht werden (config.txt).
Um das Touchdisplay auch beim Anschluss von zwei Bildschirmen noch verwenden zu können muss die Touch Matrix neu berechnet und beim Start übergeben werden.
Den richtigen Input für diese Anweisung findet man mit 
> xinput list

die ID des Touchgerätes. 
Mit
> xinput set-prop "6" --type=float "Coordinate Transformation Matrix" 0.469 0 0 0 0.587 0.413 0 0 1

wird der Touch kalibriert.

![WhatsApp Image 2021-10-20 at 13 42 59](https://user-images.githubusercontent.com/72434534/138086421-b9e9ef14-6b9f-4670-9dfc-5b7d556ad15c.jpeg)

*Berechnung der Touch Matrix*

Dies muss nun zum Start ausgeführt werden. Dazu command unter:
> /home/pi/.profile

Anpassen von
>Section "InputClass" 
>
>        Identifier "libinput touchpad catchall" 
>        
>        MatchIsTouchscreen "on"                                  ##Anpassen!
>        
>        Option "CalibrationMatrix" "0 1 0 -1 0 1 0 0 1"          ##Anpassen!
>        
>        MatchDevicePath "/dev/input/event*" 
>        
>        Driver "libinput" 
>        
>EndSection

in 
>/usr/share/X11/xorg.conf.d/40-libinput.conf





#### Autostart
Automatischer Programmstart von DartMenu.
> /etc/xdg/lxsession/LXDE-pi

Terminal Fenster öffnen:
> @lxterminal -e "/home/pi/Documents/Dartautomat/DartMenu/application.linux-armv6hf/DartMenu"





#### Image erstellen
https://techgeeks.de/raspberry-pi-image-installieren-backup-und-verkleinern/#backup

