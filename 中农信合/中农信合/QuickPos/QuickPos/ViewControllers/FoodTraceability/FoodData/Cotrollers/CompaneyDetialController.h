//
//  CompaneyDetialController.h
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompaneyDetialController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *compenyDetalVIew1;//bgview1

@property (weak, nonatomic) IBOutlet UIView *compenyDetalVIew2; //bgview2

@property (weak, nonatomic) IBOutlet UILabel *companyIntroDutionLab;//简介


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,strong) NSString *enterpriseId; //查询id
@property (nonatomic,strong) NSString *descriptionS;//描述




@end
