//
//  HelpViewController.m
//  QuickPos
//
//  Created by kuailefu on 15/10/15.
//  Copyright © 2015年 张倡榕. All rights reserved.
//

#import "HelpViewController.h"
#import "Common.h"
@interface HelpViewController ()
@property (nonatomic, strong) UIImageView *mainImage;
@end

@implementation HelpViewController

- (UIImageView *)mainImage{
    if (!_mainImage) {
        _mainImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _mainImage.image = [UIImage imageNamed:@"pay_help.png"];
    }
    return _mainImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.title = @"说明";
    self.view.backgroundColor =[Common hexStringToColor:@"eeeeee"];
    
    [self.view addSubview:self.mainImage];
    self.mainImage.frame  = CGRectMake(10, 10, CGRectGetWidth(self.view.frame) - 20, CGRectGetWidth(self.view.frame) - 20);
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
