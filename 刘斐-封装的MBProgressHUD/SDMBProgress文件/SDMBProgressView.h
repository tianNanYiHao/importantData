//
//  SDMBProgressView.h
//  MBPHUDProgressLFFDemo
//
//  Created by tianNanYiHao on 2017/6/17.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,SDMBProgressViewType){
    SDMBProgressViewOnlyLoading,  //仅加载模式
    SDMBProgressViewOnlyLoadingIMG,//仅加载(带图)模式
    SDMBProgressViewLoadError,//网络连接失败模式
    SDMBProgressViewLoadErrorIMG,//网络连接失败(带图)模式
    SDMBProgressViewNormal   //常规模式
};

@interface SDMBProgressView : UIView
@property (nonatomic, assign) SDMBProgressViewType type;



/**
 仅网络加载时用(系统activity)

 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressOnlyLoadingINView:(UIView*)view;



/**
 仅网络加载时用(自定义view)
 
 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressOnlyLoadingINViewImg:(UIView*)view;



/**
 加载失败时用(无图)

 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressLoadErrorINView:(UIView*)view;



/**
 加载失败时用(带图)
 
 @param view 视图
 @return SDMBProgressView实例
 */
+(SDMBProgressView*)showSDMBProgressLoadErrorImgINView:(UIView*)view;



/**
 常规模式

 @param view 视图
 @param text 文字
 @return SDMBProgressView
 */
+(SDMBProgressView*)showSDMBProgressNormalINView:(UIView*)view lableText:(NSString*)text;




/**
 延迟隐藏

 @param time time
 */
-(void)hiddenDelay:(NSInteger)time;



/**
 隐藏
 */
-(void)hidden;






@end
