//
//  ProducyListSYCell.m
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ProducyListSYCell.h"
#import "ProducyListSYModel.h"

@implementation ProducyListSYCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(ProducyListSYModel *)model{
    _model = model;

    [_incnNameStr sd_setImageWithURL:[NSURL URLWithString:model.thumbnailUrl] placeholderImage:[UIImage imageNamed:@"22"]]
    ;
    _productTitleLab.text = model.name;
    _firmLab.text = model.producerName;
    _sallAddressLab.text = model.producerName;
    _productSizeLab.text = model.standard;
    _ValidityLab.text = model.guaranteeDays;    
}

@end
