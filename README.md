# Pong
Studentisches Projekt für Assemblerprogrammierung

<a href="https://user-images.githubusercontent.com/82649637/172361290-d6f3ec6e-d027-4470-9602-84825d4a6170.jpg"><img src="https://user-images.githubusercontent.com/82649637/172361290-d6f3ec6e-d027-4470-9602-84825d4a6170.jpg" height=45% width=45% ></a> 
<a href="https://user-images.githubusercontent.com/82649637/172361298-a4dcd42c-9f68-4ca2-9205-daa6405cc950.jpg"><img src="https://user-images.githubusercontent.com/82649637/172361298-a4dcd42c-9f68-4ca2-9205-daa6405cc950.jpg" height=45% width=45% ></a> 
  
## Kurzanleitung

Menü:

* Linksklick auf farbiges Feld „Starten“ um Spiel zu starten
* Linksklick auf farbiges Feld „Beenden“ Rücksprung DOS

Im Spiel:
* „W“ linkes Paddel nach oben bewegen
* „S“ linkes Paddel nach unten bewegen
* „O“ rechtes Paddel nach oben bewegen
* „L“ rechtes Paddel nach unten bewegen
* „ESC“ Rücksprung ins DOS

Am Spielende:
* „ENTER“ Rücksprung ins Menü
* „ESC“ Rücksprung ins DOS

Ziel des Spiels:
* Der Spieler, der als erstes 9 Punkte erreicht gewinnt das Spiel

## Entwurfsanleitung

* 2 ASM Dateien „pong.ASM“ und „PongProc.ASM“
* „pong.ASM“ Haupdatei mit include PongProc.ASM
* In „pongProc“ alle Unterprogramme
* In „pong“ Programmiermodell, Befehlssatz, Konstanten, Variablen und Hauptprogramm

## PongProc

* print_Menu &#8594; zeichnet das Menü mit Überschrift und Feldern + Beschriftung
* check_Position_Start &#8594; Wenn auf das Feld Starten geklickt wird, startet das Spiel
* check_Position_End &#8594; Wenn auf das Feld Beenden geklickt wird, beendet das Spiel und Rücksprung ins DOS
* print_Scores &#8594; zeigt Ergebnis auf dem Spielfeld an
* draw_Ball &#8594; zeichnet den Ball
* delete_Ball &#8594; löscht den Ball, indem er schwarz überzeichnet, wird
* move_Ball &#8594; bewegt Ball, checkt Kollision mit dem Paddel und erhöht den Score, und checkt ob es ein Gewinner gibt
* draw_paddle1 &#8594; zeichnet das Paddle auf der linken Seite
* draw_Paddle2 &#8594; zeichnet das Paddle auf der rechten Seite
* delete_paddle1 &#8594; löscht das Paddle auf der linken Seite
* delete_Paddle2 &#8594; löscht das Paddle auf der rechten Seite
* move_paddle &#8594; checkt die Tasteneingabe und lässt die Paddels bewegen
* random + delay &#8594; generiert eine Zufallszahl aus der Systemzeit
