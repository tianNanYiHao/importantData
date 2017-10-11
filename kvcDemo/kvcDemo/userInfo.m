//
//  userInfo.m
//  kvcDemo
//
//  Created by tianNanYiHao on 2017/10/9.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "userInfo.h"

@implementation userInfo


-(void)setAddress:(sdaddress *)address{
    
    //传入的address此刻并不是模型 而是一个字典数据,address其实应该理解为 addressDict ,由于kvc需要,所以将其表示为address
    _address = address;
    sdaddress *adM = [sdaddress new];
    [adM setValuesForKeysWithDictionary:(NSDictionary*)address];
    _address = adM;
}

- (void)setLinks:(sdlinks *)links{
    //传入的links此刻并不是模型 而是一个数组字典,links其实应该理解为 linksArr ,由于kvc需要,所以将其表示为links
    _links = links;
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (id item in (NSArray*)_links) {
        sdlinks *link = [sdlinks new];
        [link setValuesForKeysWithDictionary:item];
        [arr addObject:link];
    }
    _links = (sdlinks*)arr;
}



+ (NSMutableDictionary*)userInfoDict{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [dict setValue:@"" forKey:@"name"];
    [dict setValue:@"" forKey:@"url"];
    [dict setValue:@"" forKey:@"page"];
    [dict setValue:@"" forKey:@"isNonProfit"];
    [dict setValue:@"" forKey:@"address"];
    [dict setValue:@"" forKey:@"links"];
    return dict;
}







- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"key :%@ is not found" ,key);
}

@end
