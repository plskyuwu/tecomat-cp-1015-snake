(* Upozornìní *)
(* Soubor je automaticky regenerován a všechny ruèní modifikace budou ztracené. *)
(* ---------------------------------------------------------------------- *)
(* Generováno pro TC700 *)
(* ********************************************************************** *)
VAR_GLOBAL CONSTANT
  CPU_TYPE   : USINT := 75;
  CPU_CODE   : UINT  := 1015;
END_VAR

TYPE
  TAIStat : STRUCT
    UNF     : BOOL;
    UNR     : BOOL;
    OVR     : BOOL;
    OVF     : BOOL;
    FLS     : BOOL;
    CJC     : BOOL;
    dummy6 {HIDDEN} : BOOL;
    dummy7 {HIDDEN} : BOOL;
    CHC     : BOOL;
    dummy9 {HIDDEN} : BOOL;
    dummy10 {HIDDEN} : BOOL;
    dummy11 {HIDDEN} : BOOL;
    dummy12 {HIDDEN} : BOOL;
    dummy13 {HIDDEN} : BOOL;
    dummy14 {HIDDEN} : BOOL;
    dummy15 {HIDDEN} : BOOL;
  END_STRUCT;

  TAI : STRUCT
    STAT  : TAIStat;
    FS    : INT;
    ENG   : REAL;
    PCT   : REAL;
  END_STRUCT;

  TAO_TC6 : STRUCT
    FS  : INT ;
    ENG  : REAL;
    PCT  : REAL;
  END_STRUCT;

  TBIN_6DI : STRUCT
    DI0  : BOOL;
    DI1  : BOOL;
    DI2  : BOOL;
    DI3  : BOOL;
    DI4  : BOOL;
    DI5  : BOOL;
  END_STRUCT;

  TBIN_6DO : STRUCT
    DO0  : BOOL;
    DO1  : BOOL;
    DO2  : BOOL;
    DO3  : BOOL;
    DO4  : BOOL;
    DO5  : BOOL;
  END_STRUCT;

  TCHStatistic : STRUCT
    STAT       : USINT;
    ERR        : USINT;
    trueMes    : UDINT;
    falseMes   : UDINT;
  END_STRUCT;

  TCHControl : STRUCT
    CONTROL  : UINT;
  END_STRUCT;

END_TYPE
(* ********************************************************************** *)
(* ---------------------------------------------------------------------- *)
(* CP-1015 *)
VAR_GLOBAL
  r0_p0_Statistic_CH1  AT %X7500 : TCHStatistic;
  r0_p0_Control_CH1    AT %Y7500 : TCHControl;
END_VAR
(* ---------------------------------------------------------------------- *)
(* OI-1073 *)
VAR_GLOBAL
  OI1073_Keyb          : USINT;
  OI1073_VideoRam      : ARRAY [0..79] OF USINT;
(* alias *)
  panel                AT OI1073_Keyb;
END_VAR
(* ---------------------------------------------------------------------- *)
(* MI2-01M *)
VAR_GLOBAL
  r0_p2_Statistic_MI_CIB1 AT %X0   : TCHStatistic;
  r0_p2_Control_MI_CIB1 AT %Y0   : TCHControl;
END_VAR
(* ---------------------------------------------------------------------- *)
(* IR-1064 *)
VAR_GLOBAL
  r0_p3_DI             AT %X30  : TBIN_6DI;
  r0_p3_dummy0         AT %X31  : USINT;
  r0_p3_AI0            AT %X32  : TAI;
  r0_p3_AI1            AT %X44  : TAI;
  r0_p3_AI2            AT %X56  : TAI;
  r0_p3_AI3            AT %X68  : TAI;
  r0_p3_AI4            AT %X80  : TAI;
  r0_p3_AI5            AT %X92  : TAI;
  r0_p3_DO             AT %Y6   : TBIN_6DO;
  r0_p3_dummy1         AT %Y7   : USINT;
  r0_p3_AO0            AT %Y8   : TAO_TC6;
  r0_p3_AO1            AT %Y18  : TAO_TC6;
END_VAR
(* -- *)
(* -- *)
VAR_EXTERNAL
END_VAR
(* -- *)

(* ********************************************************************** *)
(* Generováno programem MOSAIC *)
(* © 2001-2019 Teco a.s. *)
(* Verze : 1.2 *)
(* DLL Verze : 23.1.3.16 *)
