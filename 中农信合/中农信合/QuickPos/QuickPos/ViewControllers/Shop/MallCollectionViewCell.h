//
//  MellCollectionViewCell.h
//  QuickPos
//
//  Created by 张倡榕 on 15/3/9.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *MerchandiseImage;
@property (weak, nonatomic) IBOutlet UILabel *MerchandiseNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *MerchandisePrice;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@end
