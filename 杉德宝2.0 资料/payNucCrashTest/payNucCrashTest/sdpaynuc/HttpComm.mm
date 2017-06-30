//
//  HttpComm.c
//  iRun
//
//  Created by Rick on 2016/12/28.
//  Copyright © 2016年 SAND. All rights reserved.
//

#include <string>
using namespace std;

#import "SDNetwork.h"
#import "SDLog.h"

#include "HttpComm.h"   


string PostWithData(string url, string data)
{
    [SDLog logNetwork:[NSString stringWithFormat:@"请求地址：%@", [NSString stringWithUTF8String:url.c_str()]]];
//    [SDLog logNetwork:[NSString stringWithFormat:@"请求发送报文：%@", [NSString stringWithUTF8String:data.c_str()]]];
    
    SDNetwork *sdNetwork = [[SDNetwork alloc] init];
    
    string senddata = "data=" + data;
    
    NSString* recvdata = [sdNetwork httpSystemPost:[NSString stringWithUTF8String:url.c_str()] messageInfo:[NSString stringWithUTF8String:senddata.c_str()]];
    
//    [SDLog logNetwork:[NSString stringWithFormat:@"请求返回报文：%@", recvdata]];
    
    return [recvdata UTF8String];
}



