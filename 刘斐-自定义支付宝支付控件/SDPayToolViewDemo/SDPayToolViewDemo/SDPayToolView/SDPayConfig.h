//
//  SDPayConfig.h
//  SDPayToolViewDemo
//
//  Created by tianNanYiHao on 2017/9/8.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SDPayAnimtion.h"
#import "SDPayView.h"
#import "SDPayToolOrderView.h"
#import "SDPayToolListView.h"
#import "SDPayToolPwdView.h"
#import "SDPayKeyBoardView.h"
#import "SDPaySuccessAnimationView.h"


#define AdapterWfloat(f) ((f/375.f)*[UIScreen mainScreen].bounds.size.width)
#define AdapterHfloat(f) ((f/667.f)*[UIScreen mainScreen].bounds.size.height)
#define AdapterFfloat(f) (([[UIScreen mainScreen] bounds].size.height==736.f)?(f):(f*0.8571))

//颜色设置
#define Rgba(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
#define lineColor Rgba(230,230,230)
#define payBtnColor Rgba(53,139,239)
#define textGrayColor Rgba(140,144,157)
#define textBlackColor Rgba(28,28,28)
#define forgetPwdTextColor Rgba(255, 93, 49)
#define paySuccessAnimationViewCricleColor Rgba(0,173,193)

#define pwdBackGroundColor Rgba(225, 225, 225)
#define pwdBorderColor Rgba(229,229,229)
#define pwdTextFieldTextColor [UIColor blackColor]

#define keyBoardColor Rgba(174, 174, 174)


//字体设置
#define titleFont      AdapterFfloat(17.f)
#define payOrderInfoLabFont AdapterFfloat(16.f)
#define paylistTitleFont AdapterFfloat(15.f)
#define paylisttitleDesFont AdapterFfloat(12.f)
#define moneyLabFont   AdapterFfloat(36.f)
#define payBtnFont     AdapterFfloat(20.f)
#define pwdTextFieldTextSizeFont AdapterFfloat(17.f)

#define keyBoardBtnCleanFont AdapterFfloat(18.f)
#define keyBoardBtnFontNormal AdapterFfloat(20.f)
#define keyBoardBtnFontHeighted AdapterFfloat(27.f)


//按钮TAG
#define PAY_TOOL_LIST_BTN_BASE_TAG 10000
#define PAY_TOOL_LIST_ADDCARDBTN_TAG 30000

//动画设置
#define durationTime      0.25f
#define maskViewShowAlpha 0.35f
#define maksViewHidAlpha  0.f

#define SDPayToolOrderViewWillLoadFrame           CGRectMake(ViewBaseOX, ScreenH, ScreenW, ViewBaseH)
#define SDPayToolOrderViewDidLoadFrame            CGRectMake(ViewBaseOX, ViewBaseOY, ScreenW, ViewBaseH)
#define SDPayToolOrderViewRightTranslationFrame   CGRectMake(-ScreenW, ViewBaseOY, ScreenW, ViewBaseH)
#define SDPayToolOrderViewRightDidDisapper        CGRectMake(-ScreenW, ScreenH, ScreenW, ViewBaseH)

#define SDPayToolListViewWillLoadFrame            CGRectMake(ScreenW, ViewBaseOY, ScreenW, ViewBaseH)
#define SDPayToolListViewDidLoadFrame             CGRectMake(ViewBaseOX, ViewBaseOY, ScreenW, ViewBaseH)
#define SDPayToolListViewDidDisapper              CGRectMake(ViewBaseOX, ScreenH, ScreenW, ViewBaseH)


#define SDPayToolPwdViewWillLoadFrame             CGRectMake(ScreenW, ViewBaseOY, ScreenW, ViewBaseH)
#define SDPayToolPwdViewDidLoadFrame              CGRectMake(ViewBaseOX, ViewBaseOY, ScreenW, ViewBaseH)
#define SDPayToolPwdViewDidDisapper               CGRectMake(ViewBaseOX, ScreenH, ScreenW, ViewBaseH)


#define SDPayKeyBoardWillLoadFrame      CGRectMake(0, superViewSize.height, ScreenW,keyBordViewHeight)
#define SDPayKeyBoardDidLoadFrame       CGRectMake(0, superViewSize.height-keyBordViewHeight, ScreenW,keyBordViewHeight)

//UI设置
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ViewBaseH   ScreenH * 0.7f
#define ViewBaseOX  0.f
#define ViewBaseOY  ScreenH - ViewBaseH

#define SIDE_LEFT_RIGHT 15.0f
#define SIDE_SPACE          10.f
#define SIDE_COMMWIDTH      ScreenW - 2*SIDE_LEFT_RIGHT
#define LineBorder          0.5f

#define PAYTOOL_PAYPASS @"PAYLTOOL_LIST_PAYPASS"
#define PAYTOOL_ACCPASS @"PAYLTOOL_LIST_ACCPASS"


//键盘属性
#define keyBordCellBoardLine 0.3f
#define keyBordViewWidth ([UIScreen mainScreen].bounds.size.width - AdapterWfloat(105))
#define keyBordViewHeight ((AdapterHfloat(98)*2)+AdapterHfloat(40))
#define keyBordCellWidth  (keyBoardW - 2*keyBordCellBoardLine)/3
#define keyBordCellHeight (AdapterHfloat(98)*2)/4

//图片size
#define ImgSizeH(imgName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgName]].size.height
#define ImgSizeW(imgName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imgName]].size.width

//通知名
#define PaySuccessAnimationNotifaction @"paySuccessAnimationNotifacation"


