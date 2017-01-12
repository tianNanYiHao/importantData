//
//  DetailOriginOfGoodsViewController.h
//  QuickPos
//
//  Created by feng Jie on 16/7/5.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailOriginOfGoodsViewController : UIViewController

@property (nonatomic,strong) NSString *titleName;//标题名称

@property (nonatomic,strong) NSString *producerName;//生产厂商名称

@property (nonatomic,strong) NSString *thumbnailUrl;//图片缩略图

@property (nonatomic,strong) NSString *pictureUrl;//图片网址

@property (nonatomic,strong) NSString *guaranteeDays;//保质期天数

@property (nonatomic,strong) NSString *standard;//产品规格

@property (nonatomic,strong) NSString *productDescriptions;//产品描述

@end
