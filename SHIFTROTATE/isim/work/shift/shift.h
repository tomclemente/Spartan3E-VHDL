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

#ifndef H_Work_shift_H
#define H_Work_shift_H

#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


#include "ieee/std_logic_1164/std_logic_1164.h"

class Work_shift: public HSim__s6 {
public:
  HSimRecordType Shift;
/* subprogram name SLAF */
char *Gs(HSimConstraints *reConstr,  HSim__s1 *Sn, int ssindexSn, int offsetSn);
/* subprogram name SRAF */
char *GC(HSimConstraints *reConstr,  HSim__s1 *Sz, int ssindexSz, int offsetSz);

public:

public:
  Work_shift(const HSimString &name);
  ~Work_shift();
};

extern Work_shift *WorkShift;

#endif
