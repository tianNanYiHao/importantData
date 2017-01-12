//
//  EnterViewController.m
//  QuickPos
//
//  Created by caiyi on 16/1/6.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "EnterViewController.h"

@interface EnterViewController ()
{
    UITableView *_tableView;
}

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"输一输";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView.scrollEnabled = NO;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, 66, 250, 250) style:UITableViewStyleGrouped];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"expect"]];
    [_tableView setBackgroundView:imageView];
    [self.view addSubview:_tableView];
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
