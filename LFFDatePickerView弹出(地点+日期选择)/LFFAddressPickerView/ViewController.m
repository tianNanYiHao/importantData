//
//  ViewController.m
//  LFFAddressPickerView
//
//  Created by Lff on 16/10/19.
//  Copyright © 2016年 Lff. All rights reserved.
//

#import "ViewController.h"
#import "LFFAddPickerView.h"
#import "TrickAddressModel.h"
#import "LFFPickerVIew.h"


@interface ViewController ()<LFFAddPickerViewDelegate,LFFPickerViewDelegate>
{
     LFFPickerVIew        *addDatePickerView;
    LFFAddPickerView *addPickerView;
    NSArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataArray = [NSArray array];
     TrickInfoModel *model = [[TrickInfoModel alloc] init];
    _dataArray = [model getInfoBack];
    
    
    addPickerView = [LFFAddPickerView awakeFromXib];
    addPickerView.delegate = self;
    addPickerView.infoArray =  _dataArray;
    addPickerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:addPickerView];
    addPickerView.alpha = 0;
    
    addDatePickerView = [LFFPickerVIew awakeFromXib];
    addDatePickerView.delegate = self;
    addDatePickerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:addDatePickerView];
    addDatePickerView.alpha = 0;
    _btn3.titleLabel.text = [addDatePickerView formatterDate:[NSDate date]];
    
    
}

- (IBAction)btn1:(id)sender {
    addPickerView.fromeAddress = @"1";
    [UIView animateWithDuration:0.3 animations:^{
        addPickerView.alpha = 1;
    }];

}

- (IBAction)btn:(id)sender {
    addPickerView.toAddress = @"2";
    [UIView animateWithDuration:0.3 animations:^{
        addPickerView.alpha = 1;
    }];
}
- (IBAction)chooseDate:(id)sender {
    addDatePickerView.Timetype = 1;
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 1;
    }];

}

#pragma  mark - LFFAddPickerViewDelegate
-(void)hiddenLFFAddPickerView{
    [UIView animateWithDuration:0.2 animations:^{
        addPickerView.alpha = 0;
    }];
}

-(void)returnFromeLFFAddPickerInfo:(NSArray *)arr{
    _btn1.titleLabel.text = arr[0];
//    _btn1.titleLabel.text = arr[1];
    
}
-(void)returnToLFFAddPickerInfo:(NSArray *)arr{
    _btn2.titleLabel.text = arr[0];
//    _btn2.titleLabel.text = arr[1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lffpickerviewdelegate
-(void)changeAlphaHiden{
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 0;
    }];
}
-(void)changeAlphaHiden:(NSString *)dateStr{
    if (addDatePickerView.Timetype ==1) {

            _btn3.titleLabel.text = dateStr;
        
    }
    [UIView animateWithDuration:0.2 animations:^{
        addDatePickerView.alpha = 0;
    }];
}



@end
