//
//  EditMallViewController.h
//  QuickPos
//
//  Created by 张倡榕 on 15/6/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallData.h"

@interface EditMallViewController : UIViewController

@property (nonatomic , strong)MallData *mallData;

@property (nonatomic , strong)NSMutableArray *editMerchandiseArr;     //商城数据源


@end
