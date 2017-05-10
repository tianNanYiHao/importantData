//
//  ViewController.m
//  imageTobase64Demo
//
//  Created by tianNanYiHao on 2017/5/3.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "Base64Util.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
}
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (IBAction)getImageFromSystem:(UIButton *)sender {
    
     [self getImageFromIpc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 64, 64, 64)];
    [self.view addSubview:self.imageView];
    
    
   
    
}


- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    //设置上下文画板的尺寸 (大于或小于均会让图片显示不全或者超过)
    UIGraphicsBeginImageContext(CGSizeMake(64, 64));
    CGRect thumbnailRect = CGRectZero;
    
    //设置图片在上下文画板上的尺寸(64*64像素)
    thumbnailRect.size.width = 64;
    thumbnailRect.size.height = 64;
    
    [image drawInRect:thumbnailRect];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    

    self.imageView.image = newImage;
    
    //后端要求, 图片像素64*64  大小小于4K
    
    NSData *data = UIImageJPEGRepresentation(newImage, 0.6f);
    NSLog(@"%@",data);
    NSLog(@"%lu",data.length);
    
    
    NSString *kind =  [ViewController typeForImageData:data];
    NSLog(@"%@",kind);
    
    NSString *dataBase64Str = [Base64Util base64EncodedStringFrom:data];
    NSLog(@"%@",dataBase64Str);
    
    NSData *dataBase64 = [dataBase64Str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%lu",(unsigned long)dataBase64.length);
    
    
    
}







//判断图片的格式

+ (NSString *)typeForImageData:(NSData *)data {
    
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"image/jpeg";
            
        case 0x89:
            
            return @"image/png";
            
        case 0x47:
            
            return @"image/gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"image/tiff";
            
    }
    
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
