//
//  NoteViewController.h
//  QuickPos
//
//  Created by 胡丹 on 15/4/24.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *noteTextView;
@property (retain, nonatomic) NSDictionary *item;

@end
