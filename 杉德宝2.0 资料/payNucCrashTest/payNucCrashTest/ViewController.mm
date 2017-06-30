//
//  ViewController.m
//  payNucCrashTest
//
//  Created by tianNanYiHao on 2017/6/30.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "PayNuc.h"
#include "HttpComm.h"   

#include "SDFile.h"
#include "SDLog.h"
#include "SDNetwork.h"
#include "SDSqlite.h"

#define AddressHTTP @"http://172.28.250.242:17892/"
@interface ViewController ()

@end
PayNuc paynuc;


@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self changeEnvironment:YES];
 
}

- (void)changeEnvironment:(BOOL)flag
{
    NSMutableDictionary *cfg_termFp = [NSMutableDictionary dictionaryWithCapacity:0];
    [cfg_termFp setValue:@"iPhone 5S" forKey:@"SystemName"];
    [cfg_termFp setValue:[[UIDevice currentDevice] systemVersion] forKey:@"SystemVersion"];
    [cfg_termFp setValue:[[UIDevice currentDevice] name] forKey:@"DeviceName"];
    [cfg_termFp setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"IDFV"];
    NSString *cfg_termFpStr = [self dictionaryToJson:cfg_termFp];
    
    
    PostWithData_Address = PostWithData;
    paynuc.init();
    paynuc.set("cfg_appMark", "sandbao-ios-1.0");
    paynuc.set("cfg_termFp", [cfg_termFpStr UTF8String]);
    if (flag) {
        paynuc.set("cfg_test", "true");
        paynuc.set("cfg_debug", "true");
        paynuc.set("cfg_httpAddress", [[NSString stringWithFormat:@"%@app/api/",AddressHTTP] UTF8String]);
    } else {
        paynuc.set("cfg_test", "false");
        paynuc.set("cfg_debug", "true");
        paynuc.set("cfg_httpAddress", [[NSString stringWithFormat:@"%@app/api/",AddressHTTP] UTF8String]);//生产
    }
}





- (IBAction)func:(id)sender {
    
    
    /*
     run_ok              = 0,
     msg_parse_err       = 1,
     msg_protocol_err    = 2,
     msg_sign_err        = 3,
     tube_expire         = 4,
     hmac_err            = 5,
     token_invalid       = 6,
     do_nothing          = 7
     */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int req = paynuc.func("CreateTube");
        NSLog(@"%d",req);
        if (req == 0) {
            NSLog(@"ok");
        }else{
            NSLog(@"ok个🐱");
        }
        
    });
}





- (NSString *)dictionaryToJson:(NSMutableDictionary *)dic
{
    if (dic != nil) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return [[str stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
