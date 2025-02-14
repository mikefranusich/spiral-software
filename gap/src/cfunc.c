
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


typedef void (*fptr)();


Obj FunCallCFunction(Obj hdCall) {
    char * usage = "usage: CallCFunction(<library>, <function>, <args>...)";
    Obj  hd1, hd2;
    char* libname;
    char* funcname;
    void *handle;
    void *funcptr;
    
    if (GET_SIZE_BAG(hdCall) < 3 * SIZE_HD) {
        return Error(usage, 0, 0);
    }
    hd1 = EVAL(PTR_BAG(hdCall)[1]);
    hd2 = EVAL(PTR_BAG(hdCall)[2]);
    
    libname = HdToString(hd1, "<library> must be a String.\n%s", usage, 0);
    funcname = HdToString(hd2, "<function> must be a String.\n%s", usage, 0);
    
    handle = dlopen(libname, RTLD_LAZY);
    if (handle == 0) {
        return Error("cannot open shared library %s", libname, 0);
    }
    
    funcptr = dlsym(handle, funcname);
    if (funcptr == 0) {
        return Error("cannot find function %s in library %s", funcname, libname);
    }
    
    ((fptr)funcptr)();
    
    return INT_TO_HD(0);
}




void Init_CFunc() {
    InstIntFunc("CallCFunction", FunCallCFunction);
}