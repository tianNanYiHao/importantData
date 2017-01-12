 //
//  DetailOriginOfGoodsViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/7/5.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "DetailOriginOfGoodsViewController.h"
#import "Common.h"

@interface DetailOriginOfGoodsViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *productInformationImage;

@property (weak, nonatomic) IBOutlet UILabel *productInformationTitle;

@property (weak, nonatomic) IBOutlet UILabel *firm;//生产厂商

@property (weak, nonatomic) IBOutlet UILabel *firmName;//生产厂商名称

@property (weak, nonatomic) IBOutlet UILabel *salesNetwork;//销售网点

@property (weak, nonatomic) IBOutlet UILabel *salesNetworkAdd;//销售网点地点

@property (weak, nonatomic) IBOutlet UILabel *specification;//规格

@property (weak, nonatomic) IBOutlet UILabel *specificationNum;//规格参数

@property (weak, nonatomic) IBOutlet UILabel *ShelfLife;//保质期

@property (weak, nonatomic) IBOutlet UILabel *ShelfLifeDay;//保质期天数

@property (weak, nonatomic) IBOutlet UILabel *productDescription;//产品描述label



@end

@implementation DetailOriginOfGoodsViewController
@synthesize titleName;
@synthesize producerName;
@synthesize thumbnailUrl;
@synthesize pictureUrl;
@synthesize guaranteeDays;
@synthesize standard;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"溯源信息";
    
    
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];//导航栏颜色
//    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"46a7ec"];//返回键颜色
//    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
//    //设置标题颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], UITextAttributeTextColor,
//                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
//                                                                     nil]];
    
    self.navigationController.navigationBar.barTintColor = [Common hexStringToColor:@"#068bf4"];//导航栏颜色
    self.navigationController.navigationBar.tintColor = [Common hexStringToColor:@"#ffffff"];//返回键颜色
    self.navigationController.navigationBar.contentMode = UIViewContentModeScaleAspectFit;
    //设置标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [Common hexStringToColor:@"#ffffff"], UITextAttributeTextColor,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];

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
