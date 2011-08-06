////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Sfr_shift_H
#define H_Sfr_shift_H

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


#include "ieee/std_logic_1164/std_logic_1164.h"

class Sfr_shift: public HSim__s6 {
public:
  HSimRecordType Shift;
/* subprogram name SLAF */
char *Gs(HSimConstraints *reConstr,  HSim__s1 *Sn, int ssindexSn, int offsetSn);
/* subprogram name SRLF */
char *GF(HSimConstraints *reConstr,  HSim__s1 *Sz, int ssindexSz, int offsetSz,  HSim__s1 *SC, int ssindexSC, int offsetSC);
/* subprogram name SLLP */
void GX(HSim__s7 *process,  HSim__s1 *SM, int ssindexSM, int offsetSM,  HSim__s1 *SP, int ssindexSP, int offsetSP,  HSim__s1 *SV, int ssindexSV, int offsetSV, HSim__s2 * driver_SV);
/* subprogram name SRAP */
void G1c(HSim__s7 *process,  HSim__s1 *S14, int ssindexS14, int offsetS14,  HSim__s1 *S1a, int ssindexS1a, int offsetS1a, HSim__s2 * driver_S1a);

public:

public:
  Sfr_shift(const HSimString &name);
  ~Sfr_shift();
};

extern Sfr_shift *SfrShift;

#endif
