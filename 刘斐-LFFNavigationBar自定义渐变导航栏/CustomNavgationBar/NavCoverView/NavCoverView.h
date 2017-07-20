//
//  NavCoverView.h
//  sandbao
//
//  Created by tianNanYiHao on 2017/3/8.
//  Copyright © 2017年 sand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    navCoverViewStyle1 = 0,
    navCoverViewStyle2,
    navCoverViewStyle3,
}NavCoverViewStyle;

@interface NavCoverView : UIView

+(NavCoverView*)shareNavCoverView:(CGRect)frame title:(NSString*)title style:(NavCoverViewStyle)style;


@end
