//
//  ViewController.m
//  cateGory支持属性
//
//  Created by Lff on 17/1/19.
//  Copyright © 2017年 Lff. All rights reserved.
//

#import "ViewController.h"
#import "TestObject.h"
#import "NSObject+TestObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _TestObject *t = [[_TestObject alloc] init];
    //类的实例方法
    t.name = @"lff1";
    t.age = @"58";
    [t logYouInfo];
    
  
    //分类的扩充方法(带属性)
    t.sex = @"man";  //category成功支持了属性
    [t changYouInfo];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
