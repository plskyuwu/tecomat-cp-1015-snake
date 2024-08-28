; Varování: Tento soubor je spravován vývojovým prostøedím Mosaic.
; Nedoporuèuje se upravovat ho ruènì!

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
#useoption RemZone = 0          ; délka remanentní zóny
#useoption AlarmTime = 150      ; první výstraha [ms]
#useoption MaxCycleTime = 750   ; maximální cyklus [ms]
#useoption PLCstart = 1         ; studený start
#useoption AutoSummerTime = 0   ; vnitøní hodiny PLC se neposouvají pøi pøechodu na letní èas
#useoption RestartOnError = 0   ; PLC nebude po tvrdé chybì restartováno

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
