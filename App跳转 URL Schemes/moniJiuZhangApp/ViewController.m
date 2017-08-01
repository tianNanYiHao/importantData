//
//  ViewController.m
//  moniJiuZhangApp
//
//  Created by tianNanYiHao on 2017/7/10.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tnlab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"这就当做是久璋App吧🙃";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tnlab.text = @"198077812017071944000010";
    
    
}
- (IBAction)jumpBtn:(id)sender {

    
    
    
    BViewController *v = [[BViewController alloc] init];
    v.tn = [NSString stringWithFormat:@"%@",_tnlab.text];
    
    [self.navigationController pushViewController:v animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
