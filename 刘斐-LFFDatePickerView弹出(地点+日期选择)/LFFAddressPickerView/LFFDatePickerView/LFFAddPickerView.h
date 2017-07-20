//
//  LFFAddPickerView.h
//  QuickPos
//
//  Created by Lff on 16/10/19.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LFFAddPickerViewDelegate<NSObject>
//点击灰色部分隐藏
-(void)hiddenLFFAddPickerView;

-(void)returnFromeLFFAddPickerInfo:(NSArray*)arr;
-(void)returnToLFFAddPickerInfo:(NSArray*)arr;



@end


@interface LFFAddPickerView : UIView
@property (nonatomic,strong) NSArray *infoArray;
@property (nonatomic,strong) NSString *fromeAddress;
@property (nonatomic,strong) NSString *toAddress;

@property (nonatomic,assign) id<LFFAddPickerViewDelegate>delegate;

+(LFFAddPickerView*)awakeFromXib;

@end
