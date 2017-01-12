//
//  ClearUpView.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/14.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "ClearUpView.h"
#import "Common.h"

@interface ClearUpView (){

}

@property (weak, nonatomic) IBOutlet UIView *backview;
@property (nonatomic,strong)UIViewController *parentCtrl;

@end

@implementation ClearUpView

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
        self  = [[[NSBundle mainBundle] loadNibNamed:@"ClearUpView" owner:self options:nil] objectAtIndex:0];
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


- (IBAction)clearUp:(UIButton *)sender {
    dispatch_async(
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
           , ^{
               NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
               [ud removeObjectForKey:@"intro_screen_viewed"];
               [ud synchronize];
               NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
               
               NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
               NSLog(@"files :%d",[files count]);
               for (NSString *p in files) {
                   NSError *error;
                   NSString *path = [cachPath stringByAppendingPathComponent:p];
                   if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                       [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                   }
               }
               [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
}

-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
    [Common showMsgBox:nil msg:L(@"CleanComplete") parentCtrl:self.parentCtrl];
    
}

- (IBAction)closeClearUpView:(UIButton *)sender {
    
    [self.superCtrl dismissViewControllerAnimated:NO completion:^{
  
    }];

}

+ (void)showVersionView:(id)ctrl{
    
    ClearUpView *v = [[ClearUpView alloc]init];
    [v.parentCtrl.view addSubview:v];
    v.superCtrl = (UIViewController*)ctrl;
    v.originFrame = v.superCtrl.view.frame;
    v.parentCtrl.view.window.windowLevel = UIWindowLevelAlert;
    [(UIViewController*)ctrl presentViewController:v.parentCtrl animated:NO completion:nil];
    
}

@end
