//
//  LFFPickerVIew.h
//  SFoofSave
//
//  Created by Lff on 16/8/22.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFFPickerViewDelegate <NSObject>
//按灰色背景隐藏
-(void)changeAlphaHiden;
//按确认按钮隐藏
-(void)changeAlphaHiden:(NSString*)dateStr;
@end

@interface LFFPickerVIew : UIView
@property (nonatomic,assign) id<LFFPickerViewDelegate> delegate;
@property (nonatomic,assign) NSInteger Timetype; //



+ (LFFPickerVIew*)awakeFromXib;
-(NSString*)formatterDate:(NSDate*)date;


@end
