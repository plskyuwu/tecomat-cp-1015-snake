; Varov�n�: Tento soubor je spravov�n v�vojov�m prost�ed�m Mosaic.
; Nedoporu�uje se upravovat ho ru�n�!

#program proHad , V1.0
;**************************************
;<ActionName/>
;<Programmer/>
;<FirmName/>
;<Copyright/>
;**************************************
;<History>
;</History>
;**************************************
#useoption CPM = 9              ; Typ CPM: K
#useoption RemZone = 0          ; d�lka remanentn� z�ny
#useoption AlarmTime = 150      ; prvn� v�straha [ms]
#useoption MaxCycleTime = 750   ; maxim�ln� cyklus [ms]
#useoption PLCstart = 1         ; studen� start
#useoption AutoSummerTime = 0   ; vnit�n� hodiny PLC se neposouvaj� p�i p�echodu na letn� �as
#useoption RestartOnError = 0   ; PLC nebude po tvrd� chyb� restartov�no

#uselib "LocalLib\StdLib_V22_20180619.mlb"
#uselib "LocalLib\SysLib_V50_20230202.mlb"
#endlibs

;**************************************
#usefile "PanelMaker\DeklarPT.mos", 'auto'
#usefile "Sysgen\CIBMaker.st", 'auto'
#usefile "SysGen\HWConfig.ST", 'auto'
#usefile "Sysgen\CIBMaker.mos", 'auto'
#usefile "SysGen\proHad.hwc", 'auto'
#usefile "..\MC4Gottstein.hwn", 'auto'
#usefile "PROHAD.ST"
#usefile "random.ST"
#usefile "prgGame.ST"
#usefile "PanelMaker\OI1073.mos", 'auto'
#usefile "proHad.mcf", 'auto'
