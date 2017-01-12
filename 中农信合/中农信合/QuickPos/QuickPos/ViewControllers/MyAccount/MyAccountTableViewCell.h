//
//  MyAccountTableViewCell.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/11.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题

@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;//余额之类的

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;//图标

@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;//箭头

@property (weak, nonatomic) IBOutlet UILabel *UserQuantityLabel;//用户量label

@property (weak, nonatomic) IBOutlet UILabel *Quantity;//后台取值--用户量label

@property (weak, nonatomic) IBOutlet UILabel *RunSubLabel;//分润比例label

@property (weak, nonatomic) IBOutlet UILabel *RunSub;//后台取值--分润比例


@property (weak, nonatomic) IBOutlet UIView *lineView;//分割线

@property (weak, nonatomic) IBOutlet UIImageView *ArrowImageView;//箭头


@end
