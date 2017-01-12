//
//  WaterElectricityCoalViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "WaterElectricityCoalViewController.h"
#import "ROllLabel.h"

@interface WaterElectricityCoalViewController ()


@end

@implementation WaterElectricityCoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.item) {
        self.navigationItem.title = @"水电煤";
    }
//    self.notes.text = [self.item objectForKey:@"announce"];
    [ROllLabel rollLabelTitle:[self.item objectForKey:@"announce"] color:[UIColor blackColor] backgroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:17.0] superView:self.notes fram:CGRectMake(0, 0, self.notes.frame.size.width, self.notes.frame.size.height)];
    self.navigationItem.title = [self.item objectForKey:@"title"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
