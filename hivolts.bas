# hivolts.bas - a game in ZX Spectrum BASIC
#
# By Jaldhar H. Vyas <jaldhar@braincells.com>
#
# Copyright (C) 2017, Consolidated Braincells Inc.
# "Do what thou wilt" shall be the whole of the license.
#
10 RANDOMIZE
20 DIM B(12,12)
30 DIM P(13,2)
40 LET X = 0 : LET Y = 0
50 LET T = 1 : LET V = 0

# intro screen
100 CLS
110 PRINT AT 0, 13;"HIVOLTS"
120 PRINT AT 1, 4;"SHOW INSTRUCTIONS? (Y/N)"
130 LET A$ = INKEY$
140 IF A$ = "" THEN GOTO 130
150 IF A$ = "Y" OR A$ = "y" THEN GOTO 9700
160 IF A$ = "N" OR A$ = "n" THEN GOTO 200
170 GOTO 130

# main
200 GOSUB 5000
210 GOSUB 5500
220 IF V <> 0 THEN GOTO 9500
230 IF T = 1 THEN GOSUB 5700
240 IF T = 0 THEN GOSUB 8000
250 GOSUB 8900
260 GOSUB 5580
270 GOSUB 9000
280 GOTO 220
300 STOP

# setup
5000 CLS
5010 PRINT FLASH 1; AT 0,9;"SETTING UP...."
5020 FOR I = 1 TO 12
5030 FOR J = 1 TO 12
5040 IF I = 1 OR I = 12 THEN LET B(I,J) = 1 : GOTO 5090
5060 IF J = 1 OR J = 12 THEN LET B(I,J) = 1 : GOTO 5090
5080 LET B(I,J) = 0
5090 NEXT J
5100 NEXT I
5110 FOR I = 1 TO 20
5120 GOSUB 5300
5130 LET B(Y,X) = 1
5140 NEXT I
5150 FOR I = 1 TO 12
5160 GOSUB 5300
5170 LET P(I,1) = Y
5180 LET P(I,2) = X
5190 LET B(Y,X) = 2
5200 NEXT I
5210 GOSUB 5300
5220 LET P(13,1) = Y
5230 LET P(13,2) = X
5240 LET B(Y,X) = 2
5250 LET V = 0
5260 FOR I = 1 TO 13
5270 LET B(P(I,1), P(I,2)) = 0
5280 NEXT I
5290  RETURN

# place in empty space
5300 LET X = INT(RND*12)+1
5310 LET Y = INT(RND*12)+1
5410 IF B(Y,X) <> 0 THEN GOTO 5300
5420 RETURN

# display
5500 CLS
5510 FOR I = 1 TO 12
5520 FOR J = 1 TO 12
5530 IF B(I,J) = 0 THEN PRINT AT I + 5,J + 10;" "
5540 IF B(I,J) = 1 THEN PRINT INK 0; AT I + 5,J + 9;"\::"
5550 NEXT J
5560 NEXT I
5580 FOR I = 1 TO 12
5590 IF P(I,1) <> 0 AND P(I,2) <> 0 THEN PRINT BRIGHT 1; INK 4; AT P(I,1) + 5,P(I,2) + 9;"X"
5600 NEXT I
5610 IF P(13,1) <> 0 AND P(13,2) <> 0 THEN PRINT INK 2; AT P(13,1) + 5,P(13,2) + 9;"@"
5620 RETURN

# check for input and dispatch commands
5700 LET A$ = INKEY$
5710 if A$ = "" THEN GOTO 5700
5720 IF A$ = "Q" OR A$ = "q" THEN GOTO 6000
5730 IF A$ = "W" OR A$ = "w" THEN GOTO 6100
5740 IF A$ = "E" OR A$ = "e" THEN GOTO 6200
5750 IF A$ = "A" OR A$ = "a" THEN GOTO 6300
5760 IF A$ = "D" OR A$ = "d" THEN GOTO 6400
5770 IF A$ = "Z" OR A$ = "z" THEN GOTO 6500
5780 IF A$ = "X" OR A$ = "x" THEN GOTO 6600
5790 IF A$ = "C" OR A$ = "c" THEN GOTO 6700
5800 IF A$ = "S" OR A$ = "s" THEN GOTO 6800
5810 IF A$ = "J" OR A$ = "j" THEN GOTO 6900
5820 IF A$ = "0" THEN GOTO 9600
5830 GOTO 5700
5840 RETURN

# move nw command
6000 GOSUB 6980
6010 LET P(13,1) = P(13,1) - 1
6020 LET P(13,2) = P(13,2) - 1
6030 LET T = 0
6040 GOTO 5840

# move n command
6100 GOSUB 6980
6110 LET P(13,1) = P(13, 1) - 1
6120 LET T = 0
6130 GOTO 5840

# move ne command
6200 GOSUB 6980
6210 LET P(13,1) = P(13,1) - 1
6220 LET P(13,2) = P(13,2) + 1
6230 LET T = 0
6240 GOTO 5840

# move w command
6300 GOSUB 6980
6310 LET P(13,2) = P(13,2) - 1
6320 LET T = 0
6330 GOTO 5840

# move e command
6400 GOSUB 6980
6410 LET P(13,2) = P(13,2) + 1
6420 LET T = 0
6430 GOTO 5840

# move sw command
6500 GOSUB 6980
6510 LET P(13,1) = P(13,1) + 1
6520 LET P(13,2) = P(13,2) - 1
6530 LET T = 0
6540 GOTO 5840

# move s command
6600 GOSUB 6980
6610 LET P(13,1) = P(13,1) + 1
6620 LET T = 0
6630 GOTO 5840

# move se command
6700 GOSUB 6980
6710 LET P(13,1) = P(13,1) + 1
6720 LET P(13,2) = P(13,2) + 1
6730 LET T = 0
6740 GOTO 5840

# sleep command
6800 LET T = 0
6810 GOTO 5840

# jump command
6900 GOSUB 6980
6910 GOSUB 5300
6920 LET P(13,1) = Y
6930 LET P(13,2) = X
6940 LET T = 1
6950 GOTO 5840

# erase old position of player
6980 PRINT AT P(13,1) + 5, P(13,2) + 9;" "
6990 RETURN

# move mhos
8000 FOR I = 1 TO 12
8010 IF P(I,1) = 0 AND P(I,2) = 0 THEN GOTO 8060
8020 PRINT AT P(I,1) + 5, P(I,2) + 9;" "
8030 IF P(I,1) < P(13,1) THEN GOTO 8090
8040 IF P(I,1) > P(13,1) THEN GOTO 8130
8050 IF P(I,1) = P(13,1) THEN GOTO 8170
8060 NEXT I
8070 LET T = 1
8080 RETURN

8090 LET M1 = 0 : LET M2 = 0
8100 IF P(I,2) < P(13,2) THEN LET M1 = 1 : LET M2 = 1 : GOTO 8200
8110 IF P(I,2) > P(13,2) THEN LET M1 = 1 : LET M2 = -1 : GOTO 8200
8120 LET P(I,1) = P(I,1) - 1 : GOTO 8060

8130 LET M1 = 0 : LET M2 = 0
8140 IF P(I,2) < P(13,2) THEN LET M1 = -1 : LET M2 = 1 : GOTO 8200
8150 IF P(I,2) > P(13,2) THEN LET M1 = -1 : LET M2 = -1 : GOTO 8200
8160 LET P(I,1) = P(I,1) - 1 : GOTO 8060

8170 IF P(I,2) < P(13,2) THEN LET P(I,2) = P(I,2) + 1 : GOTO 8060
8180 IF P(I,2) > P(13,2) THEN LET P(I,2) = P(I,2) - 1 : GOTO 8060
8190 GOTO 8060

# special handling for mhos moving diagonally
8200 DIM D(3,2)
8210 LET D(1,1) = P(I,1) + M1 : LET D(1,2) = P(I,2) + M2
8220 LET D(2,1) = P(I,1) : LET D(2,2) = P(I,2) + M2
8230 LET D(3,1) = P(I,1) + M1 : LET D(3,2) = P(I,2)
8240 FOR J = 1 TO 3
8250 FOR K = 1 TO 12
8260 IF I = K OR (P(K,1) = 0 AND P(K,2) = 0) THEN GOTO 8280
8270 IF D(J,1) = P(K,1) AND D(J,2) = P(K,2) THEN GOTO 8300
8280 NEXT K
8290 IF B(D(J,1),D(J,2)) = 1 THEN GOTO 8310
8300 LET P(I,1) = D(J,1) : LET P(I,2) = D(J,2) : GOTO 8060
8310 NEXT J
8320 FOR J = 1 TO 3
8330 IF B(D(J,1),D(J,2)) = 1 : LET P(I,1) = D(J,1) : LET P(I,2) = D(J,2) : GOTO 8060
8340 NEXT J
8350 GOTO 8060

# check collisions
8900 FOR I = 1 TO 12
8910 IF P(I,1) = 0  AND P(I,2) = 0 THEN GOTO 8980
8920 IF B(P(I,1),P(I,2)) = 1 THEN LET P(I,1) = 0 : LET P(I,2) = 0 : GOTO 8980
8930 FOR J = I TO 13
8940 IF I = J THEN GOTO 8970
8950 IF P(J,1) = 0  AND P(J,2) = 0 THEN GOTO 8970
8960 IF P(I,1) = P(J,1) AND P(I,2) = P(J,2) THEN LET P(I,1) = 0 : LET P(I,2) = 0 : LET P(J,1) = 0 : LET P(J,2) = 0
8970 NEXT J
8980 NEXT I
8990 RETURN

# check victory conditions
9000 LET C = 0
9010 FOR I = 1 TO 12
9020 IF P(I,1) = 0  AND P(I,2) = 0 THEN LET C = C + 1
9030 NEXT I
9040 IF P(13,1) = 0  AND P(13,2) = 0 THEN LET V = 1
9050 IF C = 12 AND V = 1 THEN LET V = 2
9060 IF C = 12 AND V = 0 THEN LET V = 3
9070 RETURN

# display game over status
9500 IF V = 1 THEN PRINT AT 20,9;FLASH 1;"YOU HAVE LOST!"
9510 IF V = 2 THEN PRINT AT 20,10;FLASH 1;"IT'S A DRAW!"
9520 IF V = 3 THEN PRINT AT 20,9;FLASH 1;"YOU HAVE WON!!"

# ask to play again
9600 PRINT AT 21, 0;"DO YOU WANT TO PLAY AGAIN? (Y/N)"
9610 LET A$ = INKEY$
9620 IF A$ = "" THEN GOTO 9610
9630 IF A$ = "Y" OR A$ = "y" THEN GOTO 200
9640 IF A$ = "N" OR A$ = "n" THEN GOTO 300
9650 GOTO 9600

# instructions
9700 CLS
9710 PRINT AT 0,10; "INSTRUCTIONS"
9720 PRINT AT 2,0; "YOU (";INK 2;"@";INK 0;") ARE BEING CHASED BY THE "
9730 PRINT AT 3,0; "EVIL MHOS (";BRIGHT 1; INK 4;"X";BRIGHT 0; INK 0;") IF THEY LAND ON"
9740 PRINT AT 4,0; "YOU, YOU WILL DIE. IF YOU TOUCH"
9750 PRINT AT 5,0; "AN ELECTRIC FENCE (\::) YOU WILL"
9760 PRINT AT 6,0; "DIE. BUT IF YOU KILL ALL THE"
9770 PRINT AT 7,0; "MHOS BY MAKING THEM TOUCH FENCES"
9780 PRINT AT 8,0; "OR EACH OTHER, YOU WIN THE GAME."
9790 PRINT AT 10,0; "Q = MOVE UP AND LEFT"
9800 PRINT AT 11,0; "W = MOVE UP"
9810 PRINT AT 12,0; "E = MOVE UP AND RIGHT"
9820 PRINT AT 13,0; "A = MOVE LEFT"
9830 PRINT AT 14,0; "D = MOVE RIGHT"
9840 PRINT AT 15,0; "Z = MOVE DOWN AND LEFT"
9850 PRINT AT 16,0; "X = MOVE DOWN"
9860 PRINT AT 17,0; "C = MOVE DOWN AND RIGHT"
9870 PRINT AT 18,0; "S = STAND STILL"
9880 PRINT AT 19,0; "J = JUMP TO A RANDOM PLACE"
9890 PRINT AT 20,0; "0 = EXIT THE GAME"
9900 PRINT AT 21,3; FLASH 1; "PRESS ANY KEY TO CONTINUE"
9910 LET A$ = INKEY$
9920 IF A$ = "" THEN GOTO 9910
9930 GOTO 200
