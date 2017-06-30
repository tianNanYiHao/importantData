/*
 * PayNuc
 *
 * Copyright (c) 2016 Rick Xing <xing.zw@sand.com.cn>
 *
 * 2016-12-27
 */

#ifndef __PAYNUC_H__
#define __PAYNUC_H__

#include <string>
using namespace std;

extern string (* PostWithData_Address)(string url, string data);

class PayNuc
{
public:
    PayNuc(void);
    ~PayNuc(void);

    void init(void);
    int func(string func_type);
    void set(string key, string value);
    string get(string key);
    string pinenc(string pass);
    string lgnenc(string pass);
    
};

#endif
