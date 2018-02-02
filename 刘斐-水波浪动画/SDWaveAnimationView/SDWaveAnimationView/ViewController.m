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
    
    self.view.backgroundColor = [UIColor colorWithRed:0/255.f green:232/255.f blue:199/255.f alpha:1.f];

    
    
    
}
- (IBAction)value:(UISlider*)sender {
    
}

- (IBAction)one:(id)sender {
    wave = [[SDWaveViwe alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-80)];
    //水波上涨 - 最终刻度
    wave.waveUpRang = 1/5.f;
    //水波上涨 - 上涨速度
    wave.waveUpSpeed = 0.5f;
    //水波波动 - 波动振幅
    wave.waveChangA = 8;
    //水波波动- 波动速度
    wave.wavaChangeSpeed = 2.f;
    [self.view addSubview:wave];
}
- (IBAction)two:(id)sender {
    //水波上涨 - 最终刻度
    wave.waveUpRang = 3/5.f;
    //水波上涨 - 上涨速度
    wave.waveUpSpeed = 0.5f;
    //水波波动 - 波动振幅
    wave.waveChangA = 8;
    //水波波动- 波动速度
    wave.wavaChangeSpeed = 2.f;

}
- (IBAction)three:(id)sender {
    //水波上涨 - 最终刻度
    wave.waveUpRang = 4/5.f;
    //水波上涨 - 上涨速度
    wave.waveUpSpeed = 0.5f;
    //水波波动 - 波动振幅
    wave.waveChangA = 8;
    //水波波动- 波动速度
    wave.wavaChangeSpeed = 2.f;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
