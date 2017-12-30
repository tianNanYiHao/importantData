//
//  SDMBProgressView.m
//  MBPHUDProgressLFFDemo
//
//  Created by tianNanYiHao on 2017/6/17.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDMBProgressView.h"
#import "MBProgressHUD.h"
#import "SDActivityView.h"


#define bezlViewWH 30

//转圈一直转啊转的 超时时间
#define durationTimeOut  45.f

@interface  SDMBProgressView(){
    
    MBProgressHUD *HUD;
}
@end

@implementation SDMBProgressView

#pragma mark - PUBLICK_FUNC
/**
 仅网络加载时用(系统activity)
 
 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressOnlyLoadingINView:(UIView*)view{
    
    SDMBProgressView *sdMbprogressView = [[SDMBProgressView alloc] initwithType:SDMBProgressViewOnlyLoading lableText:nil];
    sdMbprogressView.backgroundColor = [UIColor clearColor];
    sdMbprogressView.frame = view.frame;
    [view addSubview:sdMbprogressView];
    return sdMbprogressView;
    
}

/**
 仅网络加载时用(自定义view)
 
 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressOnlyLoadingINViewImg:(UIView*)view{
    
    SDMBProgressView *sdMbprogressView = [[SDMBProgressView alloc] initwithType:SDMBProgressViewOnlyLoadingIMG lableText:nil];
    sdMbprogressView.backgroundColor = [UIColor clearColor];
    sdMbprogressView.frame = view.frame;
    [view addSubview:sdMbprogressView];
    return sdMbprogressView;
}

/**
 加载失败时用
 
 @param view 视图
 @return SDMBProgressView实例
 */
+ (SDMBProgressView*)showSDMBProgressLoadErrorINView:(UIView *)view{
    
    SDMBProgressView *sdMbprogressView = [[SDMBProgressView alloc] initwithType:SDMBProgressViewLoadError lableText:nil];
    sdMbprogressView.backgroundColor = [UIColor clearColor];
    sdMbprogressView.frame = view.frame;
    [view addSubview:sdMbprogressView];
    return sdMbprogressView;
}


/**
 加载失败时用(带图)
 
 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressLoadErrorImgINView:(UIView*)view{
    
    SDMBProgressView *sdMbprogressView = [[SDMBProgressView alloc] initwithType:SDMBProgressViewLoadErrorIMG lableText:nil];
    sdMbprogressView.backgroundColor = [UIColor clearColor];
    sdMbprogressView.frame = view.frame;
    [view addSubview:sdMbprogressView];
    return sdMbprogressView;
    
}

/**
 常规模式
 
 @param view 视图
 @param text 文字
 @return SDMBProgressView
 */
+(SDMBProgressView*)showSDMBProgressNormalINView:(UIView*)view lableText:(NSString*)text{
    
    SDMBProgressView *sdMbprogressView = [[SDMBProgressView alloc] initwithType:SDMBProgressViewNormal lableText:text];
    sdMbprogressView.backgroundColor = [UIColor clearColor];
    sdMbprogressView.frame = view.frame;
    [view addSubview:sdMbprogressView];
    return sdMbprogressView;
}



/**
 延迟隐藏
 
 @param time time
 */
-(void)hiddenDelay:(NSInteger)time{
    
    //1.隐藏MBProgressHUD实例
    [HUD hideAnimated:YES afterDelay:time];
    
    //2.延迟执行删除 SDMBProgressView实例
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time+0.3)*NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        //2.删除
        [self removeFromSuperview];
    });
}



/**
 隐藏
 */
-(void)hidden{
    
    [HUD hideAnimated:YES afterDelay:0.2];
     [self removeFromSuperview];
    //2.延迟执行删除 SDMBProgressView实例(为动画预留时间)
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3*NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        //2.删除
        [self removeFromSuperview];
    });
}



#pragma mark - PRIVTE_FUNC
//初始化SDMBProgressView
-(instancetype)initwithType:(SDMBProgressViewType)type lableText:(NSString*)lableText{
    
    if (self == [super init]) {
        
        if (type == SDMBProgressViewOnlyLoading) {
            lableText = @"正在加载中...";
            [self addMBProgressHUD:MBProgressHUDModeIndeterminate animationType:MBProgressHUDAnimationZoomOut customView:nil lableText:lableText detailsLabelText:nil hid:NO delayTime:durationTimeOut];
        }
        if (type == SDMBProgressViewOnlyLoadingIMG) {
            lableText = @"正在加载中...";
            SDActivityView *activityV = [[SDActivityView alloc]initWithImage:@"SDMBPRotaion" view:self rectWH:bezlViewWH];
            [self addMBProgressHUD:MBProgressHUDModeCustomView animationType:MBProgressHUDAnimationZoomOut customView:(UIImageView*)activityV lableText:lableText detailsLabelText:nil hid:NO delayTime:durationTimeOut];
        }
        if (type == SDMBProgressViewLoadError) {
            lableText = @"信息加载失败";
            [self addMBProgressHUD:MBProgressHUDModeText animationType:MBProgressHUDAnimationZoomOut customView:nil lableText:lableText detailsLabelText:nil hid:YES delayTime:2.0f];
        }
        if (type == SDMBProgressViewLoadErrorIMG) {
            lableText = @"网络请求失败";
            UIImageView *customview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SDMBPerror"]];
            [self addMBProgressHUD:MBProgressHUDModeCustomView animationType:MBProgressHUDAnimationZoomOut customView:customview lableText:lableText detailsLabelText:nil hid:YES delayTime:2.0f];
        }
        if (type == SDMBProgressViewNormal) {
            [self addMBProgressHUD:MBProgressHUDModeText animationType:MBProgressHUDAnimationZoomOut customView:nil lableText:lableText detailsLabelText:nil hid:YES delayTime:2.0f];
        }
        
    }return self;
}


-(void)addMBProgressHUD:(MBProgressHUDMode)mode animationType:(MBProgressHUDAnimation)animationType customView:(UIImageView*)customview  lableText:(NSString*)text detailsLabelText:(NSString*)detailsText hid:(BOOL)hid delayTime:(NSInteger)time{
    
    //1.初始化MBProgressHUD
    HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    //2.设置模式
    HUD.mode = mode;
    /*
     MBProgressHUDModeIndeterminate;//菊花，默认值
     MBProgressHUDModeDeterminate;//圆饼，饼状图
     MBProgressHUDModeDeterminateHorizontalBar;//进度条
     MBProgressHUDModeAnnularDeterminate;//圆环作为进度条
     MBProgressHUDModeCustomView; //需要设置自定义视图时候设置成这个
     MBProgressHUDModeText; //只显示文本
     */
    
    
    //3.设置退出动画模式
    HUD.animationType = animationType;
    /*
     MBProgressHUDAnimationFade    // 无动画退出
     MBProgressHUDAnimationZoom    // 缩小退出
     MBProgressHUDAnimationZoomOut // 缩小退出
     MBProgressHUDAnimationZoomIn  // 放大退出
     */
    
    
    //4.设置backgroundView(整个屏幕)背景色
    HUD.backgroundView.backgroundColor = [UIColor lightGrayColor];
    HUD.backgroundView.alpha = 0.1f;
    
    //5.设置 bezelView(中间方块)
    HUD.bezelView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7f];
    
    //6.设置边距
    HUD.margin = 15.0f;
    
    
    //8.设置描述文字
    HUD.detailsLabel.text = detailsText;
    HUD.detailsLabel.textColor = [UIColor greenColor];
    
    //9.HUD隐藏时从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    
    
    //10. HUD自定义View
    if (customview) {
        HUD.customView = customview;
        NSLayoutConstraint *w_constraint = [NSLayoutConstraint constraintWithItem:customview
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:bezlViewWH];
        NSLayoutConstraint *h_constraint = [NSLayoutConstraint constraintWithItem:customview
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:bezlViewWH];
        [HUD.customView addConstraints:@[w_constraint,h_constraint]];
    }

    
    
    //7.设置显示文字(文字须在自定义模式后设置,颜色才可设置)
    HUD.label.font = [UIFont systemFontOfSize:16.0f];
    HUD.label.textColor = [UIColor whiteColor];
    HUD.label.text = text;

    
    
    if (hid) {
        //
        [self hiddenDelay:time];
        
    }
    
    
}



@end
