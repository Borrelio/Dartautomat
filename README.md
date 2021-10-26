# Dartautomat

## 1. Einleitung
Es handelt sich um ein Dartspiel bestehend aus einem Punkteeingabeprogramm (7" Touchscreen) und einer Spielanzeige. Als IDE wird Processing v3 verwendet, die mit der gleichnamigen JAVA basierenden Programmiersprache Processing programmiert wird. Die kompilierten Progamme der IDE sind sowohl auf dem Raspberry pi sowie unter Linux, Windows und MacOS lauffähig. Die Programmiersprache und IDE Processing bietet einen einfachen Einstieg in die Programmierung und orientiert sich an der Arduino IDE. 

Grundgendanke ist der Aufbau einens modularen Steeldartautomaten der auf einem Raspberry Pi zusätzliche Hardware (Licht, Ton, etc.) ansteuern kann.

https://user-images.githubusercontent.com/72434534/137984088-869d0d65-5fb1-4a65-8422-d01abbb6741d.mp4


## 2. Grundlegendes Konzept
#### 2.1. Programmaufruf
Grundsätzlich gibt es ein Hauptprogramm **(DartMenu)**, welches auf einem 7" Touchdisplay (Bildschirm 1) während der Laufzeit aktiv ist. Dieses Hauptprogramm ruft die weiteren Programme am Hauptdisplay (Bildschirm 2) auf. Die Interaktion findet ausschließlich mit dem DartMenu statt. Durch den modularen Aufbau können Erweiterungen einfacher integriert werden, wobei die Übersichtlichkeit gewährleistet bleibt.

<img width="1485" alt="UebersichtProgrammaufruf" src="https://user-images.githubusercontent.com/72434534/137994558-f4ccb692-de0f-4a3e-a15b-08cacbe94b6d.png">

Aktuell ist das Programm DartMenu, welches auf den [Touchdisplay](https://joy-it.net/de/products/RB-LCD-7-2) läuft, nur auf dieses abgestimmt. Die Positionen der gezeichneten Element sind Absolut angegeben. Bei der Verwendung anderer Displays wird deshalb eine Überarbeitung notwendig!

#### 2.2. Datenaustausch
Die Kommunikation zwischen den einzelnen Programmen geschieht über Textdateien mit der Dateiendung **.INOUT**. 
Diese befinden sich alle im Unterordner **DartsINOUT**.

#### 2.3. Einstellungen
Die Datei **Einstellungen.OUT** im Verzeichnis **DartsINOUT** ermöglicht die Einstellung des Betriebssystem (benötigt für den Programmaufruf), sowie die Auswahl der Bildschirmausgaben.


## 3. Arbeitsweise
#### 3.1. Processing IDE
- Installation [Processing IDE](https://github.com/processing/processing) (v3.5.4).
- Programm öffnen: ../DartMenu/DartMenu.pde
- gegebenenfalls Nachinstallation von Bibliotheken (Tools->Tool hinzufügen->Libraries->...)
- kompilieren von Anwendungen (Datei->Exportieren)

#### 3.2. Konfiguration
Bevor das Programm ausgeführt wird, sollte die Datei **Einstellung.OUT** richtig eingestellt werden. Daher Displayausgabe vergeben, das Betriebssystem wählen und die Ansteuerungsart der Hardware wählen.

#### 3.3. Raspberry Pi 4
Das fertige Debian Image ( ../Dartautomat/RaspbianImage/...img ) ist für die Benutzung des [Touchdisplays](https://joy-it.net/de/products/RB-LCD-7-2) ausgelegt.
Für eine gute Arbeitsweise ist es am effektivsten an einem Programmiersystem (Windows/Linux) den Programmcode zu erabeiten und über SSH (z.b. filezilla) die kompilierten Programme per FTP zu übertragen. Anschließend genügt ein Neustart des Pi's.

## 4. Optionale Hardware
#### 4.1 Licht
Mit der RaspberryPi Hardware ist es möglich die I/O Ports für RGB-Stripes anzusteuern. Dabei Wird der äußere RGB-Stripe kontinuierlich angesteurt, sodass für jeden Spieler eine Farbe im RGB-Farbraum vergeben werden kann. Dies geschieht über Digital-Analog-Wandler je Farbkanal, welche über SPI vom Raspberry angesteuert werden. Der Innenring besitzt drei unabhängige Stripes die über Mosfets jeweils R, G und B schalten.

<img width="1059" alt="Hardware" src="https://user-images.githubusercontent.com/72434534/137995871-2a330193-d743-4766-a2b1-f17a4cc8d887.png">

Bauteile:
- Mosfet **IRLZ34N**
- DAC **MCP 4802**

#### 4.2 Sound
In Bearbeitung.
- **DFPlayer**

## 5. Ausblick für mögliche Erweiterungen
- Pfeilerkennung durch Kameras
<img width="1059" alt="Pfeilerkennung" src="https://user-images.githubusercontent.com/72434534/137999371-2e2f22c4-73f2-46f8-aa52-15207ca1509a.png">

- Erweiterung weiterer Spiele
- Einbindung von **lidarts.org** zum online spielen 
- Organisation von Tunieren
- ...
