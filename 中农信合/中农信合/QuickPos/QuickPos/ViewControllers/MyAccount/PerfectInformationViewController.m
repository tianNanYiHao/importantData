//
//  PerfectInformationViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "HeadPhotoViewController.h"




@interface PerfectInformationViewController ()<ResponseData>{
    
    UIImage * photoimage;
    NSString * fileName;
    NSUserDefaults *userDefaults;//储存
    NSDictionary *dataDic;//请求返回字典
    Request *requst;
    MBProgressHUD * hud;
}

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;//姓名输入框

@property (weak, nonatomic) IBOutlet UITextField *IdTextField;//身份证输入框
@property (weak, nonatomic) IBOutlet UIButton *comfirtButton;

@end

@implementation PerfectInformationViewController

@synthesize IDstr;
@synthesize realNameStr;

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    self.comfirtButton.layer.cornerRadius = 5;
    //self.title = L(@"InputName");
    

    
    self.navigationController.navigationBarHidden = NO;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([self.authenFlag isEqualToString:@"0"]) {
            self.accountTextField.text = @"";
            self.IdTextField.text = @"";
    }else{
        self.accountTextField.text = realNameStr;
        
        self.IdTextField.text = IDstr;
    }
    requst = [[Request alloc]initWithDelegate:self];
    
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    self.accountTextField.text = @"";
//    self.IdTextField.text = @"";
//}
////- (void)viewDidAppear:(BOOL)animated{
////    self.accountTextField.text = @"";
////    self.IdTextField.text = @"";
////}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    self.accountTextField.text = @"";
//    self.IdTextField.text = @"";
//}


- (IBAction)TakingPictures:(UIButton *)sender {
    
  
    if([self.accountTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputName")];
        
    }else if ([self.IdTextField.text isEqual:@""]){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputID")];
        
    }else if (self.IdTextField.text.length > 18){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectID")];
        
    }else if (self.IdTextField.text.length < 15){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectID")];
        
    }else if (self.IdTextField.text.length == 17 || self.IdTextField.text.length == 16){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectID")];
        
    }else{
        
        [self.IdTextField resignFirstResponder];
        [requst realNameAuthentication:self.accountTextField.text ID:self.IdTextField.text];
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
        
    }

 
    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [hud hide:YES];
    dataDic = dict;
    
    if([dataDic[@"respCode"] isEqual:@"0000"]){
        
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        HeadPhotoViewController *headviewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"touxiangVC"];
        
        [self.navigationController pushViewController:headviewVC animated:YES];
        
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:dataDic[@"respDesc"]];
        
    }

    
    
    
    
    

}


@end
