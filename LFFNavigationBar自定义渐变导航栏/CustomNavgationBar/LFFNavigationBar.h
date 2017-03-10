//
//  LFFNavigationBar.h
//  CustomNavgationBar
//
//  Created by tianNanYiHao on 2017/3/10.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LFFNavgationBarDeful = 0,
    LFFNavgationBarOnlyGoBack,
    LFFNavgationBarBackAndNext,
    LFFNavgationBarSystenBtn,
}LFFNavgationBarStyle;


typedef void(^LeftBtnBlock)();
typedef void(^RightBtnBlock)();


@interface LFFNavigationBar : UIView
//左边图标图片名
@property (nonatomic,strong) NSString *leftBtnImageName;

//左边按钮名
@property (nonatomic,strong) NSString *leftBanName;

//右边图标图片名
@property (nonatomic,strong) NSString *rightBtnInageName;

//右边按钮名
@property (nonatomic,strong) NSString *rightBtnName;

//中间Title
@property (nonatomic,strong) NSString *titleName;

//block
@property (nonatomic,copy)LeftBtnBlock leftBlock;
@property (nonatomic,copy)RightBtnBlock rightBlock;

/**
 初始化导航条样式

 @param frame (0,20,w,64)
 @param style 样式
 @return 导航条
 */
-(instancetype)initWithFrame:(CGRect)frame lffNavgationBarStyle:(LFFNavgationBarStyle)style leftBLOCK:(LeftBtnBlock)leftblock rightBLOCK:(RightBtnBlock)rightblock;


/**
 设置完成
 */
-(void)addLFFNavgationBar;

@end
