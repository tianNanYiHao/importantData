//
//  TakingIDcardReverseViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "TakingIDcardReverseViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PECropViewController.h"
#import "SimpleCam.h"
#import "GKImageCropViewController.h"
#import "GKImagePicker.h"

@interface TakingIDcardReverseViewController ()<UIActionSheetDelegate,UIViewControllerTransitioningDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,ResponseData,SimpleCamDelegate>{
    
    NSDictionary *dataDic;//请求返回字典
    
    NSUserDefaults *userDefaults;//存取
    
    Request *requst;
    
}

@property (strong,nonatomic) NSData *imagedata;//图片data

@property (strong,nonatomic) UIImage *photoimage;//照片

@property (nonatomic,strong) SimpleCam *simpleCam;//相机

@property (weak, nonatomic) IBOutlet UIImageView *IDcardReverseImageView;//照片容器

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) UILabel *titlenew;

@property (nonatomic, strong) GKImagePicker *imagePicker;

@property (nonatomic, strong) UIPopoverController *popoverController;


@end

@implementation TakingIDcardReverseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titlenew = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    self.titlenew.textColor = [UIColor whiteColor];
    self.titlenew.text = L(@"UploadIdOpposite");
    self.titlenew.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.navigationBar addSubview:self.titlenew];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.titlenew removeFromSuperview];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.title = L(@"UploadIdOpposite");//不知道为什么会偏离了中心的位置
 
    self.nextButton.layer.cornerRadius = 5;
    dataDic = [NSDictionary dictionary];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    requst = [[Request alloc]initWithDelegate:self];
    
}

//上传
- (IBAction)finish:(UIButton *)sender {
   
    if(self.imagedata == nil){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"UploadPicturesFirst")];
        
    }else{
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"Uploading")];
        [requst upIDcardReverse:self.imagedata];
        
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"Uploading")];
//        
//        [hud hide:YES afterDelay:5];

        
}
    
}
- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    dataDic = dict;
   
    if([dataDic[@"respCode"]isEqual:@"0000"]){
        
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//          //清空认证用的userdeafults
//          NSUserDefaults *userdeafults = [NSUserDefaults standardUserDefaults];
//          [userdeafults setObject:@"" forKey:@"certificationName"];
//          [userdeafults setObject:@"" forKey:@"certificationUserID"];
//          [userdeafults setObject:@"" forKey:@"headerImage"];
//          [userdeafults setObject:@"" forKey:@"IDcardPositiveImage"];
//          [userdeafults setObject:@"" forKey:@"IDcardReverseImage"];
//          [userdeafults synchronize];
        
          [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
            
          [MBProgressHUD showHUDAddedTo:self.view WithString:dataDic[@"respDesc"]];
            
            
        }
    

}
//调用相机
- (IBAction)gotoIDcardReversePhoto:(UIButton *)sender {
    
    //检查是否有权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机权限未开启?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    self.imagePicker = [[GKImagePicker alloc] init];
    self.imagePicker.delegate = self;
    
    self.imagePicker.imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    //    self.imagePicker.resizeableCropArea = YES;
    self.imagePicker.cropSize = CGSizeMake(280, 200);
    
    [self presentViewController:self.imagePicker.imagePickerController animated:YES completion:nil];
}

#pragma mark TAP RECOGNIZER

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"SimpleCam Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Default", @"Take Photo Immediately", @"Custom", nil];
    [sheet showInView:self.view];
    
}

# pragma mark GKImagePicker Delegate Methods

- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image{
    if (image) {
        
        self.photoimage = image;
        
        self.imagedata = UIImageJPEGRepresentation(image, 0.01);
        
        self.IDcardReverseImageView.image = image;
        
        [userDefaults setObject:self.imagedata forKey:@"headerImage"];
        
        //为了解决whose view is not in the window hierarchy! 问题
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(hideImagePicker) userInfo:nil repeats:NO];
    }else{
        
    }
    [self hideImagePicker];
}

- (void)hideImagePicker{
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        
        [self.popoverController dismissPopoverAnimated:YES];
        
    } else {
        
        [self.imagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
        
    }
}


# pragma mark UIImagePickerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
//    self.photoimage = image;
//    
//    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
//        
//        [self.popoverController dismissPopoverAnimated:YES];
//        
//    } else {
//        
//        [picker dismissViewControllerAnimated:YES completion:nil];
//        
//    }
}


@end
