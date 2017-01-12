//
//  HeadPhotoViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "HeadPhotoViewController.h"
#import "TakingIDcardPositiveViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSString+URLEncoding.h"
#import "PECropViewController.h"
#import "SimpleCam.h"
#import "GKImageCropViewController.h"
#import "GKImagePicker.h"


@interface HeadPhotoViewController ()<UIActionSheetDelegate,UIViewControllerTransitioningDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,ResponseData,GKImagePickerDelegate,GKImageCropControllerDelegate>{
    
    NSUserDefaults *userDefaults;//存取
    
    Request *requst;
    
    NSDictionary *dataDic;//请求返回字典
}
@property (weak, nonatomic) IBOutlet UIImageView *headphotoimageview;//照片容器

@property (strong,nonatomic) NSData *imagedata;//图片data

@property (strong,nonatomic) UIImage *photoimage;//照片

@property (nonatomic,strong) SimpleCam *simpleCam;//相机

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) GKImagePicker *imagePicker;

@property (nonatomic, strong) UIPopoverController *popoverController;


@end

@implementation HeadPhotoViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = L(@"UpHeadIcon");
    self.nextButton.layer.cornerRadius = 5;
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    requst = [[Request alloc]initWithDelegate:self];
    

}


//调用相机
- (IBAction)gotoPhoto:(UIButton *)sender {
    
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
    
    
    //第三方相机
    self.imagePicker = [[GKImagePicker alloc] init];
    self.imagePicker.delegate = self;
    
    self.imagePicker.imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    //    self.imagePicker.resizeableCropArea = YES;
    self.imagePicker.cropSize = CGSizeMake(200, 280);
    
    [self presentViewController:self.imagePicker.imagePickerController animated:YES completion:nil];
}

//上传
- (IBAction)goutoIDcardPositive:(UIButton *)sender {
    
    if(self.imagedata == nil){
    
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"UploadPicturesFirst")];
        
    }else{
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"Uploading")];
        [requst upPhotoImage:self.imagedata];
        
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"Uploading")];
//        
//        [hud hide:YES afterDelay:5];
//       

    }
    
    
    
}
- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    dataDic = dict;
    
    if([dataDic[@"respCode"] isEqual:@"0000"]){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        TakingIDcardPositiveViewController *IDcardPositiveVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IDcardPositiveVC"];
        
        [self.navigationController pushViewController:IDcardPositiveVC animated:YES];
        
    }else{
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:dataDic[@"respDesc"]];
        
    }

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
        
        self.headphotoimageview.image = image;
        
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

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
//
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
//}


@end
