//
//  ProducyListSYCell.h
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProducyListSYModel;

@interface ProducyListSYCell : UITableViewCell
@property (nonatomic,strong)ProducyListSYModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *incnNameStr; //图标
@property (weak, nonatomic) IBOutlet UILabel *productTitleLab;    //产品标题


//生产厂商
@property (weak, nonatomic) IBOutlet UILabel *firmLab;


//销售网点
@property (weak, nonatomic) IBOutlet UILabel *sallAddressLab;

//规格
@property (weak, nonatomic) IBOutlet UILabel *productSizeLab;

//有效期
@property (weak, nonatomic) IBOutlet UILabel *ValidityLab;


@end
