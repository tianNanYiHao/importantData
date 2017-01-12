//
//  MessageCell.h
//  QuickPos
//
//  Created by Leona on 15/4/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;//消息图标

@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;//消息标题

@property (weak, nonatomic) IBOutlet UILabel *messageTextLabel;//消息内容

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//消息日期

@end
