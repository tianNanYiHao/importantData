//
//  ViewController.m
//  popviewtest
//
//  Created by tianNanYiHao on 2017/5/12.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDPopview.h"

@interface ViewController ()<SDPopviewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

    
    
    
    
    
}
- (IBAction)click:(UIButton*)sender {
    
    #pragma mark - 1 使用自带tableview模式
    NSArray *arr = @[@{@"name":@"111",@"icon":@"icon_badminton"},
                     @{@"name":@"222",@"icon":@"icon_badminton"},
                     @{@"name":@"333",@"icon":@"icon_badminton"},
                     @{@"name":@"444",@"icon":@"icon_badminton"}
                     ];
    SDPopViewConfig *config  = [[SDPopViewConfig alloc] init];
    config.triAngelWidth = 8;
    config.triAngelHeight = 10;
    config.containerViewCornerRadius = 5;
    config.roundMargin = 4;
    config.layerBackGroundColor = [UIColor blueColor];
    config.defaultRowHeight = 44;
    config.tableBackgroundColor = [UIColor whiteColor];
    config.separatorColor = [UIColor blackColor];
    config.textColor = [UIColor blackColor];
    config.textAlignment = NSTextAlignmentLeft;
    config.font = [UIFont systemFontOfSize:14];
    config.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    SDPopview *v = [[SDPopview alloc] initWithBounds:CGRectMake(100, 100, 120, config.defaultRowHeight*arr.count) titleInfo:arr config:config];
    v.delegate = self;
    [v showFrom:_btn alignStyle:SDPopViewStyleCenter];
    
    
    
    
    
    
    #pragma mark - 2 使用自定容器view模式
    SDPopview *v2 = [[SDPopview alloc] popViewWihtconfig:config];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    view.layer.cornerRadius = 50;
    view.frame = CGRectMake(0, 0, 100, 100);
    view.layer.masksToBounds = YES;
    v2.contentView = view;
//    [v2 showFrom:_btn alignStyle:SDPopViewStyleLeft];
    
    
    
    
    
    
    #pragma mark - 3 使用自定容器viewcontroller模式
    SDPopview *v3 = [[SDPopview alloc] popViewWihtconfig:config];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    vc.view.frame = CGRectMake(0, 0, 100, 100);
    v3.contentViewController = vc;
//    [v3 showFrom:_btn alignStyle:SDPopViewStyleRight];
    
    
}


- (void)popOverView:(SDPopview *)pView didClickMenuIndex:(NSInteger)index{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"index is %d", (int)index] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
