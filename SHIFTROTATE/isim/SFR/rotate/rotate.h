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

#ifndef H_Sfr_rotate_H
#define H_Sfr_rotate_H

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


#include "ieee/std_logic_1164/std_logic_1164.h"

class Sfr_rotate: public HSim__s6 {
public:
/* subprogram name ROLCF */
char *Gk(HSimConstraints *reConstr,  HSim__s1 *Sd, int ssindexSd, int offsetSd,  HSim__s1 *Sg, int ssindexSg, int offsetSg);
/* subprogram name RORF */
char *Gw(HSimConstraints *reConstr,  HSim__s1 *St, int ssindexSt, int offsetSt);
/* subprogram name ROLP */
void GL(HSim__s7 *process,  HSim__s1 *SD, int ssindexSD, int offsetSD,  HSim__s1 *SJ, int ssindexSJ, int offsetSJ, HSim__s2 * driver_SJ);
/* subprogram name RORCP */
void G13(HSim__s7 *process,  HSim__s1 *ST, int ssindexST, int offsetST,  HSim__s1 *SV, int ssindexSV, int offsetSV,  HSim__s1 *S11, int ssindexS11, int offsetS11, HSim__s2 * driver_S11);

public:

public:
  Sfr_rotate(const HSimString &name);
  ~Sfr_rotate();
};

extern Sfr_rotate *SfrRotate;

#endif
