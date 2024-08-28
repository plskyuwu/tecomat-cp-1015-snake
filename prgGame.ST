VAR_GLOBAL
// Promenne definovane jako globalni aby je bylo mozne zobrazit na panelu
score: USINT := 0;
speed: USINT := 1;

// Kazdy radek na panelu musi mit svoji promennou protoze se na panelu nedaji
// cist elementy 2d pole
screen0: ARRAY[0..15] OF USINT := [16(0)];
screen1: ARRAY[0..15] OF USINT := [16(0)];
screen2: ARRAY[0..15] OF USINT := [16(0)];
screen3: ARRAY[0..15] OF USINT := [16(0)];
END_VAR

PROGRAM prgGame
  // Znama hra had naprogramovana na PLC CP-1015 s displayem OI-1073
  // Autor: Matej Gottstein

  VAR
  snake: ARRAY[0..63, 0..2] OF USINT; // 0-63 jsou clanky hada, 0-2 jsou: souradnice x, souradnice y, stav clanku (0 = neni, 3 = telo, 1 = hlava)
  snakePrevious: ARRAY[0..63, 0..2] OF USINT;
  snakeDirection: USINT := 0; // 0 = Do prava, 1 = Dolu, 2 = Do leva, 3 = Nahoru
  snakeDirectionPrevious: USINT := 0;
  
  applePosX: USINT;
  applePosY: USINT;
  appleExists: BOOL := 0;
  applePosGeneratorX: fbrandom;
  applePosGeneratorY: fbrandom;
  
  screen: ARRAY[0..3, 0..15] OF USINT; // Screen je pomocna promenna pro zjednoduseni prace s obrazovkou
  
  sleep: TON;
  sleepTime: TIME;
  sleepProgress: TIME;
  sleepStart: BOOL;
  
  run: BOOL := true;
  
  init: BOOL := true;
  END_VAR
  
  VAR_TEMP
  // Docasne promenne
  i: USINT;
  j: USINT;
  END_VAR

  // Provede se pouze jednou pri spusteni
  IF init THEN
    snake[0, 2] := 1; // Hlava hada
    snake[0, 0] := 0; // Pozice hada x
    snake[0, 1] := 0; // Pozice hada y
  
    init := false;
  END_IF;

  // Ètení tlaèítek panelu a zmìna smìru hada
  IF OI1073_Keyb <> 0 THEN
    CASE OI1073_Keyb OF
      24: IF not snakeDirectionPrevious = 1 THEN snakeDirection := 3; END_IF; // Nahoru
      25: IF not snakeDirectionPrevious = 3 THEN snakeDirection := 1; END_IF; // Dolu
      26: IF not snakeDirectionPrevious = 2 THEN snakeDirection := 0; END_IF;; // Do prava
      27: IF not snakeDirectionPrevious = 0 THEN snakeDirection := 2; END_IF;; // Do leva
    END_CASE;
  END_IF;

  // Rychlost opakovani herni logiky je omezeno promennou run, vice na radku 187
  IF run THEN // Herní logika //////////////////////////////////////////////////////////////////////

  // Zapamatovani predchoziho smeru hada
  snakeDirectionPrevious := snakeDirection;

  // Zapamatovani predchozich pozice hada
  FOR i := 0 TO 63 DO
    FOR j := 0 TO 2 DO
      snakePrevious[i, j] := snake[i, j];
    END_FOR;
  END_FOR;

  // Pokud jablko není na poli, náhodnì se umístí
  IF not appleExists THEN
    applePosGeneratorX(maxValue := 15, output => applePosX);
    applePosGeneratorY(maxValue := 3, output => applePosY);
    appleExists := true;
    
    FOR i := 0 TO 63 DO
      IF (applePosX = snake[i, 0]) and (applePosY = snake[i, 1]) THEN
        appleExists := false;
      END_IF;
    END_FOR;
  END_IF;

  // Pokud je hlava hada na stejném poli jako jablko, jablko zmizí a zvýší se skóre o 1
  IF ((snake[0, 0] = applePosX) and (snake[0, 1] = applePosY)) and appleExists THEN
    appleExists := false;
    score := score + 1;
  END_IF;
  
  // Pohyb hada
  CASE snakeDirection OF
    0: snake[0, 0] := snake[0, 0] + 1;
    1: snake[0, 1] := snake[0, 1] + 1;
    2: snake[0, 0] := snake[0, 0] - 1;
    3: snake[0, 1] := snake[0, 1] - 1;
  END_CASE;
  
  // Zvìtšování hada podle skóre a nasledovani hlavy hada
  FOR i := 1 TO score DO
    snake[i, 2] := 3;
    snake[i + 1, 0] := snakePrevious[i, 0];
    snake[i + 1, 1] := snakePrevious[i, 1];
  END_FOR;

  // Kolize hada sama se sebou
  FOR i := 1 TO 63 DO
    IF ((snake[0, 0] = snake[i, 0]) and (snake[0, 1] = snake[i, 1])) and snake[i, 2] = 3 THEN
      score := 0;
      FOR i := 0 TO 63 DO
        snake[i, 0] := 0;
        snake[i, 1] := 0;
        snake[i, 2] := 0;
      END_FOR;
      snake[0, 2] := 1;
      appleExists := 0;
      snakeDirection := 0;
      snakeDirectionPrevious := 0;
    END_IF;
  END_FOR;

  // Pokud had vyjede z hracího pole, resetovat hru
  IF (snake[0, 0] > 15) or (snake[0, 1] > 3) THEN
    score := 0;
    FOR i := 0 TO 63 DO
      snake[i, 0] := 0;
      snake[i, 1] := 0;
      snake[i, 2] := 0;
    END_FOR;
    snake[0, 2] := 1;
    appleExists := 0;
    snakeDirection := 0;
    snakeDirectionPrevious := 0;
  END_IF;

  // Rendering obrazovky /////////////
  FOR i := 0 TO 3 DO
    FOR j := 0 TO 15 DO
      screen[i, j] := 0;
    END_FOR;
  END_FOR;

  // Rendering jablka
  IF appleExists THEN
    screen[applePosY, applePosX] := 2;
  END_IF;

  // Rozbalit snake a zapsat informace o clancich do screen
  FOR i := 0 TO 63 DO
    FOR j := 0 TO 2 DO
      IF snake[i, 2] <> 0 THEN
        screen[snake[i, 1], snake[i, 0]] := snake[i, 2];
      END_IF;
    END_FOR;
  END_FOR;

  // Zapsání dat z promenne screen do jednotlivých rádku
  FOR i := 0 TO 3 DO
    FOR j := 0 TO 15 DO
      IF i = 0 THEN screen0[j] := screen[i,j];
      ELSIF i = 1 THEN screen1[j] := screen[i,j];
      ELSIF i = 2 THEN screen2[j] := screen[i,j];
      ELSE screen3[j] := screen[i,j];
      END_IF;
    END_FOR;
  END_FOR;
  
  END_IF; // Konec herní logiky ////////////////////////////////////////////////////////////////////
  
  // Zmena rychlosti hry podle skore
  CASE score OF
    0: speed := 1;
    15: speed := 2;
  END_CASE;
  
  // Kvuli tomu ze plc provadi program dokola a dokola tak je potreba omezit rychlost herni logiky
  // To je provedeno pomoci promenne run a funkcniho bloku TON
  IF run THEN
    sleepStart := false;
  ELSE
    sleepStart := true;
  END_IF;
  
  sleepTime := REAL_TO_TIME(1/USINT_TO_REAL(speed*2)*1000);
  sleep(IN := sleepStart, PT := sleepTime, ET => sleepProgress, Q => run);
END_PROGRAM
