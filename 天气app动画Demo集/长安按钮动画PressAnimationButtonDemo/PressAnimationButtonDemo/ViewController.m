//
//  ViewController.m
//  PressAnimationButtonDemo
//
//  Created by tianNanYiHao on 2017/7/11.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "PressAnimationButton.h"


#define  Width   [UIScreen mainScreen].bounds.size.width
#define  Height  [UIScreen mainScreen].bounds.size.height

#define  LATO_LIGHT     @"Lato-Light"

@interface ViewController ()<PressAnimationButtonDelegate>
@property (nonatomic, strong) PressAnimationButton           *pressButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pressButton = [[PressAnimationButton alloc] initWithFrame:CGRectMake(0, 100, Width, 100)];
    // 长按按钮
    self.pressButton = [[PressAnimationButton alloc] initWithFrame:CGRectMake(0, 0, Width - 30, 48)];
    [self.view addSubview:self.pressButton];
    self.pressButton.font               = [UIFont fontWithName:LATO_LIGHT size:20.f];
    self.pressButton.layer.borderColor  = [UIColor blackColor].CGColor;
    self.pressButton.normalTextColor    = [UIColor blackColor];
    self.pressButton.highlightTextColor = [UIColor whiteColor];
    self.pressButton.layer.borderWidth  = 0.5f;
    self.pressButton.animationColor     = [UIColor blackColor];
    self.pressButton.animationWidth     = Width - 110;
    self.pressButton.text               = @"Long Press To Update";
    self.pressButton.center             = self.view.center;
//    self.pressButton.y                  = self.height - 60;
    self.pressButton.delegate           = self;
    
//    self.pressButtonStoreValue           = [FailedLongPressViewStoreValue new];
//    self.pressButtonStoreValue.midRect   = self.pressButton.frame;
//    self.pressButton.y                  -= 20;
//    self.pressButtonStoreValue.startRect = self.pressButton.frame;
//    self.pressButton.y                  += 25;
//    self.pressButtonStoreValue.endRect   = self.pressButton.frame;
//    self.pressButton.frame               = self.pressButtonStoreValue.startRect;
//    self.pressButton.alpha               = 0.f;
//    [self.view addSubview:pressView];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
