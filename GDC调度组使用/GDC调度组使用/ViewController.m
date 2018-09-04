//
//  ViewController.m
//  GDC调度组使用
//
//  Created by tianNanYiHao on 2018/9/4.
//  Copyright © 2018年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self group];
}



- (void)group{
    
    //1. 创建调度组
    dispatch_group_t group = dispatch_group_create();
    
    //2. 创建队列
    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    
    //3. 调度组
    //3.1 任务A 入组
    dispatch_group_enter(group);
    dispatch_async(q, ^{
        
        [NSThread sleepForTimeInterval:4];
        
        NSLog(@"Download A: 耗时操作");
        //出组
        dispatch_group_leave(group);
        
    });
    
    //3.2 任务B 入组
    dispatch_group_enter(group);
    dispatch_async(q, ^{
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"Download B: 耗时操作");
        //出组
        dispatch_group_leave(group);
    });
    
    
    //4. 通知,返回指定队列 执行相关代码
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"下载完成!!!!!!");
    });
    
    
}




@end
