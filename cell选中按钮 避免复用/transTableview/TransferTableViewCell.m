//
//  TransferTableViewCell.m
//  transTableview
//
//  Created by tianNanYiHao on 2017/3/27.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "TransferTableViewCell.h"
#import "TransferPayToolSelMode.h"

#define payToolTitleColor [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1]
#define describeColor [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1]

@interface TransferTableViewCell(){
    
    CGFloat leftSpace;
    CGFloat topSpace;
    CGFloat titleSize;
    CGFloat describeSize;
    CGFloat lineH ;
    CGFloat commitW;
    CGFloat spaceToHeadImageView;

    //UI
    UIImageView *headImageVIew;
    UILabel *payToolTitleLab;
    UILabel *describtLab;
    UIButton *btnner;
    
    UIImageView *leftImageView;
    
    
    
}@end


@implementation TransferTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableview:(UITableView*)tableView{
    static NSString*str = @"str";
    // 缓存中取
    TransferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    //创建
    if (!cell) {
        cell = [[TransferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        topSpace = 20;
        leftSpace = 15;
        titleSize = 13;
        describeSize = 11;
        lineH = 1;
        spaceToHeadImageView = 22.5;
        commitW = [UIScreen mainScreen].bounds.size.width - 2*leftSpace;
        
        [self createUI];
    }
    return self;
}



-(void)createUI{
    
    //icon
    UIImage *headImageOther = [UIImage imageNamed:@"select_account_otherphoto"];
    headImageVIew = [[UIImageView alloc] initWithImage:headImageOther];
    headImageVIew.layer.masksToBounds = YES;
    headImageVIew.layer.cornerRadius = headImageOther.size.height/2;
    [self.contentView addSubview:headImageVIew];
    
    
    //payToolTitle
    payToolTitleLab = [[UILabel alloc] init];
    payToolTitleLab.textColor = payToolTitleColor;
    payToolTitleLab.font = [UIFont systemFontOfSize:titleSize];
    [self.contentView addSubview:payToolTitleLab];
    
    
    //describtLab
    describtLab = [[UILabel alloc] init];
    describtLab.textColor = describeColor;
    describtLab.font = [UIFont systemFontOfSize:describeSize];
    [self.contentView addSubview:describtLab];
    
    //leftImage
    UIImage *leftImage = [UIImage imageNamed:@"select_account_default"];
    leftImageView = [[UIImageView alloc] initWithImage:leftImage];
    [self.contentView addSubview:leftImageView];
    
    //coverBtn
    btnner = [[UIButton alloc] init];
    [btnner addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
    [btnner setImage:nil forState:UIControlStateNormal];
    [self.contentView addSubview:btnner];
    
    
    
    //设置frame
    CGFloat labW = commitW - spaceToHeadImageView - headImageOther.size.width - leftImage.size.width;
    headImageVIew.frame = CGRectMake(leftSpace, topSpace, headImageOther.size.width, headImageOther.size.height);
    payToolTitleLab.frame = CGRectMake(headImageOther.size.width+spaceToHeadImageView, topSpace, labW, topSpace);
    describtLab.frame = CGRectMake(headImageOther.size.width+spaceToHeadImageView, CGRectGetMaxY(payToolTitleLab.frame)+topSpace/4, labW, topSpace);
    leftImageView.frame = CGRectMake(CGRectGetMaxX(payToolTitleLab.frame), 36, leftImage.size.width, leftImage.size.height);
    btnner.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*2);
    
    
    
}

#pragma clickBtn
-(void)clickSelect:(UIButton*)btn{
    
    if ([_delegate respondsToSelector:@selector(showRightImageView:)]) {
        [_delegate showRightImageView:btn];
    }
    
}



#pragma mark -setter

-(void)setModel:(TransferPayToolSelMode *)model{
    _model = model;
    btnner.tag = model.index;
    payToolTitleLab.text = model.payToolTitle;
}

-(void)setSelectArr:(NSMutableArray *)selectArr{
    _selectArr = selectArr;
    
    if (_selectArr.count == 0) {
        leftImageView.hidden = YES;
        btnner.userInteractionEnabled = YES;
    }
    for (int i = 0; i<_selectArr.count; i++) {
        if (btnner.tag == [_selectArr[i] integerValue]) {
            leftImageView.hidden = NO;
            btnner.userInteractionEnabled = YES;
        }else{
            leftImageView.hidden = YES;
            btnner.userInteractionEnabled = NO;
        }
    }
    
}


@end
