//
//  FoodQueryViewController.m
//  QuickPos
//
//  Created by caiyi on 16/1/4.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "FoodQueryViewController.h"
#import "NudgedViewController.h"
#import "SweepViewController.h"
#import "EnterViewController.h"
#import "ForHelpViewController.h"




#import "Common.h"



@interface FoodQueryViewController ()<UIWebViewDelegate>
{

    
    UIWebView *QRCodeView;
    
    
    
    
}

@property (weak, nonatomic) IBOutlet UIButton *NudgedButton;//碰一碰
@property (weak, nonatomic) IBOutlet UIButton *SweepButton;//扫一扫
@property (weak, nonatomic) IBOutlet UIButton *LoseButton;//输一输
@property (weak, nonatomic) IBOutlet UIButton *helpButton;//帮助

@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;//


@property (nonatomic,strong) NSString *scanType;
@property (nonatomic,strong) NSString *UrlStr1;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr2;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr3;//拼接条形码网址所用的
@property (nonatomic,strong) NSString *UrlStr4;//拼接条形码网址所用的




@end

@implementation FoodQueryViewController
@synthesize item;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = L(@"Securityverification");

    self.view.backgroundColor = [UIColor whiteColor];


   
}


- (IBAction)NudgedButton:(id)sender {
    
//    self.scanImageView.hidden = YES;
    NSLog(@"2000 2000 2000");
    NudgedViewController *nudgedVC = [[NudgedViewController alloc]init];
    [self.navigationController pushViewController:nudgedVC animated:YES];
}

- (IBAction)SweepButton:(id)sender {
    
    
    if ([self validateCamera]) {

    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查摄像头" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ture = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:ture];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


- (BOOL)validateCamera {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}






- (IBAction)EnterButton:(id)sender {
    
    EnterViewController *enterVC = [[EnterViewController alloc]init];
    [self.navigationController pushViewController:enterVC animated:YES];
     NSLog(@"2002 2002 2002");
}

- (IBAction)HelpButton:(id)sender {
    
    ForHelpViewController *forHelpVC = [[ForHelpViewController alloc]init];
    [self.navigationController pushViewController:forHelpVC animated:YES];
    NSLog(@"2003 2003 2003");

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
