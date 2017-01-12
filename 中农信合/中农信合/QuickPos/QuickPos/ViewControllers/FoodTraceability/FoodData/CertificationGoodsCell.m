//
//  CertificationGoodsCell.m
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CertificationGoodsCell.h"
#import "CertificationGoodsModel.h"

@implementation CertificationGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(CertificationGoodsModel *)model{
    _model = model;
    _compLab.text = model.compLabStr;
    _discripLab.text = model.discripLabStr;
    _icon.image = [UIImage imageNamed:model.iconNameStr];
    
    
    
//    _model = model;
//    _compLab.text = model.name;
//    _discripLab.text = model.parent;
//    _icon.image = [UIImage imageNamed:@"22"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
