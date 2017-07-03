//
//  ShowMessageViewController.m
//  MQTTSDKLearn
//
//  Created by Vie on 2017/3/6.
//  Copyright © 2017年 Vie. All rights reserved.
//

#import "ShowMessageViewController.h"
#import "MQTTClientManager.h"
#import "MQTTClientManagerDelegate.h"
#import "ShowMessageTableViewCell.h"

@interface ShowMessageViewController ()<UITableViewDelegate,UITableViewDataSource,MQTTClientManagerDelegate>
@property (nonatomic,strong) UITableView *tableView;//展示后台推送数据的tableview
@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation ShowMessageViewController
#pragma mark 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] init];
        _tableView.translatesAutoresizingMaskIntoConstraints=false;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
-(NSMutableArray *)array{
    if (!_array) {
        _array=[[NSMutableArray alloc] init];
    }
    return _array;
}
#pragma mark loading
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    

    
    [self.view addSubview:self.tableView];
    [self layoutVFL];
    
    //监听横竖屏幕切换
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}


//屏幕横竖切换重新加载页面以便适应屏幕
-(void)detectOrientation
{
//    UIDevice *device = [UIDevice currentDevice];
//    switch (device.orientation) {
//        case UIDeviceOrientationFaceUp:
//            NSLog(@"朝上平躺");
//            break;
//        case UIDeviceOrientationFaceDown:
//            NSLog(@"朝下平躺");
//            break;
//        case UIDeviceOrientationUnknown:
//            NSLog(@"未知方向");
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//        case UIDeviceOrientationLandscapeRight:
//            NSLog(@"---------左或者右橫置");
//
//            break;
//        case UIDeviceOrientationPortrait:
//        case UIDeviceOrientationPortraitUpsideDown:
//            NSLog(@"--------竖屏");
//
//            break;
//        default:
//            NSLog(@"未知");
//            break;
//    }
    [self.tableView reloadData];
}
-(void)layoutVFL{
    //tableview水平约束
    NSArray *tableViewH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}];
    [self.view addConstraints:tableViewH];
    //tableview垂直约束
    NSArray *tableViewV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}];
    [self.view addConstraints:tableViewV];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MQTTClientManager shareInstance] registerDelegate:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[MQTTClientManager shareInstance] unRegisterDelegate:self];
}


#pragma mark UITableViewDelegate
//返回分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回分区单元格数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
//设置单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   //这里单元格不重用，以便横竖屏切换界面适应
    ShowMessageTableViewCell *cell=[[ShowMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell%ld",indexPath.row]];

    cell.message=[self.array objectAtIndex:indexPath.row];
    return cell;
}
//设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self getMessageFram:[self.array objectAtIndex:indexPath.row] messageWidth:[UIScreen mainScreen].bounds.size.width-90].height+34;
}
//计算文本范围
-(CGSize)getMessageFram:(NSString *)messageText messageWidth:(float)width{
    CGSize messageSize=[messageText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
    return messageSize;
    
}
#pragma mark MQTTClientManagerDelegate
-(void)didMQTTReceiveServerStatus:(MQTTStatus *)status{
    switch (status.statusCode) {
        case MQTTSessionEventConnected:
        {
            
            
        }
            break;
        default:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"登录失败" message:status.statusInfo delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
    }
    
}
-(void)messageTopic:(NSString *)topic jsonStr:(NSString *)jsonStr{
    [self.array addObject:jsonStr];
    [self.tableView reloadData];
}
@end
