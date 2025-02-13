
//  Copyright (c) 2025, Carnegie Mellon University
//  See LICENSE for details

//
// cfunc.c -- support for loading dynamic libraries and calling C functions from GAP
//

#include <stdlib.h>
#include <stdio.h>

#ifdef WIN32
    #include "win_dlfcn.h"
#else
    #include <dlfcn.h>
#endif


// for GAP to C functions
#include "system.h"
#include "memmgr.h" 
#include "integer.h"
#include "args.h"
#include "eval.h"


Obj FunLoadLibrary(Obj hdCall) {
    char * usage = "usage: LoadLibrary(<library>)";
    Obj hd;
    char* libname;
    void *handle;
    
    if (GET_SIZE_BAG(hdCall) != 2 * SIZE_HD) {
        return Error(usage, 0, 0);
    }
    hd = EVAL( PTR_BAG(hdCall)[1] );
    libname = (char*)HdToString(hd,
            "<library> must be a String.\nUsage: %s", (Int)usage, 0);
            
    printf("\n*** FunLoadLibrary(%s) ***\n", libname);
    
    handle = dlopen(libname, RTLD_LAZY);
    
    return INT_TO_HD(handle);
}




void Init_CFunc() {
    InstIntFunc("LoadLibrary", FunLoadLibrary); 
}