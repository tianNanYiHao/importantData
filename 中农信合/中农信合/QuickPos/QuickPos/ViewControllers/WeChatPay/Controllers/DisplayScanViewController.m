//
//  DisplayScanViewController.m
//  QuickPos
//
//  Created by feng Jie on 16/7/21.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "DisplayScanViewController.h"
#import "Request.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import "Common.h"
#import "LBXScanWrapper.h"
#import "LBXAlertAction.h"
#import "UIImageView+CornerRadius.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WechatAuthSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

@interface DisplayScanViewController ()<ResponseData,UIActionSheetDelegate>
{
    Request *request;
    int timeTick;
    NSTimer *timer;
    //    UIImageView *_imageVIew;
    
}

@property (nonatomic,strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *AmtLabel;//显示金额
@property (nonatomic,strong) NSString *respCodes;//接受后台返回成功与否的值


@end

@implementation DisplayScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微信收款";
    
    
    NSString *amtStr = [NSString stringWithFormat:@"%.2f%@",self.ScanMoney.doubleValue,@"￥"];
    self.AmtLabel.text = amtStr;
    
 
    
    self.view.backgroundColor = [UIColor whiteColor];
    request = [[Request alloc]initWithDelegate:self];
    
    
    [self generateScanCode];//创建二维码容器--imageView
//    [self ImageViewAndTap];//长按二维码分享
//    [self sharePicture];//分享二维码
    
    self.imageView.userInteractionEnabled=YES;

}

//二维码容器--imageView
- (void)generateScanCode
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-170)/2, 100, 170, 170)];
    
    self.imageView.hidden = YES;
    
    self.imageView.image = [LBXScanWrapper createQRWithString:_scanImage size:self.imageView.bounds.size];
    if (self.imageView.image) {
        [LBXScanWrapper addImageViewLogo:self.imageView centerLogoImageView:nil logoSize:CGSizeZero];
        self.imageView.hidden = NO;
    }
    [self.view addSubview:self.imageView];
    
}
//设置imageView长按手势分享二维码
- (void)ImageViewAndTap{
    
    
    
    self.imageView.userInteractionEnabled=YES;
    
    UILongPressGestureRecognizer *singleTap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(shareClick:)];
    [self.imageView addGestureRecognizer:singleTap];
    //    [singleTap release];
    
    //长按手势
    singleTap.minimumPressDuration=1;
    
    //所需触摸1次
    singleTap.numberOfTouchesRequired=1;
    
    
    
}


//分享二维码
- (void)sharePicture{
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"serve_more"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

//调整长按手势触发两次的问题
-(void)shareClick:(UILongPressGestureRecognizer *)sender

{
    
//    [Common showMsgBox:nil msg:@"分享功能暂未开放" parentCtrl:self];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        
        

        
    
        //1、创建分享参数
        NSArray* imageArray = @[self.imageView.image];
        
        if (imageArray) {
            
            NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
            
            [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                             images:imageArray
                                                url:[NSURL URLWithString:@"www.jiefengpay.com"]
                                              title:@"分享标题"
                                               type:SSDKContentTypeImage];
            //2,分享
            [ShareSDK showShareActionSheet:sender
                                     items:nil
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state)
                           {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                       message:[NSString stringWithFormat:@"%@", error]
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   break;
                               }
//                               case SSDKResponseStateCancel:
//                               {
//                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                                       message:nil
//                                                                                      delegate:nil
//                                                                             cancelButtonTitle:@"确定"
//                                                                             otherButtonTitles:nil];
//                                   [alertView show];
//                                   break;
//                               }
//                               default:
//                                   break;
                           }
                       }];
            
        }
    
        
    }
    
}




//  微信原生分享
//    WXMediaMessage *message = [WXMediaMessage message];
//    [message setThumbImage:self.imageView.image];
//
//    WXImageObject *imageObject = [WXImageObject object];
//
//    imageObject.imageData = UIImagePNGRepresentation(self.imageView.image);
//    message.mediaObject = imageObject;
//    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
//    req.bText = NO;
//    req.message = message;
//    req.scene = WXSceneSession;//分享到微信聊天界面
//    [WXApi sendReq:req];

//}
    


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type
{
    if ([dict[@"respCode"]isEqual:@"0000"]) {
        if (type == REQUSET_QUERYWEIXINORDERSTATE) {
            self.respCodes = [[dict objectForKey:@"data" ] objectForKey:@"respCode"];
            if ([self.respCodes integerValue] == 000000) {
                [Common showMsgBox:nil msg:@"支付成功" parentCtrl:self];
                [timer invalidate];
            }else
            {
                
                //                timeTick = 1;//10秒倒计时
                //                timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                //                [timer invalidate];
            }
            
        }
    }
}


#pragma mark ------分享--------
//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
