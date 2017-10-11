//
//  ViewController.m
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "userInfo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //一 : 使用构建的数据模型解析数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"111" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *minletsDIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    //传入json解析后的数据
    userInfo *uM = [userInfo new];
    [uM setValuesForKeysWithDictionary:minletsDIC];
    
    
    //输入数据模型
    NSLog(@"%@",uM.name);
    NSLog(@"%@",uM.url);
    NSLog(@"%@",uM.page);
    NSLog(@"%@",uM.isNonProfit);
    
    NSLog(@"%@",uM.address.city);
    NSLog(@"%@",uM.address.country);
    NSLog(@"%@",uM.address.street);
    
    for (sdlinks *link in (NSArray*)uM.links) {
        NSLog(@"%@",link.name);
        NSLog(@"%@",link.url);
    }
    
    NSLog(@"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
    
    //二 : 使用构建的数据模型修改数据
    sdlinks *link =  ((NSArray*)uM.links)[0];
    [uM setValue:@"lalalla" forKeyPath:@"links.name"];

    
    //输入数据模型
    NSLog(@"%@",uM.name);
    NSLog(@"%@",uM.url);
    NSLog(@"%@",uM.page);
    NSLog(@"%@",uM.isNonProfit);
    
    NSLog(@"%@",uM.address.city);
    NSLog(@"%@",uM.address.country);
    NSLog(@"%@",uM.address.street);
    
    for (sdlinks *link in (NSArray*)uM.links) {
        NSLog(@"%@",link.name);
        NSLog(@"%@",link.url);
    }
    
    
    NSLog(@"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
    //三 : 按需填充 并 重新拼装
    
    
    NSDictionary *userInfoDict = [userInfo userInfoDict];
    [userInfoDict setValue:@"BeJsonChange" forKey:@"name"];
    [userInfoDict setValue:@"http://www.bejsonChange.com" forKey:@"url"];
    [userInfoDict setValue:@18 forKey:@"page"];
    [userInfoDict setValue:@NO forKey:@"isNonProfit"];
    
    NSDictionary *addressDict = [sdaddress addressDict];
    [addressDict setValue:@"西藏南路" forKey:@"street"];
    [addressDict setValue:@"上海黄浦" forKey:@"city"];
    [addressDict setValue:@"中华人民共和国" forKey:@"country"];
    
    NSDictionary *linkDict = [sdlinks linksDict];
    [linkDict setValue:@"rensheng05" forKey:@"name"];
    [linkDict setValue:@"www.rs05.com" forKey:@"url"];
    
    [userInfoDict setValue:addressDict forKeyPath:@"address"];
    [userInfoDict setValue:@[linkDict] forKey:@"links"];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@[userInfoDict] options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
    
    /* 按需填充 拼装后的 json字符串如下:
     
     [{"address":{"street":"西藏南路","city":"上海黄浦","country":"中华人民共和国"},"links":[{"name":"rensheng05","url":"www.rs05.com"}],"isNonProfit":false,"name":"BeJsonChange","url":"http:\/\/www.bejsonChange.com","page":18}]
     
     */

    
}


- (void)setDictKey:(NSString*)key Value:(id)value{
    
    NSDictionary *dict = [NSDictionary dictionary];
    [dict setValue:value forKey:key];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
