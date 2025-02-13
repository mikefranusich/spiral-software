
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
    hd = EVAL(PTR_BAG(hdCall)[1]);
    libname = HdToString(hd, "<library> must be a String.\n%s", (Int)usage, 0);
            
    printf("\n*** FunLoadLibrary(%s) ***\n", libname);
    
    handle = dlopen(libname, RTLD_LAZY);
    
    return INT_TO_HD(handle);
}


typedef void (*fptr)();

Obj FunFunctionPointer(Obj hdCall) {
    char * usage = "usage: FunctionPointer(<library handle>, <name>)";
    Obj  hd1, hd2;
    void *handle;
    char* funcname;
    void *funcptr;
    
    if (GET_SIZE_BAG(hdCall) != 3 * SIZE_HD) {
        return Error(usage, 0, 0);
    }
    hd1 = EVAL(PTR_BAG(hdCall)[1]);
    hd2 = EVAL(PTR_BAG(hdCall)[2]);
    handle = HdToInt(hd1, usage, 0, 0);
    funcname = HdToString(hd2, usage, 0, 0);
            
    printf("\n*** FunctionPointer(%d, %s) ***\n", handle, funcname);

    funcptr = dlsym(handle, funcname);
    
    return INT_TO_HD(funcptr);
}


Obj FunCallCFunction(Obj hdCall) {
    char * usage = "usage: CallCFunction(<function pointer>)";
    Obj  hd1;
    void *funcptr;
    
    hd1 = EVAL(PTR_BAG(hdCall)[1]);
    funcptr = HdToInt(hd1, usage, 0, 0);
    
    printf("\n*** CallCFunction(%d) ***\n", funcptr);
    
    ((fptr)funcptr)();
    
    return INT_TO_HD(0);
}




void Init_CFunc() {
    InstIntFunc("LoadLibrary", FunLoadLibrary);
    InstIntFunc("FunctionPointer", FunFunctionPointer);
    InstIntFunc("CallCFunction", FunCallCFunction);
}