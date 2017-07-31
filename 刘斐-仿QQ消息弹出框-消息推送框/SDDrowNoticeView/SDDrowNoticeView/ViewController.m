//
//  ViewController.m
//  SDDrowNoticeView
//
//  Created by tianNanYiHao on 2017/7/28.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDDrowNoticeView.h"

@interface ViewController ()
{
    SDDrowNoticeView *v;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
}

- (IBAction)stateChange:(UISwitch *)sender {
    
    if (sender.on) {
        v = [SDDrowNoticeView createDrowNoticeView:@[@"消息标题",@"消息内容-消息内容"]];
        [self.view addSubview:v];
        [v animationDrown];
    }else if (!sender.on){
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
