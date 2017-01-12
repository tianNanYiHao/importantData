//
//  CertificationGoodsCell.h
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CertificationGoodsModel;

@interface CertificationGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *compLab;
@property (weak, nonatomic) IBOutlet UILabel *discripLab;
@property (nonatomic,strong) CertificationGoodsModel*model;



@end
