//
//  ViewController.m
//  passwdRegular
//
//  Created by tianNanYiHao on 2017/5/23.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+CheckLenght.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
    
    BOOL a = [UITextField passWdTooSimple:_textfiled.text];
    if (a == NO) {
        NSLog(@"xxxxxxx");
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
