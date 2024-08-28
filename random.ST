FUNCTION_BLOCK fbrandom
  // Fukcni blok ktery vyvari nahodne cislo od 0 do 99
  // Maximalni hodnota se da nastavit promennou maxValue
  // Autor: Matej Gottstein
  // Specialni podekovani Ondreji Veselemu za zdokonaleni algoritmu pro vypocet nahodneho cisla

  VAR_INPUT
  maxValue: REAL := 99;
  END_VAR

  VAR
  timeNow: TIME;
  
  value: REAL;
  valueString: STRING;
  END_VAR

  VAR_OUTPUT
  output: USINT;
  END_VAR

  // zapise aktualni cas
  timeNow := GetTime();

  // prevede promennou timeNow na text a text orizne pouze na podledni 2 cisla
  valueString := RIGHT(TIME_TO_STRING(timeNow), 2);

  // prevede oriznuty text na desetinne cislo
  value := STRING_TO_REAL(valueString);
  
  // cislo se vynasobi maximalni hodnoutou deleno 99 (protoze posledni 2 cisla casu v milisekundach je maximalne 99)
  // vypoctene cislo se nasledne zaorkouhli, to zaruci nedesetinny vysledek
  value := round(value * (maxValue / 99));
  
  // vysledne desetinne cislo se prevede na USINT (zabira mene mista v pameti) a posle se na vystup bloku
  output := REAL_TO_USINT(value);
  
END_FUNCTION_BLOCK

