//
//  NSObject+TestObject.m
//  cateGory支持属性
//
//  Created by Lff on 17/1/19.
//  Copyright © 2017年 Lff. All rights reserved.
//

#import "NSObject+TestObject.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation NSObject (TestObject)

//定义关联的Key
static const char *key = "sex";

-(NSString *)sex{
    
    //根据关联的key 获取关联的值
    return objc_getAssociatedObject(self, key);
}

-(void)setSex:(NSString*)sex{
    //参数一:给那个对象添加关联
    //参数二:关联的key, 通过这个Key获取
    //参数三:关联的Value
    //参数四:关联的策略
    objc_setAssociatedObject(self, key, sex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)changYouInfo{
    NSLog(@"成功为Category添加了属性 => %@",self.sex);
}

@end
