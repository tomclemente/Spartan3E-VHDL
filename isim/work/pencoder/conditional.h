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

#ifndef H_Work_pencoder_conditional_H
#define H_Work_pencoder_conditional_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_pencoder_conditional: public HSim__s6 {
public:

    HSim__s1 SE[2];

    HSim__s1 SA[1];
  char t0;
HSimConstraints *c1;
  char t2;
HSimConstraints *c3;
  char t4;
HSimConstraints *c5;
  char t6;
HSimConstraints *c7;
    Work_pencoder_conditional(const char * name);
    ~Work_pencoder_conditional();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_pencoder_conditional(const char *name);

#endif
