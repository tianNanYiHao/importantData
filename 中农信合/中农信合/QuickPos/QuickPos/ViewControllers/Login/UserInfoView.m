//
//  UserInfoView.m
//  QuickPos
//
//  Created by 胡丹 on 15/3/20.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "UserInfoView.h"
#import "Request.h"
#import "UserBaseData.h"

@interface UserInfoView()<ResponseData>{

}
@property (weak, nonatomic)IBOutlet UIImageView *userIcon;
@property (weak, nonatomic)IBOutlet UILabel *userName;
@property (weak, nonatomic)IBOutlet UILabel *userSum;//用户金额
@property (weak, nonatomic)IBOutlet UILabel *withdrawSum;//可提现余额

@end

@implementation UserInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        self = [[[NSBundle mainBundle]loadNibNamed:@"UserInfoView" owner:self options:nil] objectAtIndex:0];
//        self.userName.text = [AppDelegate getUserBaseData].userName;
//        Request *req = [[Request alloc]initWithDelegate:self];
//        [req getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];
//        
//    }
//    return self;
//}


//xib文件加载完毕
- (void)awakeFromNib{
    [super awakeFromNib];
    self.userIcon.image = [UIImage imageNamed:@"icon"];
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.layer.cornerRadius = 25.0;
    self.userName.text = [AppDelegate getUserBaseData].userName;
    self.userSum.text = @"0.00";
    self.withdrawSum.text = @"0.00";
    Request *req = [[Request alloc]initWithDelegate:self];
    [req getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];
}

- (void)dataInit{
    
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        if (type == REQUEST_ACCTENQUIRY) {
            double userSum = [[dict objectForKey:@"availableAmt"] doubleValue];
            double withdrawSum = [[dict objectForKey:@"cashAvailableAmt"] doubleValue];
            self.userSum.text = [NSString stringWithFormat:@"%0.2f",userSum/100];
            self.withdrawSum.text = [NSString stringWithFormat:@"%0.2f",withdrawSum/100];
//            if ([AppDelegate getUserBaseData].pic.length == 0) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    Request *req = [[Request alloc]initWithDelegate:self];
                    [req userInfo:[AppDelegate getUserBaseData].mobileNo];

//                });

//            }else{
//                UIImage *image = [UIImage imageWithData:[self headImage:[AppDelegate getUserBaseData].pic]];
//                self.userIcon.image = image;
//            }
        }else if(type == REQUSET_USERINFOQUERY){
        UserBaseData *u  = [[UserBaseData alloc]initWithData:[[dict objectForKey:@"data"] objectForKey:@"resultBean"]];
        self.userName.text = [[[dict objectForKey:@"data"] objectForKey:@"resultBean"]objectForKey:@"realName"];
        [AppDelegate getUserBaseData].pic = u.pic;
        //GCD操作
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
//            if (u.pic.length!=0) {
////                [AppDelegate getUserBaseData].pic = u.pic;
//                UIImage *image = [UIImage imageWithData:[self headImage:u.pic]];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    // 更新界面
//                    self.userIcon.image = image;
//                });
//
//            }
            
//        });

        }else{
        
        }
    }
}

-(NSData *)headImage:(NSString *)icon{
    
    int len = [icon length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [icon length] / 2; i++) {
        byte_chars[0] = [icon characterAtIndex:i*2];
        byte_chars[1] = [icon characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    
    
    return data;
}

@end
