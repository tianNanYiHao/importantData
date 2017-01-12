//
//  VersionView.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/19.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "VersionView.h"
#import "Common.h"

@interface VersionView(){

}
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *cRight;//版权
@property (weak, nonatomic) IBOutlet UIView *backview;

@end

@implementation VersionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        self  = [[[NSBundle mainBundle] loadNibNamed:@"VersionView" owner:self options:nil] objectAtIndex:0];
//        self.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5];
        self.backview.center = self.center;
        self.backview.layer.masksToBounds = YES;
        self.backview.layer.cornerRadius = 8;
         self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        if (!self.parentCtrl) {
            self.parentCtrl = [[UIViewController alloc]init];
        }
        
    }
    return self;
}

- (void)awakeFromNib{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.icon.image = [UIImage imageNamed:@"icon"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSMutableString *app_Name = [[NSMutableString alloc]initWithString:[infoDictionary objectForKey:@"CFBundleDisplayName"]];
    self.appName.text = app_Name;
    [self.version setText:[Common getCurrentVersion]];
//    self.version.text = [[delegate getConfigDic] objectForKey:@"client_version"];
    self.cRight.text = [[delegate getConfigDic] objectForKey:@"shortCompary"];
}

- (IBAction)close:(UIButton *)sender {
    [self.superCtrl dismissViewControllerAnimated:NO completion:^{
    }];
}


+ (void)showVersionView:(id)ctrl{

    VersionView *v = [[VersionView alloc]init];
    [v.parentCtrl.view addSubview:v];
    v.superCtrl = (UIViewController*)ctrl;
    v.originFrame = v.superCtrl.view.frame;
    v.parentCtrl.view.window.windowLevel = UIWindowLevelAlert;
    [(UIViewController*)ctrl presentViewController:v.parentCtrl animated:NO completion:nil];

}

@end
