//
//  ViewController.m
//  SDWaveAnimationView
//
//  Created by tianNanYiHao on 2017/8/25.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "SDWaveViwe.h"
@interface ViewController ()
{
    SDWaveViwe *wave;
}
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:177/255.f green:232/255.f blue:199/255.f alpha:1.f];

    
    
    
}
- (IBAction)value:(UISlider*)sender {
    
}

- (IBAction)one:(id)sender {
    wave = [[SDWaveViwe alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-80)];
    wave.scaleRang = 1/3.f;
    wave.waveSpeed = 2;
    [self.view addSubview:wave];
}
- (IBAction)two:(id)sender {
     wave.scaleRang = 2/3.f;
    wave.waveSpeed = 2;
}
- (IBAction)three:(id)sender {
     wave.scaleRang = 3/3.f;
    wave.waveSpeed = 2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
