//
//  PresetnViewController.m
//  PoppingDemo
//
//  Created by tianNanYiHao on 2017/8/4.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "PresetnViewController.h"

@interface PresetnViewController ()

@end

@implementation PresetnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor cyanColor];
    self.view.layer.cornerRadius = 8.f;
    
    UIButton *b = [[UIButton alloc] init];
    b.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    [b setBackgroundColor:[UIColor greenColor]];
    [b setTitle:@"-=-=-=-=-=-=-=" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpOutside];
    


//    [self.view addSubview:b];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)touch{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
