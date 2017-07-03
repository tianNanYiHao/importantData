//
//  ShowMessageTableViewCell.m
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/6.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import "ShowMessageTableViewCell.h"
@interface ShowMessageTableViewCell()
@property(nonatomic,strong) UILabel *messageLabel;//文本，或者图文的title
@property(nonatomic,strong) UIImageView *bgImgView;//文本背景图
@end

@implementation ShowMessageTableViewCell
#pragma mark 懒加载
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel=[[UILabel alloc] init];
        _messageLabel.translatesAutoresizingMaskIntoConstraints=false;
        _messageLabel.font=[UIFont systemFontOfSize:20];
        _messageLabel.numberOfLines=0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
//           self.messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, titleSzie.width, titleSzie.height)];
    }
    return _messageLabel;
}
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
//        UIImage *bgImg=[UIImage imageNamed:@"receive_bg.png"];
        _bgImgView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"send_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 15) resizingMode:UIImageResizingModeStretch]];
        _bgImgView.translatesAutoresizingMaskIntoConstraints=false;
//        _bgImgView.frame = CGRectMake(65, 14.0f, messageSize.width+30.0f, messageSize.height+20.0f);
    }
    return _bgImgView;
}
#pragma mark loadView
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)setMessage:(NSString *)message{
    _message=message;
    [self.contentView addSubview:self.bgImgView];
    [self.bgImgView addSubview:self.messageLabel];
    [self layoutVFL];
}

-(void)layoutVFL{

    CGSize messageSize=[self getMessageFram:self.message messageWidth:[UIScreen mainScreen].bounds.size.width-90];
    
    //背景视图水平约束
    NSArray *bgImgViewH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_bgImgView(==width)]" options:0 metrics:@{@"width":@(messageSize.width+30)} views:@{@"_bgImgView":_bgImgView}];
    [self addConstraints:bgImgViewH];
    //背景视图的垂直约束
    NSArray *bgImgViewV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_bgImgView(==height)]" options:0 metrics:@{@"height":@(messageSize.height+20)} views:@{@"_bgImgView":_bgImgView}];
    [self addConstraints:bgImgViewV];
    
    //lable的水平约束
    NSArray *labelH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_messageLabel(==width)]" options:0 metrics:@{@"width":@(messageSize.width)} views:@{@"_messageLabel":_messageLabel}];
    [self.bgImgView addConstraints:labelH];
    //lable的垂直约束
    NSArray *labelV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_messageLabel(==height)]" options:0 metrics:@{@"height":@(messageSize.height)} views:@{@"_messageLabel":_messageLabel}];
    [self.bgImgView addConstraints:labelV];
    
    self.messageLabel.text=self.message;
}
//计算文本范围
-(CGSize)getMessageFram:(NSString *)messageText messageWidth:(float)width{
    CGSize messageSize=[messageText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
    return messageSize;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
