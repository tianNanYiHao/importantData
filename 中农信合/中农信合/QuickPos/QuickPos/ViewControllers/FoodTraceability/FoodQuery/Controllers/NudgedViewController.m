//
//  NudgedViewController.m
//  QuickPos
//
//  Created by caiyi on 16/1/17.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "NudgedViewController.h"

@interface NudgedViewController ()
{
    UITableView *_tableView;
}
@end

@implementation NudgedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = L(@"SmartSensors");
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView.scrollEnabled = NO;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 548) style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"nfc"];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nfc"]];
    //防止图片变形,用这个方法
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_tableView setBackgroundView:imageView];
    [self.view addSubview:_tableView];
    [self setExtraCellLineHidden:_tableView];
    
}

- (void)setExtraCellLineHidden: (UITableView *)tableView


{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
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
