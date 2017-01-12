//
//  ShoppingCartTableViewCell.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopCartMerchandiseImage;
@property (weak, nonatomic) IBOutlet UILabel *shopCartMerchandiseName;
@property (weak, nonatomic) IBOutlet UILabel *shopCartMerchandisePrice;
@property (weak, nonatomic) IBOutlet UILabel *shopCartMerchandiseSum;

@end
