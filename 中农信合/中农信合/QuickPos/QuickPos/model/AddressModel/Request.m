
//
//  Request.m
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "Request.h"




#define XZSHOP_BASE_URL @"http://xizheng.jiefengpay.com:8080/hdcctp/"  //习正商城baseUrl
#define XZPhoneRecharge_Base_Url @"xizheng.jiefengpay.com:8888/hdcctp/" //习正手机充值BaseUrl
#define XZTrainTicket_Base_Url @"http://xizheng.jiefengpay.com:8080/hdcctp/" //习正火车票BaseUrl


#define MANGE_BASW_URL @"http://192.168.1.184:8888/api/" //理财基础URL
#define SHOPSUOYUAN_BASEURL @"http://www.shfda.org/platform/rest/v2/" //商品朔源BaseUrl
#define SHOPSUOYUAN_BASEURL2 @"http://www.shfda.org/platform/rest/v1/tag/validation/" //手动商品朔源


#define TimeOut 60
@interface Request(){

    
}
@property(nonatomic, strong)NSObject<ResponseData>* delegate;
@end

@implementation Request
// 请求标识定义

- (instancetype)initWithDelegate:(NSObject<ResponseData>*)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

// 用户登录请求
- (void)userLoginWithAccount:(NSString*)account password:(NSString*)password{
    if ([password length] != 256) {
        // 没有加密时将数据加密
        password = [[[QuickPos alloc] init] enCodeWithData:password enCodeType:NO account:account];
    }
    NSDictionary *dict = @{@"application": MONILEMAC_LOGIN,
                           @"mobileNo": account,
                           @"password": password,
                           @"token": @"0000",
                           @"encodetype":@"userpassword",
                           };
    [self requestWithDict:dict requestType:REQUEST_USERLOGIN];
}
// 获取验证码
- (void)getMobileMacWithAccount:(NSString*)account appType:(NSString*)type{
    NSDictionary *dic = @{@"application": MONILEMAC_MOBILEMAC,
                          @"mobileNo": account,
                          @"phone": account,
                          @"token": @"0002",
                          @"appType": type};
    [self requestWithDict:dic requestType:REQUEST_GETMOBILEMAC];
    
}
////版本更新
//-(void)ClientUpdateInstrVersion:(NSString *)instrVersion dateType:(NSString *)dateType
//{
//    NSDictionary *dic = @{@"application":MOBILEMAC_CLIENTUPDATE,
//                          @"instrVersion":instrVersion,
//                          @"dateType":dateType,
//                          @"token":@"0000"
//                          };
//    [self requestWithDict:dic requestType:REQUEST_CLIENTUPDATE];
//}
//注册
- (void)userSignWithAccount:(NSString *)account password:(NSString *)password mobileMac:(NSString *)mobileMac
{
    if ([password length] != 256) {
    // 没有加密时将数据加密
        password = [[[QuickPos alloc] init] enCodeWithData:password enCodeType:NO account:account];
    }

    NSDictionary *dict = @{@"application": MOBILEMAC_REGISTER,
                           @"userName":account,
                           @"mobileNo": account,
                           @"password": password,
                           @"mobileMac":mobileMac,
                           @"token": @"0001",
                           @"encodeType":@"userpassword"};
    
    [self requestWithDict:dict requestType:REQUEST_USERREGISTER];
        
}

//找回密码
- (void)backPasswordWithMobileNo:(NSString *)mobileNo newPassword:(NSString *)newPassword cardID:(NSString *)cardID mobileMac:(NSString *)mobileMac realNmae:(NSString *)realNmae{
    if ([newPassword length] != 256) {
        // 没有加密时将数据加密
        newPassword = [[[QuickPos alloc] init] enCodeWithData:newPassword enCodeType:NO account:mobileNo];
    }
   
    
 
    NSDictionary *dict = @{@"application": MOBILEMAC_RETPWD,
                           @"certType":@"01",
                           @"mobileNo": mobileNo,
                           @"newPassword": newPassword,
                           @"mobileMac":mobileMac,
                           @"certPid":cardID,
                           @"realName":realNmae,
                           @"token": @"0000",
                           };
    
    [self requestWithDict:dict requestType:REQUEST_BACKPASSWORD];

}

//修改密码
- (void)changePasswordWithMobileNo:(NSString *)mobileNo newPassword:(NSString *)newPassword olePassword:(NSString *)olePassword mobileMac:(NSString *)mobileMac{
    if ([newPassword length] != 256) {
        // 没有加密时将数据加密
        newPassword = [[[QuickPos alloc] init] enCodeWithData:newPassword enCodeType:NO account:mobileNo];
    }
    if ([olePassword length] != 256) {
        // 没有加密时将数据加密
        olePassword = [[[QuickPos alloc] init] enCodeWithData:olePassword enCodeType:NO account:mobileNo];
    }

    
    
    
    
    NSDictionary *dict = @{@"application": MOBILEMAC_CHANGEPASSWORD,
                           @"password":olePassword,
                           @"mobileNo": mobileNo,
                           @"newPassword": newPassword,
                           @"mobileMac":mobileMac,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"encodetype":@"userpassword",
                           };
    
    [self requestWithDict:dict requestType:REQUEST_CHANGEPASSWORD];
    
}






//查询用户信息接口字段
- (void)userInfo:(NSString*)mobileNo{
    NSDictionary *dict = @{@"application": MONILEMAC_USERINFO,
                           @"mobileNo": mobileNo,
                           @"token": @"0000",
                           };
    [self requestWithDict:dict requestType:REQUSET_USERINFOQUERY];
    
}
//虚拟账户余额查询接口
- (void)getVirtualAccountBalance:(NSString*)accType token:(NSString*)token{
    NSDictionary *dic = @{@"application": MOBILEMAC_ACCTENQUIRY,
                          @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                          @"acctType": accType,
                          @"token":[AppDelegate getUserBaseData].token,
                          };
    [self requestWithDict:dic requestType:REQUEST_ACCTENQUIRY];

}


//申请交易订单
- (void)applyOrderMobileNo:(NSString *)mobileNo MerchanId:(NSString*)merchantId productId:(NSString*)productId orderAmt:(NSString *)orderAmt orderDesc:(NSString*)orderDesc orderRemark:(NSString*)orderRemark commodityIDs:(NSString *)commodityIDs payTool:(NSString*)payTool{
     
    NSDictionary *dic = @{@"application": MOBILEMAC_ORDER,
                          @"mobileNo": mobileNo,
                          @"merchantId": merchantId,
                          @"productId": productId,
                          @"orderAmt": orderAmt,
                          @"orderDesc": orderDesc,
                          @"orderRemark": orderRemark,
                          @"commodityIDs":commodityIDs,
                          @"payTool": payTool,
                          @"token":[AppDelegate getUserBaseData].token,
                          };
    NSLog(@"%@",orderDesc);
    
    [self requestWithDict:dic requestType:REQUSET_ORDER];
    
}



//实名认证资料（无界传organization，上传头像的前一步骤）
- (void)realNameAuthentication:(NSString *)realName ID:(NSString *)ID{
        NSDictionary *dic = @{@"application": @"UserUpdateInfo",
                              @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                              @"realName": realName,
                              @"certPid": ID,
                              @"certType": @"01",
                              @"token":[AppDelegate getUserBaseData].token,
                              };
        [self requestWithDict:dic requestType:REQUEST_REALNAMEAUTHENTICATION];
    
}

//获取商城列表
- (void)getMallListmobile:(NSString *)mobileNo firstData:(NSString *)firstData lastData:(NSString *)lastData dataSize:(NSString *)dataSize requestType:(NSString *)requestType
{
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSDictionary *dict = @{@"application":MOBILEMAC_COMMODITYLIST,
                           @"mobileNo":mobileNo,
                           @"firstDataID":firstData,
                           @"lastDataID":lastData,
                           @"dataSize":dataSize,
                           @"requestType":requestType,
                           @"token":@"0000"
                           };
    [self requestWithDict:dict requestType:REQUEST_COMMODITYLIST];
    
}

//上传头像
-(void)upPhotoImage:(NSData*)imageStr{
    
//    NSLog(@"res %@", imageStr);
//    NSLog(@"base encode %@", [Utils base64Encode:imageStr]);
//    NSLog(@"base decode %@", [Utils base64Decode:[Utils base64Encode:imageStr]]);
    
    NSDictionary *dic = @{@"application": MONILEMAC_USERIDENTITYPICUPLOAD,
                        @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                        @"img":[Utils base64Encode:imageStr],
                        @"imgApplyType":@"01",
                        @"imgSign":@"",
                        @"token":[AppDelegate getUserBaseData].token,
                        };
    [self requestWithDict:dic requestType:REQUEST_UPHEADIMAGE];
}

//添加商城数据
- (void)addMallDataMobileNo:(NSString *)mobileNo icon:(NSString *)icon title:(NSString *)title price:(NSString *)price amount:(NSString *)amount
{
    NSDictionary*dic=@{@"application": MOBILEMAC_ADDCOMMODITY,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"icon":icon,
                       @"title":title,
                       @"price":price,
                       @"amount":amount,
                       @"token":@"0000",
                       };
    [self requestWithDict:dic requestType:REQUEST_ADDCOMMODITY];
}
//删除商品数据
- (void)DeleteMallDataMobileNo:(NSString *)mobileNo commodityID:(NSString *)commodityID
{
    NSDictionary*dic=@{@"application": MOBILEMAC_DELETECOMMODITY,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"commodityID":commodityID,
                       @"token":@"0000",
                       };
    [self requestWithDict:dic requestType:REQUEST_DELETECOMMODITY];
}
- (void)changeMallDataMobileNo:(NSString *)mobileNo commodityID:(NSString *)commodityID icon:(NSString *)icon title:(NSString *)title price:(NSString *)price amount:(NSString *)amount
{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:      MOBILEMAC_EDITCOMMODITY,@"application",
       [AppDelegate getUserBaseData].mobileNo,@"mobileNo",commodityID,@"commodityID",
                        amount,@"amount",
    [AppDelegate getUserBaseData].mobileNo,@"token", nil];
    
    if (icon) {
        [dic setObject:icon forKey:@"icon"];
    }
    if (title) {
        [dic setObject:title forKey:@"title"];
    }
    if (price) {
        [dic setObject:price forKey:@"price"];
    }
    
    
    
    
    [self requestWithDict:dic requestType:REQUEST_EDITCOMMODITY];
}
//上传身份证正面
-(void)upIDcardPositive:(NSData*)imageStr{
    
    
    //Utils md5WithData:imageStr], 图片签名
    NSDictionary*dic=@{@"application": MONILEMAC_USERIDENTITYPICUPLOAD,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"img" :[Utils base64Encode:imageStr],
                       @"imgApplyType":@"02",
                       @"imgSign":@"",
                       @"token":[AppDelegate getUserBaseData].token,
                       };
    [self requestWithDict:dic requestType:REQUSET_IDCARDPOSITIVE];


}

//上传身份证反面
-(void)upIDcardReverse:(NSData*)imageStr{
   
    
    NSDictionary*dic=@{@"application": MONILEMAC_USERIDENTITYPICUPLOAD,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"img":[Utils base64Encode:imageStr],
                       @"imgApplyType":@"03",
                       @"imgSign":@"",
                       @"token":[AppDelegate getUserBaseData].token,
                       };
    [self requestWithDict:dic requestType:REQUSET_IDCARDREVERSE];
    
}

// 贴牌资源
- (void)userAgreement{
    NSDictionary *dic = @{@"application": MOBILEMAC_USERAGREEMENT,
                          @"token": @"0000"};
    [self requestWithDict:dic requestType:REQUEST_USERAGREEMENT];
}

// 获取频道
- (void)getChannel{
}

//银行卡列表
-(void)bankListAndbindType:(NSString*)bindType{
    
    
    NSDictionary*dic=@{@"application": MOBILEMAC_GETBANKLIST,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"bindType":bindType,
                       @"cardIdx":@"0",
                       @"cardNum":@"10",
                       @"token":[AppDelegate getUserBaseData].token,
                       };
    [self requestWithDict:dic requestType:REQUSET_BANKLIST];
    
    
}

//银行所在省份
-(void)BankofProvinces{

    NSDictionary*dic=@{@"application" : MOBILEMAC_CITIESCODE,
                       @"token" :[AppDelegate getUserBaseData].token,
                       
                       };
 [self requestWithDict:dic requestType:REQUSET_PROVINCES];
}
//银行所在城市
-(void)BankofCity:(NSString *)provinceCode{
    
    NSDictionary*dic=@{@"application": MOBILEMAC_CITIESCODE,
                       @"token" :[AppDelegate getUserBaseData].token,
                       @"provinceCode":provinceCode,
                       };
    [self requestWithDict:dic requestType:REQUSET_CITY];
}
//上传签名图片
- (void)UserSignatureUploadMobile:(NSString *)mobile longitude:(NSString *)logitude latitude:(NSString *)latitude merchantId:(NSString *)merchantId orderId:(NSString *)orderId signPicAscii:(NSString *)signPicAscii picSign:(NSString *)picSign
{
    NSDictionary *dic = @{@"application":MOBILEMAC_USERSIGNATUREUPLOAD,
                          @"mobile":mobile,
                          @"longitude":logitude,
                          @"latitude":latitude,
                          @"merchantId":merchantId,
                          @"orderId":orderId,
                          @"signPicAscii":signPicAscii,
                          @"picSign":picSign,
                          @"token":[AppDelegate getUserBaseData].token,
                          };
    [self requestWithDict:dic requestType:REQUEST_USERSIGNATUREUPLOAD];
}

//总行
-(void)GetBankHeadQuarter{
    
    NSDictionary*dic=@{@"application": MOBILEMAC_BANK,
                       @"token": @"0000"
                       };
    [self requestWithDict:dic requestType:REQUSET_BANK];
}
//支行
-(void)GetBranch{
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    NSString*bankProvinceId=[userDefaults objectForKey:KFprovincesID];
    NSString*bankCityId=[userDefaults objectForKey:KFcityID];
    NSString*bankID=[userDefaults objectForKey:BankID];
    
    NSDictionary*dic=@{@"application": MOBILEMAC_BANKOFBRANCH,
                       @"bankProvinceId":bankProvinceId,
                       @"bankCityId":bankCityId,
                       @"condition":@"",
                       @"offset":@"0",
                       @"token":[AppDelegate getUserBaseData].token,
                       @"bankId":bankID,
                       };
    [self requestWithDict:dic requestType:REQUSET_Branch];
    
    
}
//绑定银行卡
-(void)BankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType{
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString*bankID=[userDefaults objectForKey:branchID];
    
    NSDictionary*dic=@{@"application": MOBILEMAC_BANKCARDBIND,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"bankId":bankID,
                       //@"offset":@"0",
                       @"accountNo":accountNumber,
                       @"mobile":mobile,
                       //@"cardIdx":@"00",
                       @"token":[AppDelegate getUserBaseData].token,
                       @"bandType":bandType,
                       @"versionFlag":@"1",
                       };
    
   
    
    [self requestWithDict:dic requestType:REQUSET_BankCardBind];
    
}

//绑定银行卡
-(void)BankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType bankName:(NSString *)bankName{
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString*bankID=[userDefaults objectForKey:BankID];
    
    NSDictionary*dic=@{@"application": MOBILEMAC_BANKCARDBIND,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"bankId":bankID,
                       //@"offset":@"0",
                       @"accountNo":accountNumber,
                       @"mobile":mobile,
                       //@"cardIdx":@"00",
                       @"token":[AppDelegate getUserBaseData].token,
                       @"bandType":bandType,
                       @"versionFlag":@"1",
                       @"bankName":bankName,
                       };
    
    
    
    [self requestWithDict:dic requestType:REQUSET_BankCardBind];
    
}




//绑定银行卡--支付宝,提现,我的分润
-(void)ZFBBankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType bankName:(NSString *)bankName{
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString*bankID=[userDefaults objectForKey:BankID];
    
    NSDictionary*dic=@{@"application": MOBILEMAC_BANKCARDBIND,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"bankId":bankID,
                       //@"offset":@"0",
                       @"accountNo":accountNumber,
                       @"mobile":mobile,
                       //@"cardIdx":@"00",
                       @"token":[AppDelegate getUserBaseData].token,
                       @"bandType":bandType,
                       @"versionFlag":@"1",
                       @"bankName":bankName,
                       };
    
    
    
    [self requestWithDict:dic requestType:REQUSET_BankCardBind];
    
}

//微信收款绑定银行卡
- (void)WeixinCardAuthentcardappUser:(NSString *)appUser cardOwner:(NSString *)cardOwner bankId:(NSString *)bankId bankName:(NSString *)bankName bankBranchId:(NSString *)bankBranchId bankBranchName:(NSString *)bankBranchName provinceId:(NSString *)provinceId bankProvince:(NSString *)bankProvince cityId:(NSString *)cityId bankCity:(NSString *)bankCity cardNo:(NSString *)cardNo phone:(NSString *)phone real_name:(NSString *)real_name cmer:(NSString *)cmer cert_no:(NSString *)cert_no mobile:(NSString *)mobile{

    NSDictionary *dic = @{@"application": MONILEMAC_VERIFYWEIXINPAY,
                          @"token":[AppDelegate getUserBaseData].token,
                          @"appUser":@"bmjfsh",
                          @"cardOwner":cardOwner,//开卡人姓名
                          @"bankId":bankId,//银行ID
                          @"bankName":bankName,//银行名称
                          @"bankBranchId":@"",//分行ID
                          @"bankBranchName":@"",//分行名称
                          @"provinceId":provinceId,//开户省份ID
                          @"bankProvince":bankProvince,//开户省份名字
                          @"cityId":cityId,//开户城市ID
                          @"bankCity":bankCity,//开户城市名字
                          @"cardNo":cardNo,//卡号
                          @"phone":[AppDelegate getUserBaseData].mobileNo,//账户手机号
                          @"real_name":[AppDelegate getUserBaseData].userName,//用户姓名(手机APP名字)
                          @"cmer":cmer,//商户名称
                          @"cert_no":cert_no,//身份证号
                          @"mobile":mobile,//银行卡开户绑定手机号
                          };
    
    [self requestWithDict:dic requestType:REQUSET_VERIFYWEIXINPAY];
}


//获取微信支付二维码
- (void)prepayAllowtotalFee:(NSString *)totalFee orderId:(NSString *)orderId Info:(NSString *)Info acctNo2:(NSString *)acctNo2
{
    NSDictionary *dict = @{@"application": MONILEMAC_PREPAYALLOW,
                           @"token":[AppDelegate getUserBaseData].token,
                           @"totalFee":totalFee,
                           @"phone":[AppDelegate getUserBaseData].mobileNo,
                           @"orderId":orderId,
                           @"Info":Info,
                           @"acctNo2":acctNo2,
                           };
    [self requestWithDict:dict requestType:REQUSET_PREPAYALLOW];

}

//微信支付订单成功状态查询
- (void)queryWeixinOrderStateorderId:(NSString *)orderId
{
    NSDictionary *dict = @{@"application": MONILEMAC_QUERYWEIXINORDERSTATE,
                           @"token":[AppDelegate getUserBaseData].token,
                           @"orderId":orderId,
                           @"phone":[AppDelegate getUserBaseData].mobileNo,
                           };

    [self requestWithDict:dict requestType:REQUSET_QUERYWEIXINORDERSTATE];
}


//信用卡还款--绑定银行卡
-(void)BankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andcustName:(NSString *)custName andBandType:(NSString*)bandType{
    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
    
    NSString*bankID=[userDefaults objectForKey:BankID];
    
    NSDictionary*dic=@{@"application": MOBILEMAC_BANKCARDBIND,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"bankId":@"",
                       @"accountNo":accountNumber,
                       @"mobile":mobile,
                       @"token":[AppDelegate getUserBaseData].token,
                       @"custName":custName,
                       @"bandType":bandType,
                       @"versionFlag":@"1",
                       };
    
    
    
    [self requestWithDict:dic requestType:REQUSET_BankCardBind];
    
}

//盛迪嘉解除银行卡绑定
-(void)BankCardUnBind:(NSString *)cardldx{

    NSDictionary*dic=@{@"application": MOBILEMAC_BANKCARDUNBIND,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       
                       @"cardIdx":cardldx,
                       @"token":[AppDelegate getUserBaseData].token,
                       
                       
                       };
    [self requestWithDict:dic requestType:REQUSET_BankCardUnBind];


}








//消息列表
-(void)msgList:(NSString *)firstMsgID andLastMsgID:(NSString *)lastMsgID andRequestType:(NSString *)requestType{


    NSDictionary*dic=@{@"application": MOBILEMAC_MESGLIST,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"firstMsgID":firstMsgID,
                       @"lastMsgID":lastMsgID,
                       @"msgSize":@"20",
                       @"requestType":requestType,
                       
                       @"token":[AppDelegate getUserBaseData].token,
                       };
    [self requestWithDict:dic requestType:REQUSET_MESGLIST];



}







//交易记录列表
-(void)recordList:(NSString *)filter andFirstMsgID:(NSString *)firstMsgID andLastMsgID:(NSString *)lastMsgID andRequestType:(NSString *)requestType{
    
    
    NSDictionary*dic=@{@"application": MOBILEMAC_RECORDLIST,
                       
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"firstMsgID":firstMsgID,
                       @"lastMsgID":lastMsgID,
                       @"msgSize":@"20",
                       @"requestType":requestType,
                       @"filter":filter,
                       @"token":[AppDelegate getUserBaseData].token,
                       };
    [self requestWithDict:dic requestType:REQUSET_RECORDLIST];
    
    
    
}

//交易记录详情
-(void)recordDetail:(NSString *)recordID andTime:(NSString *)time{
    
    NSDictionary*dic=@{@"application": MOBILEMAC_RECORDDETAIL,
                       
                       @"mobile":[AppDelegate getUserBaseData].mobileNo,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"recordID":recordID,
                       @"time":time,
                       @"token":[AppDelegate getUserBaseData].token,
                       };
    [self requestWithDict:dic requestType:REQUSET_RECORDDETAIL];



}

//扫码支付接口
-(void)queryScanMoneyWithOrderNo:(NSString *)orderNo{
//    NSString *orderNo = [[NSString alloc]init];
    NSDictionary*dic=@{@"application": MONILEMAC_QUERYSCANMONEY,
                       @"token":[AppDelegate getUserBaseData].token,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"orderNo":orderNo,
                       
                       };
    [self requestWithDict:dic requestType:REQUSET_QUERYSCANMONEY];
    
}


//我的刷卡器
-(void)myCreditCardMachine{
    
    NSDictionary*dic=@{
                       @"application": MOBILEMAC_MYPOS,
                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                       @"token":[AppDelegate getUserBaseData].token,
                       
                       };
    [self requestWithDict:dic requestType:REQUSET_MYPOS];
    
}


//查询卡余额
- (void)checkMyCardBalance:(NSString*)cardInfo cardPassWord:(NSString*)cardPassWord iccardInfo:(NSString*)ICCardInfo ICCardSerial:(NSString*)ICCardSerial ICCardValidDate:(NSString*)ICCardValidDate merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId encodeType:(NSString*)encodeType{
    
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *c = [quickPos enCodeWithData:cardPassWord enCodeType:YES account:orderId];
    NSDictionary*dic=@{@"application": MOBILEMAC_CARDBALANCE ,
                       @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                       @"cardInfo": cardInfo,
                       @"cardPassword": c,
                       @"ICCardInfo": ICCardInfo,
                       @"ICCardSerial": ICCardSerial,
                       @"ICCardValidDate": ICCardValidDate,
                       @"merchantId": merchantId,
                       @"encodeType": @"bankpassword",
                       @"orderId": orderId,
                       @"token":[AppDelegate getUserBaseData].token
                       };
    [self requestWithDict:dic requestType:REQUSET_CARDBALANCE];
    
    
}
//商城支付接口
- (void)mallCardPay:(NSString *)cardInfo cardPassWord:(NSString *)cardPassword iccardInfo:(NSString *)ICCardInfo ICCardSerial:(NSString *)ICCardSerial ICCardValidDate:(NSString *)ICCardValidDate merchantId:(NSString *)merchantId productId:(NSString *)productId orderId:(NSString *)orderId encodeType:(NSString *)encodeType orderAmt:(NSString *)orderAmt payType:(NSString*)payType{
    
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *c = [quickPos enCodeWithData:cardPassword enCodeType:YES account:orderId];
    NSDictionary*dic=@{@"application":MOBILEMAC_JFPALCARDPAYFORSTORE ,
                       @"cardInfo": cardInfo,
                       @"cardPassword": c,
                       @"ICCardInfo": ICCardInfo,
                       @"ICCardSerial": ICCardSerial,
                       @"ICCardValidDate":ICCardValidDate,
                       @"merchantId": merchantId,
                       @"productId": productId,
                       @"orderId": orderId,
                       @"encodeType": encodeType,
                       @"token": [AppDelegate getUserBaseData].token,
                       @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                       @"orderAmt": orderAmt,
                       @"payType":payType,
                       };
    [self requestWithDict:dic requestType:REQUSET_JFPALCARDPAYFORSTORE];
}

//支付接口  
- (void)cardPay:(NSString*)cardInfo cardPassWord:(NSString*)cardPassword iccardInfo:(NSString*)ICCardInfo ICCardSerial:(NSString*)ICCardSerial ICCardValidDate:(NSString*)ICCardValidDate merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId  encodeType:(NSString*)encodeType orderAmt:(NSString*)orderAmt payType:(NSString*)payType{
    
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *c = [quickPos enCodeWithData:cardPassword enCodeType:YES account:orderId];
    NSDictionary*dic=@{@"application":MOBILEMAC_JFPALCARDPAY ,
                       @"cardInfo": cardInfo,
                       @"cardPassword": c,
                       @"ICCardInfo": ICCardInfo,
                       @"ICCardSerial": ICCardSerial,
                       @"ICCardValidDate":ICCardValidDate,
                       @"merchantId": merchantId,
                       @"productId": productId,
                       @"orderId": orderId,
                       @"encodeType": encodeType,
                       @"token": [AppDelegate getUserBaseData].token,
                       @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                       @"orderAmt": orderAmt,
                       @"payType":payType,
                       };
    [self requestWithDict:dic requestType:REQUSET_JFPALCARDPAY];

}

//卡卡转账-刷卡支付接口

- (void)CardToCardPay:(NSString *)custName mobile:(NSString *)mobile merchantId:(NSString *)merchantId productId:(NSString *)productId ICDat:(NSString *)ICDat CrdSqn:(NSString *)CrdSqn cardType:(NSString *)cardType TExpDat:(NSString *)TExpDat PinBlk:(NSString *)PinBlk cardNoIn:(NSString *)cardNoIn orderNo:(NSString *)orderNo mobileNo:(NSString *)mobileNo CTxnAt:(NSString *)CTxnAt appUser:(NSString *)appUser Track2:(NSString *)Track2{
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *c = [quickPos enCodeWithData:PinBlk enCodeType:YES account:orderNo];
    NSDictionary *dic = @{@"application":MOBILEMAC_CARDTOCARDPAY,
                          @"custName":custName,//收款人姓名
                          @"mobile":mobile,//收款人手机号
                          @"merchantId":merchantId,
                          @"productId":productId,
                          @"ICDat":ICDat,//IC卡数据
                          @"CrdSqn":CrdSqn,//信用卡后三位
                          @"cardType":cardType,//信用卡为"0",借记卡为"1"
                          @"TExpDat":TExpDat,//信用卡有效期
                          @"PinBlk":c,//密码
                          @"cardNoIn":cardNoIn,//收款人账号
                          @"orderNo":orderNo,//订单编号
                          @"mobileNo":[AppDelegate getUserBaseData].mobileNo,//本机号码
                          @"CTxnAt":CTxnAt,//金额
                          @"appUser":@"bmjfsh",
                          @"Track2":Track2,//磁条卡磁道信息
                          @"token": [AppDelegate getUserBaseData].token,
                          
                          };
    [self requestWithDict:dic requestType:REQUSET_CARDTOCARDPAY];
    
}
//卡卡转账-刷卡支付接口1
- (void)CardToCardPay:(NSString*)cardInfo cardPassWord:(NSString*)cardPassword iccardInfo:(NSString*)ICCardInfo ICCardSerial:(NSString*)ICCardSerial ICCardValidDate:(NSString*)ICCardValidDate merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId  encodeType:(NSString*)encodeType orderAmt:(NSString*)orderAmt payType:(NSString*)payType{
    
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *c = [quickPos enCodeWithData:cardPassword enCodeType:YES account:orderId];
    NSDictionary*dic=@{@"application":MOBILEMAC_CARDTOCARDPAY  ,
                       @"cardInfo": cardInfo,
                       @"cardPassword": c,
                       @"ICCardInfo": ICCardInfo,
                       @"ICCardSerial": ICCardSerial,
                       @"ICCardValidDate":ICCardValidDate,
                       @"merchantId": merchantId,
                       @"productId": productId,
                       @"orderId": orderId,
                       @"encodeType": encodeType,
                       @"token": [AppDelegate getUserBaseData].token,
                       @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                       @"orderAmt": orderAmt,
                       @"payType":payType,
                       };
    [self requestWithDict:dic requestType:REQUSET_CARDTOCARDPAY];
    
}


//账户支付

- (void)acctPay:(NSString*)mobileNo encodetype:(NSString*)encodetype password:(NSString*)password mobileMac:(NSString*)mobileMac acctType:(NSString*)acctType merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId orderAmt:(NSString*)orderAmt encodeType:(NSString*)encodeType payType:(NSString*)payType{
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *passwordEncode = [quickPos enCodeWithData:password enCodeType:NO account:orderId];
//    NSString *mobileMacEncode = [quickPos enCodeWithData:mobileMac enCodeType:YES account:orderId];
    
    NSDictionary*dic=@{@"application":MOBILEMAC_JFPALACCTPAY,
                       @"mobileNo": mobileNo,
                       @"encodetype": @"userpassword",
                       @"password": passwordEncode,
                       @"mobileMac": mobileMac,
                       @"acctType": acctType,
                       @"merchantId": merchantId,
                       @"productId": productId,
                       @"orderId": orderId,
                       @"orderAmt": orderAmt,
                       @"encodeType": @"bankpassword",
                       @"token":[AppDelegate getUserBaseData].token,
                       @"payType":payType,
                       };
    [self requestWithDict:dic requestType:REQUSET_JFPALACCTPAY];
    
}

//提现
-(void)takeCash:(NSString *)cashAmt andPassword:(NSString *)password andMobileMac:(NSString *)mobileMac andCashType:(NSString *)cashType andCardTag:(NSString *)cardTag andCardIdx:(NSString *)cardIdx{

    if ([password length] != 256) {
        // 没有加密时将数据加密
        password = [[[QuickPos alloc] init] enCodeWithData:password enCodeType:NO account:[AppDelegate getUserBaseData].mobileNo];
    }
    
    NSDictionary *dict = @{@"application": MOBILEMAC_JFPALCASH,
                           @"cashAmt": cashAmt,
                           @"password": password,
                           @"cardIdx": cardIdx,
                           @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                           @"cardTag": cardTag,
                           @"mobileMac":mobileMac,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"encodeType":@"userpassword",
                           @"cashType":cashType,
                           
                           };
    
    [self requestWithDict:dict requestType:REQUSET_JFPalCash];
}

//我的分润提现
-(void)AgentCash:(NSString *)cashAmt andPassword:(NSString *)password andMobileMac:(NSString *)mobileMac andCashType:(NSString *)cashType andCardTag:(NSString *)cardTag andCardIdx:(NSString *)cardIdx{
    
    if ([password length] != 256) {
        // 没有加密时将数据加密
        password = [[[QuickPos alloc] init] enCodeWithData:password enCodeType:NO account:[AppDelegate getUserBaseData].mobileNo];
    }
    
    NSDictionary *dict = @{@"application": MOBILEMAC_AGENTCASH,
                           @"cashAmt": cashAmt,
                           @"password": password,
                           @"cardIdx": cardIdx,
                           @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
                           @"cardTag": cardTag,
                           @"mobileMac":mobileMac,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"encodeType":@"userpassword",
                           @"cashType":cashType,
                           
                           };
    
    [self requestWithDict:dict requestType:REQUSET_AGENTCASH];
}

//威富通获取二维码接口
- (void)postCodeImageWihtorderID:(NSString*)orderId orderAmT:(NSString*)orderAmt{
    
    NSDictionary *dict = @{
                           @"orderId":orderId,
                           @"orderAmt":orderAmt,
                           @"mobileNo":[AppDelegate getUserBaseData].mobileNo
                           };
     [self requestWithDict:dict requestType:REQUSET_WftAliPay];
}

#pragma mark ------盛迪嘉无卡支付
//获取盛迪嘉无卡支付银行卡列表
- (void)GetSdjQuickBankCard{
    NSDictionary *dict = @{@"application": MONILEMAC_GETSDJQUICKBANKCARD,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"appuser":@"bmjfsh",
                           };
    [self requestWithDict:dict requestType:REQUSET_GETSDJQUICKBANKCARD];
}

//盛迪嘉无卡支付绑定银行卡--获取短信验证接口
- (void)QuickBankCardComfirmSdjSmsWithbindID:(NSString *)bindID mobileNo:(NSString *)mobileNo{

    NSDictionary *dict = @{@"application": MONILEMAC_QUICKBANKCARDCOMFIRMSDJSMS,
                           @"mobileNo": mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"bindID":bindID,
                           };
    [self requestWithDict:dict requestType:REQUSET_QUICKBANKCARDCOMFIRMSDJSMS];
    
}
//盛迪嘉无卡支付绑定银行卡
- (void)QuickBankCardPaySdjWithorderId:(NSString *)orderId cardNo:(NSString *)cardNo customerName:(NSString *)customerName legalCertType:(NSString *)legalCertType legalCertPid:(NSString *)legalCertPid cardType:(NSString *)cardType referrerMobileNo:(NSString *)referrerMobileNo mobileNo:(NSString *)mobileNo phone:(NSString *)phone bankCode:(NSString *)bankCode unitBankCode:(NSString *)unitBankCode{
    
    NSDictionary *dict = @{@"application": MONILEMAC_QUICKBANKCARDPAYSDJ,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"orderId":orderId,
                           @"cardNo":cardNo,
                           @"customerName":customerName,
                           @"legalCertType":legalCertType,
                           @"legalCertPid":legalCertPid,
                           @"cardType":cardType,
                           @"referrerMobileNo":referrerMobileNo,
                           @"mobileNo": mobileNo,
                           @"phone":[AppDelegate getUserBaseData].mobileNo,
                           @"bankCode":bankCode,
                           @"unitBankCode":unitBankCode,
                           };
    [self requestWithDict:dict requestType:REQUSET_QUICKBANKCARDPAYSDJ];

}
//盛迪嘉无卡支付--支付短信验证码
- (void)QuickBankCardPaySdjSmsWithorderAmt:(NSString *)orderAmt mobileNo:(NSString *)mobileNo{

    NSDictionary *dict = @{@"application": MONILEMAC_QUICKBANKCARDPAYSDJSMS,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"mobileNo": mobileNo,
                           @"orderAmt":orderAmt,
                           };
    [self requestWithDict:dict requestType:REQUSET_QUICKBANKCARDPAYSDJSMS];
}
//盛迪嘉无卡支付--支付接口
- (void)QuickBankCardComfirmSdjWithorderId:(NSString *)orderId orderAmt:(NSString *)orderAmt cardNo:(NSString *)cardNo customerName:(NSString *)customerName legalCertPid:(NSString *)legalCertPid bankCode:(NSString *)bankCode mobileNo:(NSString *)mobileNo referrerMobileNo:(NSString *)referrerMobileNo{

    NSDictionary *dict = @{@"application": MONILEMAC_QUICKBANKCARDCOMFIRMSDJ,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"orderId":orderId,
                           @"orderAmt":orderAmt,
                           @"cardNo":cardNo,
                           @"customerName":customerName,
                           @"legalCertPid":legalCertPid,
                           @"bankCode":bankCode,
                           @"mobileNo": mobileNo,
                           @"referrerMobileNo":referrerMobileNo,
                           @"cardType":@"0",
                           @"phone":[AppDelegate getUserBaseData].mobileNo,
                           
                           };
     NSLog(@"%@",referrerMobileNo);
    
    [self requestWithDict:dict requestType:REQUSET_QUICKBANKCARDCOMFIRMSDJ];
}

#pragma mark - 无卡支付
//获取无卡支付绑定银行卡列表
- (void)getQuickPayMyCardList{
    NSDictionary *dict = @{@"application": MOBILEMAC_GETQUICKBANKCARD,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           };
    
    [self requestWithDict:dict requestType:REQUEST_GETQUICKBANKCARD];

}
//解绑无卡支付银行卡
- (void)quickPayBankCardUnbind:(NSString*)bindId newBindId:(NSString *)newbindid orderId:(NSString *)orderId{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];
    
    NSString *OrderTime = [[NSString alloc]initWithFormat:@"%@%@",currentDate,currenttime];
    
    NSString *OrderId = [NSString stringWithFormat:@"%@%i%i",OrderTime,0,0];
    
    NSDictionary *dict = @{@"application": MOBILEMAC_UNBINDQUICKBANKCARD,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"bindID": bindId,
                           @"newBindId":newbindid,
                           @"orderId":orderId,
                           @"transData":currentDate,
                           @"appUser":@"bmjfsh",
                           };
    
    [self requestWithDict:dict requestType:REQUEST_UNBINDQUICKBANKCARD];


}
//绑定快捷支付银行卡
- (void)QuickBankAuthent:(NSString *)mobileNo ValiDate:(NSString *)valiDate CustomerName:(NSString *)customerName CustomerId:(NSString *)customerId LegalCertPid:(NSString *)legalCertPid Cvn:(NSString *)cvn orderTime:(NSString *)orderTime  LegalCertType:(NSString *)legalCertType CardNo:(NSString *)cardNo CardType:(NSString *)cardType OrderId:(NSString *)orderId BankName:(NSString *)bankName{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];
    
    NSString *OrderTime = [[NSString alloc]initWithFormat:@"%@%@",currentDate,currenttime];
    
    NSString *OrderId = [NSString stringWithFormat:@"%@%i%i",OrderTime,0,0];
    
    NSLog(@"%@ %@",orderTime,OrderId);
    
    NSDictionary *dict = @{@"application":MONILEMAC_QUICKBANKAUTHENT,
                           @"mobileNo":mobileNo,//银行预留手机号
                           @"valiDate":valiDate,//有效期
                           @"customerName":customerName,//银行卡姓名
                           @"customerId":customerId,//上个接口返回
                           @"legalCertPid":legalCertPid,//身份证号
                           @"cvn":cvn,//安全码
                           @"orderTime":OrderTime,//交易时间 年月日
                           @"legalCertType":legalCertType,//身份证类型 传01
                           @"cardNo":cardNo,//卡号
                           @"cardType":cardType,//卡类型
                           @"orderId":OrderId,//订单编号
                           @"bankName":bankName,//银行名称
                           @"accType":@"01",
                           @"merNo":@"",
                           @"productId":@"",
                           @"merchantId":@"",
                           @"orgCode":@"",
                           @"token": [AppDelegate getUserBaseData].token,
                           };
    NSLog(@"%@",orderTime);
    [self requestWithDict:dict requestType:REQUSET_QUICKBANKAUTHENT];
    

}


//快捷支付--支付接口
- (void)QuickBankCardConfirmCardNo:(NSString *)cardNo mobileNo:(NSString *)mobileNo password:(NSString *)password newbindid:(NSString *)newbindid transDate:(NSString *)transDate transTime:(NSString *)transTime orderTime:(NSString *)orderTime customerId:(NSString *)customerId customerName:(NSString *)customerName cardType:(NSString *)cardType bankName:(NSString *)bankName orderAmt:(NSString *)orderAmt orderId:(NSString *)orderId PinBlk:(NSString *)PinBlk

{
    
    if ([password length] != 256) {
        // 没有加密时将数据加密
        password = [[[QuickPos alloc] init] enCodeWithData:password enCodeType:NO account:cardNo];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];
    
    NSString *OrderTime = [[NSString alloc]initWithFormat:@"%@%@",currentDate,currenttime];
    
    NSDictionary *dict = @{@"application":MONILEMAC_QUICKBANKCARDCONFIRM,
                           @"mobileNo": mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"cardNo":cardNo,
                           @"password":password,
                           @"newbindid":newbindid,
                           @"transDate":currentDate,
                           @"transTime":currenttime,
                           @"orderTime":OrderTime,
                           @"customerId":customerId,
                           @"customerName":customerName,
                           @"cardType":cardType,
                           @"bankName":bankName,
                           @"orderAmt":orderAmt,
                           @"orderId":orderId,
                           @"PinBlk":PinBlk,
                           
                           };
    
    [self requestWithDict:dict requestType:REQUSET_QUICKBANKCARDCONFIRM];
    
}





//获取快捷支付短信验证码

- (void)SendDynamicCode:(NSString *)newbindid mobileNo:(NSString *)mobileNo
{
    NSDictionary *dict = @{@"application": MONILEMAC_SENDDYNAMICCODE,
                           @"mobileNo":mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"newbindid": newbindid,
                    
                           };
     [self requestWithDict:dict requestType:REQUSET_SENDDYNAMICCODE];

}

//验证快捷支付短信验证码
- (void)CheckDynamicCode:(NSString *)newbindid mobileNo:(NSString *)mobileNo dynameic:(NSString *)dynameic
{
    NSDictionary *dict = @{@"application": MONILEMAC_CHECKDYNAMICCODE,
                           @"mobileNo": mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"newbindid": newbindid,
                           @"dynameic":dynameic,
                           };
    [self requestWithDict:dict requestType:REQUSET_CHECKDYNAMICCODE];
    
}

//快捷支付验证银行卡信息
- (void)checkBankCardNo:(NSString*)cardNo{
    NSDictionary *dict = @{@"application": MONILEMAC_CARDBINQUERY,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"cardNo": cardNo,
                           };
    
    [self requestWithDict:dict requestType:REQUSET_CARDBINQUERY];
    
}


//查询银行卡信息
- (void)checkBankCardInfo:(NSString*)cardNo{
    NSDictionary *dict = @{@"application": MOBILEMAC_QUICKBANKCARDQUERY,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"cardNo": cardNo,
                           };
    
    [self requestWithDict:dict requestType:REQUEST_QUICKBANKCARDQUERY];

}
//无卡支付申请
- (void)applyForQuickPay:(NSString*)name IDCard:(NSString*)IDCard cardNo:(NSString*)cardNo vaild:(NSString*)vaild cvv2:(NSString*)cvv2 phone:(NSString*)phone orderID:(NSString*)orderID bindID:(NSString*)bindID orderAmt:(NSString*)orderAmt productId:(NSString*)productId merchantId:(NSString*)merchantId{
    QuickPos *quickPos = [[QuickPos alloc]init];
    NSString *payInfoEncode = [quickPos enCodeWithName:name IDCard:IDCard cardNo:cardNo vaild:vaild cvv2:cvv2 phone:phone];
    NSDictionary *dict = @{@"application": MOBILEMAC_QUICKBANKCARDAPPLY,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"payInfo": payInfoEncode,
                           @"encodeType": @"quickPayment",
                           @"orderId": orderID,
                           @"bindID": bindID,
                           @"orderAmt":orderAmt,
                           @"merchantId":merchantId,
                           @"productId": productId,
                           };
    
    [self requestWithDict:dict requestType:REQUEST_QUICKBANKCARDAPPLY];
}
//确认无卡支付
- (void)enSureQuickPay:(NSString*)validateCode orderID:(NSString*)orderID{
    NSDictionary *dict = @{@"application": MOBILEMAC_QUICKBANKCARDCONFIRM,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"validateCode": validateCode,
                           @"orderId": orderID,
//                           @"merchantId":@"0004000001",
//                           @"productId":@"0000000000",
                           };
    
    [self requestWithDict:dict requestType:REQUEST_QUICKBANKCARDCONFIRM];
}
//发送无卡支付验证短信
- (void)getQuickPayCode:(NSString*)orderID{
    NSDictionary *dict = @{@"application": MOBILEMAC_QUICKBANKCARDMSG,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"orderId": orderID,
//                           @"merchantId":@"0004000001",
//                           @"productId":@"0000000000",
                           };
    
    [self requestWithDict:dict requestType:REQUEST_QUICKBANKCARDMSG];

}

//注册微信商户
- (void)registerWeixinPayphone:(NSString *)phone
{
    NSDictionary *dict = @{@"application": MONILEMAC_REGISTERWEIXINPAY,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"phone":phone,
                           @"appUser":@"bmjfsh"
                           };
    [self requestWithDict:dict requestType:REQUSET_REGISTERWEIXINPAY];
}

//查询注册微信状态接口
- (void)queryBindWeixinOrderStatephone:(NSString *)phone
{
    NSDictionary *dict = @{@"application": MONILEMAC_QUERYBINDWEIXINORDERSTATE,
                          @"token": [AppDelegate getUserBaseData].token,
                          @"phone":phone,
                          };
    [self requestWithDict:dict requestType:REQUSET_QUERYBINDWEIXINORDERSTATE];
}

//

//功能频道开关
- (void)getChannelApplication{
    NSDictionary *dict = @{@"application": MOBILEMAC_GETCHANNELAPPLICATION,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           };
    
    [self requestWithDict:dict requestType:REQUEST_GETCHANNELAPPLICATION];

}




//信用卡信息查询
- (void)checkCreditCardInfo:(NSString*)realName cardNum:(NSString*)accountNo{
    NSDictionary *dict = @{@"application": MOBILEMAC_QUERYCREDITINFO,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"realName": realName,
                           @"accountNo": accountNo,
                           @"bandType":@"04",
                           };
    
    [self requestWithDict:dict requestType:REQUEST_QUERYCREDITINFO];
    
}

//-(void)CreditCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType{
//    NSUserDefaults*userDefaults=[NSUserDefaults standardUserDefaults];
//    
////    NSString*bankID=[userDefaults objectForKey:branchID];
//    
//    NSDictionary*dic=@{@"application": MOBILEMAC_BANKCARDBIND,
//                       
//                       @"mobileNo":[AppDelegate getUserBaseData].mobileNo,
////                       @"bankId":bankID,
//                       @"accountNo":accountNumber,
//                       @"mobile":mobile,
//                       @"token":[AppDelegate getUserBaseData].token,
//                       @"bandType":@"04",
//                       @"versionFlag":@"1",
//                       
//                       };
//    [self requestWithDict:dic requestType:REQUSET_BankCardBind];
//}

    //绑定快捷⽀支付认证码
-(void)quickPayCode:(NSString*)organization{

    NSDictionary *dict = @{@"application": MOBILEMAC_BINDQUICKPAYPSAM,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           @"organization": organization,
                           
                           };
    
    [self requestWithDict:dict requestType:REQUEST_ORGANIZATION];




}

// 查询快捷⽀支付认证码绑定状态
-(void)quickPayCodeState{
    
    NSDictionary *dict = @{@"application": MOBILEMAC_GETQUICKPAYPSAM,
                           @"mobileNo": [AppDelegate getUserBaseData].mobileNo,
                           @"token": [AppDelegate getUserBaseData].token,
                           };
    
    [self requestWithDict:dict requestType:REQUEST_QUICKPAYSTATE];
}









#pragma  mark  ------------  基础网络请求
// 网络请求 dict:请求参数,type:请求唯一标识
- (void)requestWithDict:(NSDictionary*)dict requestType:(NSInteger)type {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    XML *Xml = [[XML alloc] init];
    NSString *str = [Xml xmlDataWithDict:dict];
    
//    str = [Utils urlDecode:str];
    NSString *sing = [Utils urlEncode:str];
    str = sing;
    sing = [Utils md5WithString:sing];
    str = [str stringByReplacingOccurrencesOfString:SIGN withString:sing];
    str = [NSString stringWithFormat:@"requestXml=%@", str];
    NSLog(@"request %@",[Utils urlDecode:str]);
    NSURL *url = [NSURL URLWithString:BASE_URL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:TimeOut];
    [req setHTTPMethod:@"POST"];
    [req setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession*session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            BOOL achieve = [self.delegate respondsToSelector:@selector(responseWithDict:requestType:)];
            NSDictionary *d = [Xml deXMLWithData:data];
            if (data && achieve) {
                if ([[d objectForKey:@"respCode"] isEqualToString:@"0001"] || [[d objectForKey:@"respCode"] isEqualToString:@"0002"]) {
                    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication].keyWindow rootViewController] view] WithString:d[@"respDesc"]];
//                    [[QuickPosTabBarController getQuickPosTabBarController] gotoLoginViewCtrl];
                }
                else
                {
                    [self.delegate responseWithDict:d requestType:type];
                }
            }
            NSString *desc = [d objectForKey:@"respDesc"];
            NSLog(@"resp %@", d);
            
            NSLog(@"respDesc返回-%@",desc);
        }
        else if (error && error.code == -1001){
            NSLog(@"请求超时");
            NSDictionary *dic = @{@"respCode": @"1001", @"respDesc": @"请求超时,请稍后重试"};
            [self.delegate responseWithDict:dic requestType:type];
        } else if (error && error.code == -1009) {
            NSLog(@"%@", error.localizedDescription);
            
            NSDictionary *dic = @{@"respCode": @"1001", @"respDesc": error.localizedDescription};
            [self.delegate responseWithDict:dic requestType:type];
        }
    }];
    [sessionTask resume];
    

}


- (void)sendInfo{
    //    NSDictionary*dic=@{@"act":@"welcome" ,
    //                       @"ver":@"1.1" ,
    //                       @"app":@"other"
    //                       };
    //    NSDictionary*dic=@{
    //                       @"termId":@"99999900" ,
    //                       @"orgId":@"000000039" ,
    //                       @"busType":@"100061",
    //                       @"cateId":@"" ,
    //                       @"series":@"1" ,
    //                       @"totalSeries":@"3"
    //                       };
    
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"cateId":@"" ,
                                     @"series":@"1" ,
                                     @"totalSeries":@"3"}
                       };
    NSLog(@"%@",dic);
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    NSLog(@"%@",dict);
    [self requestWithDict:dict requestType:REQUSET_FIRST withUrl:@"MALL0001.json?"];
}
//产品列表接口
- (void)getProductWithCardId:(NSString*)cardId{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"cateId":cardId ,
                                     }
                       
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_PRODUCTLIST withUrl:@"MALL0002.json?"];
}

//中农信合(溯源商城和跨境电商)产品列表接口
- (void)getProductIdWithCardId:(NSString*)cardId{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"cateId":cardId ,
                                     }
                       
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_PRODUCTIDLIST withUrl:@"MALL0002.json?"];
    
    
}

- (void)getAD{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061"}
                       
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_AD withUrl:@"MALL0004.json?"];
}

- (void)getInfoWithMobile:(NSString*)mobile{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"mobile":mobile
                                     }
                       
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_ORDER_INQUIRY withUrl:@"MALL0006.json?"];
}
//产品详情接口
- (void)getDetailInfoWithProductId:(NSString*)productId withTraceabilityId:(NSString*)traceabilityId{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"TransDate":currentDate,
                                     @"TransTime":currenttime,
                                     @"productId":productId,
                                     @"isTerm":@"0",
                                     @"traceabilityId":traceabilityId,
                                     }
                       };
  
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_PRODUCTDETAIL withUrl:@"MALL0003.json?"];
}

////产品详情接口(溯源商城的)
//- (void)getDetailInfoWithCateId:(NSString *)cateId WithModulesOrgId:(NSString *)modulesOrgId{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyyMMdd"];
//    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
//    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//    [dateFormatter1 setDateFormat:@"HHmmss"];
//    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];
//    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
//                       @"REQ_BODY":@{@"termId":@"39999999" ,
//                                     @"orgId":@"000000039" ,
//                                     @"busType":@"100061",
//                                     @"totalSeries":@"4",
//                                     @"TransDate":currentDate,
//                                     @"TransTime":currenttime,
//                                     @"cateId":cateId,
//                                     @"modulesOrgId":modulesOrgId,
//                                     @"isTerm":@"0",
//                                     }
//                       
//                       };
//    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
//    [self requestWithDict:dict requestType:REQUSET_PRODUCTDETAIL withUrl:@"MALL0014.json?"];
//}

//获取商城订单金额
- (void)getMoneyInfoWithProductId:(NSString*)productId productList:(id)productlist{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]]; //获取系统时间0
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
//                                     @"busType":@"100061",
                                     @"TransDate":currentDate,
                                     @"TransTime":currenttime,
                                     @"isTerm":@"0",
                                     @"products":productlist,
                                     }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_GETMONEY withUrl:@"MALL0007.json?"]; //发送网络请求
}


//orgId:指的机构号
//termId:指的终端号

//今日秒杀商城接口
- (void)getTodyKillProductWithCardId:(NSString*)cardId{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]]; //获取系统时间0
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
    NSDictionary *dic = @{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                          @"REQ_BODY":@{@"termId":@"39999999",
                                        @"orgId":@"000000039",
                                        @"series":@"1",
                                        @"busType":@"100061",
                                        @"modulesOrgId":@"sc0000001",
                                        @"cateId":@"C001201511000687",
                                        @"TransDate":currentDate,
                                        @"TransTime":currenttime,
                                        }
                          };

    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    
    [self requestWithDict:dict requestType:REQUSET_GETTODAYKILL withUrl:@"MALL0014.json?"];

    
}

//溯源商城接口
- (void)getMastmallProductWithCardId:(NSString*)cateId{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]]; //获取系统时间0
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
    NSDictionary *dic = @{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                          @"REQ_BODY":@{@"modulesOrgId":@"sc0000002",
                                        @"series":@"1",
                                        @"busType":@"100061",
                                        @"totalSeries":@"4",
                                        @"orgId":@"000000039",
                                        @"TransDate":currentDate,
                                        @"TransTime":currenttime,
                                        @"termId":@"39999999",
                                        }
                          };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUEST_GETMASTMALL withUrl:@"MALL0013.json?"];
    
    
}
//跨境电商接口
- (void)getCrossBorderProductWithCardId:(NSString*)cateId{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]]; //获取系统时间0
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
//    NSDictionary *dic = @{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
//                          @"REQ_BODY":@{@"modulesOrgId":@"kj0000001",
//                                        @"busType":@"100061",
//                                        @"series":@"1",
//                                        @"orgId":@"A00000008",
//                                        @"TransDate":currentDate,
//                                        @"totalSeries":@"3",
//                                        @"TransTime":currenttime,
//                                        @"termId":@"80000001",
////                                        @"productId":@"0000000000",
//                                    }
//                          };
    
    
    NSDictionary *dic = @{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                          @"REQ_BODY":@{@"modulesOrgId":@"kj0000002",
                                        @"series":@"1",
                                        @"busType":@"100061",
                                        @"totalSeries":@"4",
                                        @"orgId":@"000000039",
                                        @"TransDate":currentDate,
                                        @"TransTime":currenttime,
                                        @"termId":@"39999999",
                                        }
                          };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    
    [self requestWithDict:dict requestType:REQUEST_GETCROSSBORDER withUrl:@"MALL0013.json?"];
    
    
}


//获取商城列表和金额
- (void)gettotalMoneyWithProductLists:(NSArray*)productlists withMobile:(NSString *)mobile withTotal:(NSString*)total{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]]; //获取系统时间0
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"TransDate":currentDate,
                                     @"TransTime":currenttime,
                                     @"mobile":mobile,
                                     @"idNo":@"",
                                     @"idName":@"",
                                     @"idType":@"1",
                                     @"totalAmount":total,  //总金额
                                     @"products":productlists, //产品列表
                                     }
                       
                       };
    
    
    
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_GETORDER withUrl:@"MALL0008.json?"];
}

//产品详情里--商品溯源接口
- (void)getproductId:(NSString*)productId{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SUCCESS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"productId":productId,
                                     }
                       
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_GETORIGIN withUrl:@"TF1007.json"];
}

//商城支付完成后向习正发送订单接口
- (void)getMallorderId:(NSString *)orderId ordStatus:(NSString *)ordStatus transStatus:(NSString *)transStatus receiverName:(NSString *)receiverName receiverPhone:(NSString *)receiverPhone receiverAddress:(NSString *)receiverAddress cardNo:(NSString *)cardNo txnAmt:(NSString *)txnAmt{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]]; //获取系统时间0
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
    
    NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":@{@"termId":@"39999999" ,
                                     @"orgId":@"000000039" ,
                                     @"busType":@"100061",
                                     @"TransDate":currentDate,
                                     @"TransTime":currenttime,
                                     @"orderId":orderId,//商城订单id
                                     @"ordStatus":ordStatus,//订单状态,00成功,01未支付,02交易失败,03超时,04订单处理中,05交易结束
                                     @"transStatus":transStatus,//支付状态,00成功,01正在初始,02正在处理,03支付失败
                                     @"receiverName":receiverName,//收货人姓名
                                     @"receiverPhone":receiverPhone,  //收货人手机号
                                     @"receiverAddress":receiverAddress, //收货人地址
                                     @"cardNo":cardNo,//付款人账号
                                     @"txnAmt":txnAmt,//支付金额
                                     }
                       };
    
    
    
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requestWithDict:dict requestType:REQUSET_SENDMALLORDERTOXIZHENG withUrl:@"MALL0019.json?"];
}


//json解析  得到jsonData
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (id)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:theData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    
    if ([jsonData count] > 0 && error == nil && [jsonData isKindOfClass:[NSDictionary class]]){
        return jsonData;
    }else{
        return nil;
    }
}

#pragma mark - 习正商城网络请求
// 网络请求 dict:请求参数,type:请求唯一标识
- (void)requestWithDict:(NSDictionary*)dict requestType:(NSInteger)type  withUrl:(NSString *)url{
    
    
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",XZSHOP_BASE_URL,url] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ %@",responseObject,[responseObject class]);
        BOOL achieve = [self.delegate respondsToSelector:@selector(responseWithDict:requestType:)];
        if (responseObject && achieve) {
                [self.delegate responseWithDict:responseObject requestType:type];
        }
        NSNotification *notifition = [NSNotification notificationWithName:@"ruquest" object:nil userInfo:@{@"result":@"success"}];
        [[NSNotificationCenter defaultCenter] postNotification:notifition];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ %@",task,error);
        NSNotification *notifition = [NSNotification notificationWithName:@"ruquest" object:nil userInfo:@{@"result":@"success"}];
        [[NSNotificationCenter defaultCenter] postNotification:notifition];
    }];
}


//手机充值业务接口1
//支付成功后调用此接口处理手机充值业务
-(void)postPhoneRechargeOnwOrderId:(NSString*)orderId moneyAmt:(NSString*)moneyAmt mobileNo:(NSString*)mobile{
   
    
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SUCCESS":@"1"},
                       @"REQ_BODY":@{
                               @"orgId":@"A00000008",
                               @"termId":@"80000001",
                               @"busType":@"000001",
                               @"orderId":orderId,
                               @"orderAmt":moneyAmt,
                               @"fee":@"0",
                               @"mobile":mobile
                               }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requesPhoneRechargeWithDict:dict requestType:REQUSET_XZPhoneRecharge1 ulr:@"PC1101.json"];
 
}
//手机充值业务付款后业务流程接口2
//支付成功后调用此接口处理手机充值业务
-(void)postPhoneRechargeTwoOrderId:(NSString*)orderId{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SUCCESS":@"1"},
                       @"REQ_BODY":@{
                               @"orgId":@"A00000008",
                               @"termId":@"80000001",
                               @"busType":@"0",
                               @"orderId":orderId,
                               }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self requesPhoneRechargeWithDict:dict requestType:REQUSET_XZPhoneRecharge2 ulr:@"PC1102.json"];

}

    
    
#pragma mark - 习正手机充值接口处理
-(void)requesPhoneRechargeWithDict:(NSDictionary*)dict requestType:(NSInteger)type ulr:(NSString*)url{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",XZPhoneRecharge_Base_Url,url] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ %@",responseObject,[responseObject class]);
        BOOL achieve = [self.delegate respondsToSelector:@selector(responseWithDict:requestType:)];
        if (responseObject && achieve) {
            [self.delegate responseWithDict:responseObject requestType:type];
        }
        NSNotification *notifition = [NSNotification notificationWithName:@"ruquest" object:nil userInfo:@{@"result":@"success"}];
        [[NSNotificationCenter defaultCenter] postNotification:notifition];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ %@",task,error);
    }];
}


//``````````````````````````````````````````````````````````````````````习正火车票查询````````````````````````````````````````````````````
//3.1 查询车次
- (void)checkTrainInfoBusType:(NSString*)busType orgID:(NSString*)orgId termID:(NSString*)termId trainDate:(NSString*)traindate fromStation:(NSString*)fromstation toStation:(NSString*)tostation purposeCodes:(NSString*)purposecodes{
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HHmmss"];
     NSString *currenttime = [dateFormatter1 stringFromDate:[NSDate date]];  //获取系统时间1
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":
                           @{@"TransTime":currenttime,
                             @"busType":@"000002",
                             @"termId":@"80000001",
                             @"orgId":@"A00000008",
                             @"from_station":@"BJP",
                             @"TransDate":@"20160929",
                             @"train_date":@"2016-09-29",
                             @"to_station":@"SHH",
                             @"purpose_codes":@"ADULT"
                             }
                       };
     NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self trainRequestWithDict:dict requestType:REQUSET_XZTK1003 withUrl:@"TK1003.json"];
}

//3.2 登录12306
-(void)logIN12306TermId:(NSString*)termID orgID:(NSString*)orgid busType:(NSString*)busType userName:(NSString*)username password:(NSString*)password{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":
                           @{@"termId":@"" ,
                             @"orgId":@"" ,
                             @"busType":@"",
                             @"username":@"",
                             @"password":@"",
                             }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self trainRequestWithDict:dict requestType:REQUSET_XZTK1009 withUrl:@"TK1009.json"];
    
}

//3.3下单接口
-(void)getProOrdNoWithtermId:(NSString*)termID orgId:(NSString*)orgID busType:(NSString*)busTypE checi:(NSString*)checI from_station_code:(NSString*)from_station_codE from_station_name:(NSString*)from_station_namE to_station_code:(NSString*)to_station_codE to_station_name:(NSString*)to_station_namE train_date:(NSString*)train_datE
                  passengers:(NSString*)passengerS mobile:(NSString*)mobilE zmoney:(NSString*)zmoneY uprice:(NSString*)upricE fee:(NSString*)feE count:(NSString*)counT{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":
                           @{@"termId":@"" ,
                             @"orgId":@"" ,
                             @"busType":@"",
                             @"checi":@"" ,
                             @"from_station_code":@"",
                             @"from_station_name":@"" ,
                             @"to_station_code":@"",
                             @"to_station_name":@"" ,
                             @"train_date":@"",
                             @"passengers":@"" ,
                             @"mobile":@"",
                             @"zmoney":@"" ,
                             @"uprice":@"",
                             @"fee":@"" ,
                             @"count":@"",
                             }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self trainRequestWithDict:dict requestType:REQUSET_XZTK1010 withUrl:@"TK1010.json"];
}
//3.4 习正业务处理接口(出票)
-(void)getTrainTicketsWithprdOrdNo:(NSString*)prdOrdNO termId:(NSString*)termID orgId:(NSString*)orgID busType:(NSString*)busTypE isGrab:(NSString*)isGraB deadline:(NSString*)deadlinE{
    
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":
                           @{@"prdOrdNo":@"" ,
                             @"termId":@"" ,
                             @"orgId":@"",
                             @"busType":@"" ,
                             @"isGrab":@"",
                             @"deadline":@"" ,
                             }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    [self trainRequestWithDict:dict requestType:REQUSET_XZTK1011 withUrl:@"TK1011.json"];
}
//4.1支付宝 / 微信 预下单接口
-(void)trainTicketPayBuyZFBOrderWithID:(NSString*)orderID type:(NSInteger)type{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":
                           @{@"orderId":orderID ,
                             @"termId":@"" ,
                             @"orgId":@"",
                             @"busType":@"" ,
                             }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    if (type == 01) {
         [self trainRequestWithDict:dict requestType:REQUSET_XZALIPAY0001 withUrl:@"ALIPAY0001.json"];
    }else if (type == 02){
         [self trainRequestWithDict:dict requestType:REQUSET_XZWeixinPay0001 withUrl:@"WeixinPay0001.json"];
    }
   
}

//4.2 支付宝 / 微信 支付结果查询
-(void)trainTicketPayBuyZFBOrderWithID:(NSString*)orderID readeID:(NSString*)tradeId type:(NSInteger)type{
    NSDictionary*dic=@{@"REQ_HEAD":@{@"TRAN_SCUESSS":@"1"},
                       @"REQ_BODY":
                           @{@"orderId":orderID ,
                             @"tradeId":tradeId,
                             @"termId":@"" ,
                             @"orgId":@"",
                             @"busType":@"" ,
                             }
                       };
    NSDictionary *dict = @{@"REQ_MESSAGE":[self DataTOjsonString:dic]};
    if (type == 01) {
        [self trainRequestWithDict:dict requestType:REQUSET_XZALIPAY0002 withUrl:@"ALIPAY0002.json"];
    }else if (type == 02){
        [self trainRequestWithDict:dict requestType:REQUSET_XZWeixinPay0002 withUrl:@"WeixinPay0002.json"];
    }

}
//5.1 锁票成功 发送数据到捷丰后台
-(void)trainTicketPayToJiefengWithorderId:(NSString*)orderID orderNo:(NSString*)orderNO
{
    NSDictionary *dict = @{@"application": MONILEMAC_SZHCPTicketPay,
                           @"orderId": orderID,
                           @"orderNo": orderNO,
                           @"token": @"0000",
                           };
    [self requestWithDict:dict requestType:REQUEST_USERLOGIN];
    
}



#pragma mark - 习正火车票处理
// 网络请求 dict:请求参数,type:请求唯一标识
- (void)trainRequestWithDict:(NSDictionary*)dict requestType:(NSInteger)type  withUrl:(NSString *)url{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    [manager POST:[NSString stringWithFormat:@"%@%@",XZTrainTicket_Base_Url,url] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@ %@",responseObject,[responseObject class]);
        BOOL achieve = [self.delegate respondsToSelector:@selector(responseWithDict:requestType:)];
        if (responseObject && achieve) {
            [self.delegate responseWithDict:responseObject requestType:type];
        }
        NSNotification *notifition = [NSNotification notificationWithName:@"ruquest" object:nil userInfo:@{@"result":@"success"}];
        [[NSNotificationCenter defaultCenter] postNotification:notifition];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@ %@",task,error);
        NSNotification *notifition = [NSNotification notificationWithName:@"ruquest" object:nil userInfo:@{@"result":@"success"}];
        [[NSNotificationCenter defaultCenter] postNotification:notifition];
    }];
}



#pragma mark - 商品朔源接口集

/**
 * 查询溯源企业
 */
- (void)getCompanySYwihtName:(NSString*)name fieldNames:(NSString*)fieldNames regionCity:(NSString*)regionCity pageNo:(NSString*)pageNo pageSize:(NSString*)pageSize Bool:(BOOL)yes{
    
     NSString *urlBef = @"enterprises?";
    if (yes == YES) {
        NSString *url = [NSString stringWithFormat:@"%@&name=%@&pageNo=%@&pageSize=%@",urlBef,name,pageNo,pageSize];
          [self requestWihtdictSY:url requestType:REQUSET_GETCOMPENYSY];
    }else{
          NSString *url = [NSString stringWithFormat:@"%@&pageNo=%@&pageSize=%@",urlBef,pageNo,pageSize];
          [self requestWihtdictSY:url requestType:REQUSET_GETCOMPENYSY];
    }
}

/**
 * 根据企业ID、条码或名称查询匹配的企业产品列表
 */
-(void)getCompanyListWithID:(NSString*)ID pageNo:(NSString*)pageNO pageSize:(NSString*)pagesize{
    
    NSString *urlBef = @"products?";
    NSString *url = [NSString stringWithFormat:@"%@&enterpriseId=%@&pageNo=%@&pageSize=%@",urlBef,ID,pageNO,pagesize];
    [self requestWihtdictSY:url requestType:REQUSET_products];
}
/**
 *3.4根据ID的产品查询
 */
- (void)getProductInfoWihtID:(NSString*)ID{
    NSString *urlBef = @"products/";
    NSString *url = [NSString stringWithFormat:@"%@%@",urlBef,ID];
    [self requestWihtdictSY:url requestType:REQUSET_PRODUCTINFO];
}
/**
 *3.5最近三笔三笔进货记录查询
 */
- (void)getProductInfoNearLyThreeList:(NSString*)CodeID{
    NSString *urlBef = @"accountdata/latestIn?";
    NSString *url = [NSString stringWithFormat:@"%@productId=%@",urlBef,CodeID];
    [self requestWihtdictSY:url requestType:REQUSET_ProductID];
}
/**
 *3.6追溯码的追溯查询
 */
-(void)getProductNodeListProductID:(NSString*)ID productionDate:(NSString*)date batch:(NSString*)batch{
    NSString *urlBef = @"tag/validation?";
    NSString *url = [NSString stringWithFormat:@"%@productId=%@&productionDate=%@&batch=%@",urlBef,ID,date,batch];
    [self requestWihtdictSY:url requestType:REQUSET_validation];
}



//3.2平台产品分类查询
-(void)getProductSYcategories{
    NSString *urlBef = @"categories";
    NSString *url = [NSString stringWithFormat:@"%@",urlBef];
      [self requestWihtdictSY:url requestType:REQUSET_categories];
    
}

/**7
 * 根据产品名称查产品列表
 *
 * @param product
 *            正常情况 product 和parentCategory不同时有值
 * @param pageSize
 * @param pageNo
 * @param parentCategory
 *            分类（九大类）
 * @return
 * @throws UnsupportedEncodingException
 */
// http://www.shfda.org/platform/rest/v2/products?product=&parentCategory=粮食及其制品&pageNo=1&pageSize=20
-(void)getProductSYcategoriesWithName:(NSString*)name pageNo:(NSString*)pageNo pageSIze:(NSString*)pageSize{
    NSString *urlBef = @"products?";
//    
//    NSString *utf8Str = name;
//    NSString *unicodeStr = [NSString stringWithCString:[utf8Str UTF8String] encoding:NSUnicodeStringEncoding];
     NSString *url = [NSString stringWithFormat:@"%@product=&parentCategory=%@&pageNo=%@&pageSize=%@",urlBef,name,pageNo,pageSize];
     [self requestWihtdictSY:url requestType:REQUSET_categoriesProduct];
}
#pragma makr - 溯源GET网络请求
-(void)requestWihtdictSY:(NSString*)url requestType:(NSInteger)payType{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlC = [NSString stringWithFormat:@"%@%@",SHOPSUOYUAN_BASEURL,url];
    urlC = [urlC stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manger GET:urlC parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictReq = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (dictReq && [_delegate respondsToSelector:@selector(responseWithDict:requestType:)]) {
            [self.delegate responseWithDict:dictReq requestType:payType];
            NSLog(@"tk%@",dictReq);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",task,[task class]);
        NSLog(@"%@",error);
    }];



}

//**6snCode搜索 // 这个鸟接口 真尼玛蛋疼
- (void)getProductSYInfoByScCode:(NSString*)code{
    
    NSString *url = [NSString new];
    url = @"http://www.shfda.org/platform/rest/v1/tag/validation/";
    NSString *c = [NSString stringWithFormat:@"%@%@",url,code];
    [self requestWihtdictSY2:c requestType:REQUSET_snCode];
    
}
#pragma mark - 溯源Get请求(特殊)
-(void)requestWihtdictSY2:(NSString*)url requestType:(NSInteger)payType{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dictReq = [Request dictionaryWithJsonString:aString];
        if (dictReq && [_delegate respondsToSelector:@selector(responseWithDict:requestType:)]) {
            [self.delegate responseWithDict:dictReq requestType:payType];
            NSLog(@"tk%@",dictReq);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@,%@",task,[task class]);
        NSLog(@"%@",error);
    }];
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
// 投诉接口
- (void)postComplaintWithtagId:(NSString*)tagId tagSn:(NSString*)tagSn tagSnProducerCode:(NSString*)tagSnProducerCode enterpriseId:(NSString*)enterpriseId productId:(NSString*)productId  userName:(NSString*)userName mobile:(NSString*)mobile comments:(NSString*)comments{
    
    UIImage *iamge = [UIImage imageNamed:@"22"];
    NSData *data2 = UIImageJPEGRepresentation(iamge, 0.5);
    NSString *dd = [data2 base64Encoding];
    
    
    
//    NSDictionary *dict = @{
//                           @"tagId": tagId,
//                           @"tagSn": tagSn,
//                           @"tagSnProducerCode": tagSnProducerCode,
//                           @"enterpriseId": enterpriseId,
//                           @"productId": productId,
//                           @"processId": @"",
//                           @"batch":@"" ,
//                           @"productionDate": @"",
//                           @"openId": @"",
//                           @"channel":@"",
//                           @"userName": userName,
//                           @"mobile": mobile,
//                           @"email": @"",
//                           @"comments": comments,
//                           @"address": @"",
//                           @"pictureBin": dd
//                           };
    
    
    NSDictionary *dict = @{
                           @"userName": userName,
                           @"mobile": mobile,
                           @"comments": comments
                           };
    NSString *sss = [NSString stringWithFormat:@"%@complaints",SHOPSUOYUAN_BASEURL];
    NSString *bodyString = [NSString stringWithFormat:@"%@",dict];
    NSData *bodyData = [[bodyString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]dataUsingEncoding:NSUTF8StringEncoding];//把bodyString转换为NSData数据
    NSURL *serverUrl = [NSURL URLWithString:sss];//获取到服务器的url地址
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];//请求这个地址， timeoutInterval:10 设置为10s超时：请求时间超过10s会被认为连接不上，连接超时
    
    [request setHTTPMethod:@"POST"];//POST请求
    [request setHTTPBody:bodyData];//body 数据
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];//请求头
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];//同步发送request，成功后会得到服务器返回的数据
    //返回的数据 根据系统的不同会返回不同编码的数据，比如windows 为GBK，Ubuntu 为UTF8.。。
    //注意转换编码格式
//<<<<<<< HEAD 
//    NSDictionary *dict =
//=======
    NSString *sssssssss = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//>>>>>>> master
    
    
    [self requestWithDictSYpost:dict requestType:REQUSET_Complaint withUrl:@"complaints"];
    
}
#pragma mark - 溯源投诉请求(特殊)
- (void)requestWithDictSYpost:(NSDictionary*)dict requestType:(NSInteger)type  withUrl:(NSString *)url{
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
//    NSString *sss = [NSString stringWithFormat:@"%@%@",SHOPSUOYUAN_BASEURL,url];
//    NSLog(@"sss== %@",sss);
//    [manager POST:sss parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"operation== %@responseObject== %@",operation,responseObject);
//            }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"operation== %@ error== %@",operation,error);
//              NSLog(@"%@",operation.responseString);
//            }];
}
@end
