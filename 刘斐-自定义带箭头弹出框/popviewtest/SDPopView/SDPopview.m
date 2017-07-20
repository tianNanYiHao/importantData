//
//  layerview.m
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "SDPopview.h"
#import "SDPopContainerViwe.h"
@interface SDPopview()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (nonatomic, strong) SDPopViewConfig *config; //配置类实例
@property (nonatomic, strong) SDPopContainerViwe *containerView; //容器类实例

@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *titleInfoes;

@property (nonatomic,   weak) UIView *showFrom;




@end

@implementation SDPopview

#pragma mark- 懒加载 容器(带三角弹出框容器)
- (SDPopContainerViwe *)containerView
{
    if (nil == _containerView) {
        _containerView = [[SDPopContainerViwe alloc] initWithConfig:_config];
        [self addSubview:_containerView];
    }
    
    return _containerView;
}

- (UITableView *)table
{
    if (nil == _table) {
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.backgroundColor = _config.tableBackgroundColor;
        _table.separatorColor = _config.separatorColor;
        _table.rowHeight = _config.defaultRowHeight;
        _table.separatorStyle = _config.separatorStyle;
        _table.tableFooterView = [UIView new];
    }
    return _table;
}

#pragma mark - 初始化(自定义containerview)
/**
 初始化弹出框(自定义containerView)
 
 @param config 配置信息可为nil
 @return SDPopview弹出框实例
 */
- (instancetype)popViewWihtconfig:(SDPopViewConfig*)config{
    
    if (self == [super init]) {
        if (!config) {
            [self initDefaultConfig];
        }else
        {
            _config = config;
        }
    }return self;

}

- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    [self setContent:_contentView];
}
- (void)setContentViewController:(UIViewController *)contentViewController{
    _contentViewController = contentViewController;
    [self setContent:_contentViewController.view];
}



#pragma mark - 初始化(默认container为tableview)
/**
 初始化弹出框
 
 @param bounds 尺寸
 @param infoes 字典数组集
 @param config 弹出框配置信息
 @return SDPopview弹出框实例
 */
- (instancetype)initWithBounds:(CGRect)bounds titleInfo:(NSArray*)infoes config:(SDPopViewConfig *)config{
    
    self = [super initWithFrame:bounds];
    if (self) {
        
        //1.配置信息
        if (!config) {
            [self initDefaultConfig];
        }else
        {
            _config = config;
        }
        
        //2.配置tableview信息
        self.titleInfoes = infoes;
        self.table.frame = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds));
        self.table.delegate = self;
        self.table.dataSource = self;
        _table.scrollEnabled = NO;
        if ([_table respondsToSelector:@selector(setSeparatorInset:)]) {
            //让线头不留白
            [_table setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([_table respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_table setLayoutMargins:UIEdgeInsetsZero];
            
        }

        //添加tableview到容器中去
        [self setContent:self.table];
    }
    return self;

    
}
//设置默认配置
- (void)initDefaultConfig
{
    _config = [SDPopViewConfig new];
    _config.triAngelHeight = 8.0;
    _config.triAngelWidth = 10.0;
    _config.containerViewCornerRadius = 5.0;
    _config.roundMargin = 5.0;
    _config.layerBackGroundColor = [UIColor greenColor];
    
    // 普通用法
    _config.defaultRowHeight = 44.0f;
    _config.tableBackgroundColor = [UIColor whiteColor];
    _config.separatorColor = [UIColor blackColor];
    _config.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _config.textColor = [UIColor blackColor];
    _config.font = [UIFont systemFontOfSize:14.0];
}


//容器添加table视图
- (void)setContent:(UIView *)content
{
    _content = content;
    
    CGRect contentFrame = content.frame;
    
    contentFrame.origin.x = _config.roundMargin;
    contentFrame.origin.y = _config.triAngelHeight + _config.roundMargin;
    content.frame = contentFrame;
    
    CGRect  temp = self.containerView.frame;
    temp.size.width = CGRectGetMaxX(contentFrame) + _config.roundMargin; // left and right space
    temp.size.height = CGRectGetMaxY(contentFrame) + _config.roundMargin;
    
    self.containerView.frame = temp;
    
    [self.containerView addSubview:content];
    
    
}





#pragma mark - Pop弹出方法
/**
 弹框弹出
 
 @param from 三角指向的view
 @param style 三角样式
 */
- (void)showFrom:(UIView *)from alignStyle:(SDPopViewStyle)style
{
    _showFrom = from;
    _style = style;
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 更新控件frame
    [self updateSubViewFrames];
    

}


//更新父控件Frame
- (void)updateSubViewFrames
{
    //1.设置SDPopview的frame为全屏
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    
    
    if (!_showFrom) {
        
        self.containerView.center = self.center;
        return;
    }
//    将_showFrom由_showFrom所在视图转换到目标视图window中，返回在目标视图window中的_showFrom.frame
    CGRect newFrame = [_showFrom convertRect:_showFrom.bounds toView:window];
    
    
    //2. 改变 containerView 的尺寸 (将会触发KVO重绘Layer)
    CGRect containerViewFrame = self.containerView.frame;
    containerViewFrame.origin.y =  CGRectGetMaxY(newFrame) + 5;
    self.containerView.frame = containerViewFrame;
    
    
    //3.计算容器(SDPopContainerView)和self(SDPopview) 和依赖的frmoView(_showFrom)之间的位置关系
    switch (_style) {
        case SDPopViewStyleCenter:
        {
            CGPoint center = self.containerView.center;
            center.x = CGRectGetMidX(newFrame);
            self.containerView.center = center;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(self.containerView.frame)/2;
        }
            break;
        case SDPopViewStyleLeft:
        {
            CGRect frame = self.containerView.frame;
            frame.origin.x = CGRectGetMinX(newFrame);
            self.containerView.frame = frame;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(_showFrom.frame)/2;
        }
            
            break;
        case SDPopViewStyleRight:
        {
            CGRect frame = self.containerView.frame;
            frame.origin.x = CGRectGetMinX(newFrame) - (fabs(frame.size.width - newFrame.size.width));
            self.containerView.frame = frame;
            
            self.containerView.apexOftriangelX = CGRectGetWidth(self.containerView.frame) - CGRectGetWidth(_showFrom.frame)/2;
        }
            
            break;
            
        default:
            break;
    }
    
}





#pragma mark- <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleInfoes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"GYPopOverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    NSString *text;
    NSString *icon;

    if (self.titleInfoes.count) {
        NSDictionary *dic = self.titleInfoes[indexPath.row];
        text = dic[@"name"];
        icon = dic[@"icon"];
    }
    
    cell.textLabel.text = text;
    cell.textLabel.textColor = _config.textColor;
    cell.textLabel.font = _config.font;
    cell.textLabel.textAlignment = _config.textAlignment;
    if (icon != nil) {
        cell.imageView.image = [UIImage imageNamed:icon];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(popOverView:didClickMenuIndex:)]) {
        [_delegate popOverView:self didClickMenuIndex:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


#pragma mark- 消失处理
//1.触摸则消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
//2
- (void)dismiss
{
    
    // animations support
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.transform = CGAffineTransformMakeScale(0.9,0.9);
        self.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        self.containerView.hidden = YES;
        [self removeFromSuperview];
    }];
    
}
//3.释放
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    NSLog(@"%s", __func__);
}


@end
