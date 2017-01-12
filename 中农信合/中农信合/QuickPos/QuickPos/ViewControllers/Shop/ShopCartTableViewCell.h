//
//  ShopCartTableViewCell.h
//  QuickPos
//
//  Created by YZ on 15/8/25.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *bg;
@property (nonatomic, strong) IBOutlet UIImageView *actor;

@property (nonatomic, strong) IBOutlet UILabel *indexLabel;
@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *price1;
@property (nonatomic, strong) IBOutlet UILabel *price2;
@property (nonatomic, strong) IBOutlet UILabel *totalprice;
@property (nonatomic, strong) IBOutlet UILabel *num;
@property (nonatomic, strong) IBOutlet UIButton *del;
@end
