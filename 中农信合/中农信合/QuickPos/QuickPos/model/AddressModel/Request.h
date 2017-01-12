  //
//  Request.h
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XML.h"
#import "QuickPos.h"
#import "Common.h"
#import "GTMBase64.h"


@protocol ResponseData <NSObject>

- (void)responseWithDict:(NSDictionary*)dict requestType:(NSInteger)type;

@end
// 请求标识定义
enum{
    REQUEST_USERLOGIN,
    REQUEST_USERREGISTER,
    REQUEST_GETMOBILEMAC,
    REQUEST_USERAGREEMENT,
    REQUEST_BACKPASSWORD,
    REQUEST_CHANGEPASSWORD,
    REQUSET_USERINFOQUERY,//用户信息
    REQUSET_ORDER,//申请订单
    REQUEST_COMMODITYLIST,//商城列表
    REQUEST_ADDCOMMODITY,//添加商品
    REQUEST_DELETECOMMODITY,//删除商品
    REQUEST_EDITCOMMODITY,//修改商品
    REQUEST_ACCTENQUIRY,
    REQUEST_UPHEADIMAGE,
    REQUEST_REALNAMEAUTHENTICATION,
    REQUEST_GETCHANNEL,//频道
    REQUSET_UPHEADIMAGE,//头像
    REQUSET_REALNAMEAUTHENTICATION, //真实姓名
    REQUSET_IDCARDPOSITIVE,//身份证正面
    REQUSET_IDCARDREVERSE,//身份证反面
    REQUSET_MESGLIST,//消息
    REQUSET_BANKLIST,//银行卡列表
    REQUSET_PROVINCES,//省份
    REQUSET_CITY,
    REQUSET_BANK,//银行总行
    REQUSET_Branch,//银行支行
    REQUSET_BankCardBind,//绑定卡
    REQUSET_BankCardUnBind,//盛迪嘉解除绑定银行卡
    REQUSET_RECORDLIST,//列表
    REQUSET_RECORDDETAIL, //详情
    REQUSET_MYPOS,//我的刷卡器
    REQUSET_CARDBALANCE, //查询银行卡余额
    REQUSET_JFPALCARDPAY, //支付
    REQUSET_CARDTOCARDPAY,//卡卡转账-刷卡支付
    REQUSET_JFPALCARDPAYFORSTORE,//商品支付
    REQUSET_JFPALACCTPAY,//账户支付,
    REQUSET_JFPalCash,//提现
    REQUSET_AGENTCASH,//我的分润提现
    REQUSET_WftAliPay,    //威富通支付宝获取二维码
    REQUEST_CLIENTUPDATE,//版本更新
    REQUEST_GETQUICKBANKCARD,//获取无卡支付绑定银行卡
    REQUEST_UNBINDQUICKBANKCARD,//解绑无卡支付银行卡
    REQUEST_QUICKBANKCARDQUERY,//查询银行卡信息
    REQUEST_QUICKBANKCARDAPPLY,//无卡支付申请
    REQUEST_QUICKBANKCARDCONFIRM,//确认无卡支付
    REQUEST_QUICKBANKCARDMSG,//发送无卡支付验证短信
    REQUEST_USERSIGNATUREUPLOAD, //上传签名图片
    REQUEST_GETCHANNELAPPLICATION, //功能频道开关
    REQUEST_QUERYCREDITINFO, //信用卡信息查询
    REQUEST_ORGANIZATION,//绑定快捷⽀支付认证码
    REQUEST_QUICKPAYSTATE,//查询快捷⽀支付认证码绑定状态
    REQUSET_QUERYSCANMONEY, //扫码支付
    REQUSET_CARDBINQUERY,//快捷支付验证银行卡信息
    REQUSET_QUICKBANKAUTHENT,//绑定快捷支付银行卡
    REQUSET_SENDDYNAMICCODE,//快捷支付获取验证码
    REQUSET_CHECKDYNAMICCODE,//验证快捷支付短信验证码
    REQUSET_QUICKBANKCARDCONFIRM,//快捷支付--支付接口
//    REQUSET_WEIXINCARDAUTHENT,//微信收款绑定银行卡
    
    REQUSET_REGISTERWEIXINPAY,//注册微信商户
    REQUSET_QUERYBINDWEIXINORDERSTATE,//查询注册微信状态
    
    REQUSET_VERIFYWEIXINPAY,//微信收款绑定银行卡
    REQUSET_PREPAYALLOW,//微信支付--获取二维码
    REQUSET_QUERYWEIXINORDERSTATE,//二维码支付订单查询
    REQUSET_GETSDJQUICKBANKCARD,//获取盛迪嘉无卡支付银行卡列表
    REQUSET_QUICKBANKCARDCOMFIRMSDJSMS,//盛迪嘉无卡支付绑定银行卡--获取短信验证接口
    REQUSET_QUICKBANKCARDPAYSDJ,//盛迪嘉无卡支付绑定银行卡
    REQUSET_QUICKBANKCARDPAYSDJSMS,//盛迪嘉无卡支付--支付短信验证码
    REQUSET_QUICKBANKCARDCOMFIRMSDJ,//盛迪嘉无卡支付--支付接口
    
    
    
    
    REQUSET_AD,
    REQUSET_PRODUCTLIST,//商城产品列表
    REQUSET_PRODUCTIDLIST,//商城产品列表
    REQUSET_ORDER_INQUIRY,
    REQUSET_FIRST,//51
    REQUSET_PRODUCTDETAIL,
    REQUSET_GETMONEY,
    REQUSET_GETORDER,//商城订单标示
    REQUSET_GETORIGIN,//详情页面--商品溯源
    REQUSET_SENDMALLORDERTOXIZHENG,//向习正发送订单状态
    
    
    
    
    
    REQUSET_Lccplist, //理财产品列表 55
    REQUSET_MyMangeZiChanList, //查询我的理财资产列表// 56
    REQUSET_HoldingList, //持有中.... 57
    REQUSET_ZHUCEMANGE, //开通理财账户 58
    REQUSET_showHadRedeem,//已赎回列表 59
    REQUSET_GETPRODUCTDITAIL, //获取产品详情列表 60
    REQUSET_getManageProductOrder, //生成理财产品订单接口 61
    


    REQUSET_GETTODAYKILL,//今日秒杀商城 62
    REQUEST_GETMASTMALL,//溯源商城
    REQUEST_GETCROSSBORDER,//跨商电竞
    
    
    REQUSET_GETCOMPENYSY,//独立--商品溯源
    REQUSET_products,//根据企业ID、条码或名称查询匹配的企业产品列表
    REQUSET_PRODUCTINFO,  //3.4根据ID的产品查询
    REQUSET_ProductID,         //3.5最近3笔数据插叙
    REQUSET_validation,        //3.6追溯码的追溯查询
    REQUSET_categories,     //3.2平台产品分类查询
    REQUSET_categoriesProduct,// 7 根据名字查询
    REQUSET_snCode,                  // 追溯查询
    REQUSET_Complaint,             //投诉post
    
    
    REQUSET_XZPhoneRecharge1, //习正手机充值1
    REQUSET_XZPhoneRecharge2, //习正手机充值2
    REQUSET_XZTK1003, //习正查询车次
    REQUSET_XZTK1009, //习正登录12306
    REQUSET_XZTK1010, //习正下单接口
    REQUSET_XZTK1011, //习正支付完成后 火车票(后台出票)业务
    REQUSET_XZALIPAY0001,//习正支付宝预下单
    REQUSET_XZALIPAY0002,//习正支付宝支付结果查询
    REQUSET_XZWeixinPay0001,//习正微信预下单
    REQUSET_XZWeixinPay0002,//习正微信支付结果查询
};

#define MOBILEMAC_CLIENTUPDATE                  @"ClientUpdate2"
#define MOBILEMAC_RETPWD                        @"RetrievePassword"
#define MOBILEMAC_CARDPAY                       @"JFPalCardPay"
#define MOBILEMAC_ACCTPAY                       @"JFPalAcctPay"
#define MOBILEMAC_UPPWD                         @"UserUpdatePwd"
#define MOBILEMAC_REGISTER                      @"UserRegister"
#define MONILEMAC_USERINFO                      @"UserInfoQuery"
#define MONILEMAC_ORDERINFO                     @"REQUSET_ORDER"
#define MONILEMAC_MOBILEMAC                     @"GetMobileMac"
#define MONILEMAC_LOGIN                         @"UserLogin"
#define MONILEMAC_USERUPDATAINFO                @"UserUpdateInfo"
#define MONILEMAC_USERIDENTITYPICUPLOAD         @"UserIdentityPicUpload2"
#define MOBILEMAC_ORDER                         @"RequestOrder"
#define MOBILEMAC_ACCTENQUIRY                   @"JFPalAcctEnquiry"//虚拟账户余额查询接口
#define MOBILEMAC_COMMODITYLIST                 @"CommodityList"
#define MOBILEMAC_GETBANKLIST                   @"GetBankCardList2"
#define MOBILEMAC_USERAGREEMENT                 @"UserAgreement"
#define MOBILEMAC_RETPWD                        @"RetrievePassword"
#define MOBILEMAC_CHANGEPASSWORD                @"UserUpdatePwd"
#define MOBILEMAC_CARDPAY                       @"JFPalCardPay"
#define MOBILEMAC_ACCTPAY                       @"JFPalAcctPay"
#define MOBILEMAC_UPPWD                         @"UserUpdatePwd"
#define MOBILEMAC_REGISTER                      @"UserRegister"
#define MONILEMAC_USERINFO                      @"UserInfoQuery"
#define MONILEMAC_ORDERINFO                     @"REQUSET_ORDER"
#define MONILEMAC_MOBILEMAC                     @"GetMobileMac"
#define MONILEMAC_LOGIN                         @"UserLogin"
#define MONILEMAC_USERUPDATAINFO                @"UserUpdateInfo"
#define MONILEMAC_USERIDENTITYPICUPLOAD         @"UserIdentityPicUpload2"
#define MOBILEMAC_ORDER                         @"RequestOrder"
#define MOBILEMAC_ACCTENQUIRY                   @"JFPalAcctEnquiry"
#define MOBILEMAC_COMMODITYLIST                 @"CommodityList"
#define MOBILEMAC_ADDCOMMODITY                  @"AddCommodity"
#define MOBILEMAC_DELETECOMMODITY               @"DeleteCommodity"
#define MOBILEMAC_EDITCOMMODITY                 @"EditCommodity"
#define MOBILEMAC_GETBANKLIST                   @"GetBankCardList2"
#define MOBILEMAC_MESGLIST                      @"MsgList"
#define MOBILEMAC_CITIESCODE                    @"CitiesCode"
#define MOBILEMAC_BANK                          @"GetBankHeadQuarter"
#define MOBILEMAC_BANKOFBRANCH                  @"GetBankBranch"
#define MOBILEMAC_BANKCARDBIND                  @"BankCardBind"
#define MOBILEMAC_BANKCARDUNBIND                @"BankCardUnBind"//盛迪嘉无卡支付解绑银行卡

#define MOBILEMAC_RECORDLIST                    @"RecordList"
#define MOBILEMAC_RECORDDETAIL                  @"RecordDetail"
#define MOBILEMAC_MYPOS                         @"MyPos"
#define MOBILEMAC_CARDBALANCE                   @"BankCardBalance"
#define MOBILEMAC_JFPALCARDPAY                  @"JFPalCardPay"//刷卡支付接口
#define MOBILEMAC_CARDTOCARDPAY                 @"CardToCardPay"//卡卡转账-刷卡支付接口
#define MOBILEMAC_JFPALCARDPAYFORSTORE          @"JFPalCardPayforStore"
#define MOBILEMAC_JFPALACCTPAY                  @"JFPalAcctPay"
#define MOBILEMAC_JFPALCASH                     @"JFPalCash"//提现接口
#define MOBILEMAC_AGENTCASH                     @"AgentCash"//我的分润提现
#define MOBILEMAC_USERSIGNATUREUPLOAD           @"UserSignatureUpload"
#define MOBILEMAC_GETQUICKBANKCARD              @"GetQuickBankCard"//获取无卡支付银行卡列表
#define MOBILEMAC_UNBINDQUICKBANKCARD           @"UnbindQuickBankCard"
#define MOBILEMAC_QUICKBANKCARDQUERY            @"QuickBankCardQuery"//无卡支付查询卡信息
#define MOBILEMAC_QUICKBANKCARDAPPLY            @"QuickBankCardApply"
#define MOBILEMAC_QUICKBANKCARDCONFIRM          @"QuickBankCardConfirm"
#define MOBILEMAC_QUICKBANKCARDMSG              @"QuickBankCardMsg"//发送无卡支付验证短信
#define MOBILEMAC_GETCHANNELAPPLICATION         @"Channel"
#define MOBILEMAC_QUERYCREDITINFO               @"QueryCreditInfo"
#define MOBILEMAC_CARDTOCAR                     @"CardToCard"
#define MOBILEMAC_BINDQUICKPAYPSAM              @"BindQuickPayPSAM"
#define MOBILEMAC_GETQUICKPAYPSAM               @"GetQuickPayPSAM"
#define MONILEMAC_QUERYSCANMONEY                @"QueryScanMoney"//扫码支付接口
#define MONILEMAC_CARDBINQUERY                  @"CardBinQuery"//快捷支付验证银行卡卡信息接口
#define MONILEMAC_QUICKBANKAUTHENT              @"QuickBankAuthent"//绑定无卡支付银行卡
#define MONILEMAC_SENDDYNAMICCODE               @"SendDynamicCode"//快捷支付获取验证码接口
#define MONILEMAC_CHECKDYNAMICCODE              @"CheckDynamicCode"//验证快捷支付短信验证码
#define MONILEMAC_QUICKBANKCARDCONFIRM          @"QuickBankCardConfirm"//快捷支付--支付接口


#define MONILEMAC_QUERYBINDWEIXINORDERSTATE     @"queryBindWeixinOrderState"//查询注册微信状态接口
#define MONILEMAC_REGISTERWEIXINPAY             @"registerWeixinPay"//注册微信商户

#define MONILEMAC_VERIFYWEIXINPAY               @"verifyWeixinPay"//微信收款绑定银行卡接口

#define MONILEMAC_PREPAYALLOW                   @"prepayAllow"//微信支付获取二维码接口

#define MONILEMAC_QUERYWEIXINORDERSTATE         @"queryWeixinOrderState"//微信支付订单查询

#define MONILEMAC_GETSDJQUICKBANKCARD           @"GetSdjQuickBankCard"//获取盛迪嘉无卡支付银行卡列表

#define MONILEMAC_QUICKBANKCARDCOMFIRMSDJSMS    @"QuickBankCardComfirmSdjSms"////盛迪嘉无卡支付绑定银行卡--获取短信验证接口
#define MONILEMAC_QUICKBANKCARDPAYSDJ           @"QuickBankCardPaySdj"//盛迪嘉无卡支付绑定银行卡接口

#define MONILEMAC_QUICKBANKCARDPAYSDJSMS        @"QuickBankCardPaySdjSms"//盛迪嘉无卡支付--支付短信验证码

#define MONILEMAC_QUICKBANKCARDCOMFIRMSDJ       @"QuickBankCardComfirmSdj"//盛迪嘉无卡支付--支付接口

#define MONILEMAC_SZHCPTicketPay                                @"TicketPay" //习正火车票最后锁票成功后发送捷丰后台


@interface Request : NSObject

- (instancetype)initWithDelegate:(NSObject<ResponseData>*)delegate;

// 用户登录请求
- (void)userLoginWithAccount:(NSString*)account password:(NSString*)password;
// 获取验证码
- (void)getMobileMacWithAccount:(NSString*)account appType:(NSString*)type;

////版本更新
-(void)ClientUpdateInstrVersion:(NSString *)instrVersion dateType:(NSString *)dateType;
//注册
- (void)userSignWithAccount:(NSString *)account password:(NSString *)password mobileMac:(NSString *)mobileMac;
//用户协议
-(void)userAgreement;


//找回密码
- (void)backPasswordWithMobileNo:(NSString *)mobileNo newPassword:(NSString *)newPassword cardID:(NSString *)cardID mobileMac:(NSString *)mobileMac realNmae:(NSString *)realNmae;
//查询用户信息接口字段
- (void)userInfo:(NSString*)mobileNo;

//虚拟账户余额查询接口
- (void)getVirtualAccountBalance:(NSString*)accType token:(NSString*)token;

//申请交易订单
- (void)applyOrderMobileNo:(NSString *)mobileNo MerchanId:(NSString*)merchantId productId:(NSString*)productId orderAmt:(NSString *)orderAmt orderDesc:(NSString*)orderDesc orderRemark:(NSString*)orderRemark commodityIDs:(NSString *)commodityIDs payTool:(NSString*)payTool;


//实名认证资料（上传头像的前一步骤）
- (void)realNameAuthentication:(NSString *)realName ID:(NSString *)ID;
//上传头像
-(void)upPhotoImage:(NSData*)imageStr;

- (void)getMallListmobile:(NSString *)mobileNo firstData:(NSString *)firstData lastData:(NSString *)lastData dataSize:(NSString *)dataSize requestType:(NSString *)requestType;
//添加商城列表数据
- (void)addMallDataMobileNo:(NSString *)mobileNo icon:(NSString *)icon title:(NSString *)title price:(NSString *)price amount:(NSString *)amount;
//删除商品数据
- (void)DeleteMallDataMobileNo:(NSString *)mobileNo commodityID:(NSString *)commodityID;
//修改商品数据
- (void)changeMallDataMobileNo:(NSString *)mobileNo commodityID:(NSString *)commodityID icon:(NSString *)icon title:(NSString *)title price:(NSString *)price amount:(NSString *)amount;
// 获取频道信息
- (void)getChannel;

//上传身份证正面
-(void)upIDcardPositive:(NSData*)imageStr;

//上传身份证反面
-(void)upIDcardReverse:(NSData*)imageStr;

//银行卡列表
-(void)bankListAndbindType:(NSString*)bindType;
//银行所在城市
-(void)BankofCity:(NSString *)provinceCode;

//银行所在省份
-(void)BankofProvinces;

//总行
-(void)GetBankHeadQuarter;

//支行
-(void)GetBranch;

//绑定卡
-(void):(NSString*)accountNumber andBandType:(NSString*)bandType;

//绑定支付宝银行卡
-(void)ZFBBankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType bankName:(NSString *)bankName;

//微信收款绑定银行卡
- (void)WeixinCardAuthentcardappUser:(NSString *)appUser cardOwner:(NSString *)cardOwner bankId:(NSString *)bankId bankName:(NSString *)bankName bankBranchId:(NSString *)bankBranchId bankBranchName:(NSString *)bankBranchName provinceId:(NSString *)provinceId bankProvince:(NSString *)bankProvince cityId:(NSString *)cityId bankCity:(NSString *)bankCity cardNo:(NSString *)cardNo phone:(NSString *)phone real_name:(NSString *)real_name cmer:(NSString *)cmer cert_no:(NSString *)cert_no mobile:(NSString *)mobile;

//获取二维码接口
- (void)prepayAllowtotalFee:(NSString *)totalFee orderId:(NSString *)orderId Info:(NSString *)Info acctNo2:(NSString *)acctNo2;

//交易记录列表
-(void)recordList:(NSString *)filter andFirstMsgID:(NSString *)firstMsgID andLastMsgID:(NSString *)lastMsgID andRequestType:(NSString *)requestType;

//交易详情
-(void)recordDetail:(NSString *)recordID andTime:(NSString *)time;

//我的刷卡器
-(void)myCreditCardMachine;

//查询卡余额
- (void)checkMyCardBalance:(NSString*)cardInfo cardPassWord:(NSString*)cardPassWord iccardInfo:(NSString*)ICCardInfo ICCardSerial:(NSString*)ICCardSerial ICCardValidDate:(NSString*)ICCardValidDate merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId encodeType:(NSString*)encodeType;
//商城刷卡支付
- (void)mallCardPay:(NSString *)cardInfo cardPassWord:(NSString *)cardPassword iccardInfo:(NSString *)ICCardInfo ICCardSerial:(NSString *)ICCardSerial ICCardValidDate:(NSString *)ICCardValidDate merchantId:(NSString *)merchantId productId:(NSString *)productId orderId:(NSString *)orderId encodeType:(NSString *)encodeType orderAmt:(NSString *)orderAmt payType:(NSString*)payType;
//支付接口
- (void)cardPay:(NSString*)cardInfo cardPassWord:(NSString*)cardPassword iccardInfo:(NSString*)ICCardInfo ICCardSerial:(NSString*)ICCardSerial ICCardValidDate:(NSString*)ICCardValidDate merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId  encodeType:(NSString*)encodeType orderAmt:(NSString*)orderAmt payType:(NSString*)payType;
//卡卡转账支付接口1
- (void)CardToCardPay:(NSString*)cardInfo cardPassWord:(NSString*)cardPassword iccardInfo:(NSString*)ICCardInfo ICCardSerial:(NSString*)ICCardSerial ICCardValidDate:(NSString*)ICCardValidDate merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId  encodeType:(NSString*)encodeType orderAmt:(NSString*)orderAmt payType:(NSString*)payType;
//卡卡转账支付接口
- (void)CardToCardPay:(NSString *)custName mobile:(NSString *)mobile merchantId:(NSString *)merchantId productId:(NSString *)productId ICDat:(NSString *)ICDat CrdSqn:(NSString *)CrdSqn cardType:(NSString *)cardType TExpDat:(NSString *)TExpDat PinBlk:(NSString *)PinBlk cardNoIn:(NSString *)cardNoIn orderNo:(NSString *)orderNo mobileNo:(NSString *)mobileNo CTxnAt:(NSString *)CTxnAt appUser:(NSString *)appUser Track2:(NSString *)Track2;
//信用卡还款--绑定银行卡
-(void)BankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andcustName:(NSString *)custName andBandType:(NSString*)bandType;

//账户支付
- (void)acctPay:(NSString*)mobileNo encodetype:(NSString*)encodetype password:(NSString*)password mobileMac:(NSString*)mobileMac acctType:(NSString*)acctType merchantId:(NSString*)merchantId productId:(NSString*)productId orderId:(NSString*)orderId orderAmt:(NSString*)orderAmt encodeType:(NSString*)encodeType payType:(NSString*)payType;
//提现
-(void)takeCash:(NSString *)cashAmt andPassword:(NSString *)password andMobileMac:(NSString *)mobileMac andCashType:(NSString *)cashType andCardTag:(NSString *)cardTag andCardIdx:(NSString *)cardIdx;
//我的分润提现
-(void)AgentCash:(NSString *)cashAmt andPassword:(NSString *)password andMobileMac:(NSString *)mobileMac andCashType:(NSString *)cashType andCardTag:(NSString *)cardTag andCardIdx:(NSString *)cardIdx;
//威富通获取二维码接口
- (void)postCodeImageWihtorderID:(NSString*)orderId orderAmT:(NSString*)orderAmt;


#pragma mark ------盛迪嘉无卡支付
//获取盛迪嘉无卡支付银行卡列表
- (void)GetSdjQuickBankCard;
//盛迪嘉无卡支付绑定银行卡--获取短信验证接口
- (void)QuickBankCardComfirmSdjSmsWithbindID:(NSString *)bindID mobileNo:(NSString *)mobileNo;
//盛迪嘉无卡支付绑定银行卡
- (void)QuickBankCardPaySdjWithorderId:(NSString *)orderId cardNo:(NSString *)cardNo customerName:(NSString *)customerName legalCertType:(NSString *)legalCertType legalCertPid:(NSString *)legalCertPid cardType:(NSString *)cardType referrerMobileNo:(NSString *)referrerMobileNo mobileNo:(NSString *)mobileNo phone:(NSString *)phone bankCode:(NSString *)bankCode unitBankCode:(NSString *)unitBankCode;
//盛迪嘉无卡支付--支付短信验证码
- (void)QuickBankCardPaySdjSmsWithorderAmt:(NSString *)orderAmt mobileNo:(NSString *)mobileNo;
//盛迪嘉无卡支付--支付接口
- (void)QuickBankCardComfirmSdjWithorderId:(NSString *)orderId orderAmt:(NSString *)orderAmt cardNo:(NSString *)cardNo customerName:(NSString *)customerName legalCertPid:(NSString *)legalCertPid bankCode:(NSString *)bankCode mobileNo:(NSString *)mobileNo referrerMobileNo:(NSString *)referrerMobileNo;

#pragma mark - 无卡支付
//获取无卡支付绑定银行卡列表
- (void)getQuickPayMyCardList;
//解绑无卡支付银行卡
- (void)quickPayBankCardUnbind:(NSString*)bindId newBindId:(NSString *)newbindid orderId:(NSString *)orderId;
//绑定快捷支付银行卡
- (void)QuickBankAuthent:(NSString *)mobileNo ValiDate:(NSString *)valiDate CustomerName:(NSString *)customerName CustomerId:(NSString *)customerId LegalCertPid:(NSString *)legalCertPid Cvn:(NSString *)cvn orderTime:(NSString *)orderTime  LegalCertType:(NSString *)legalCertType CardNo:(NSString *)cardNo CardType:(NSString *)cardType OrderId:(NSString *)orderId BankName:(NSString *)bankName;
//快捷支付--支付接口
- (void)QuickBankCardConfirmCardNo:(NSString *)cardNo mobileNo:(NSString *)mobileNo password:(NSString *)password newbindid:(NSString *)newbindid transDate:(NSString *)transDate transTime:(NSString *)transTime orderTime:(NSString *)orderTime customerId:(NSString *)customerId customerName:(NSString *)customerName cardType:(NSString *)cardType bankName:(NSString *)bankName orderAmt:(NSString *)orderAmt orderId:(NSString *)orderId PinBlk:(NSString *)PinBlk;
//获取快捷支付短信验证码
- (void)SendDynamicCode:(NSString *)newbindid mobileNo:(NSString *)mobileNo;
//验证快捷支付短信验证码
- (void)CheckDynamicCode:(NSString *)newbindid mobileNo:(NSString *)mobileNo dynameic:(NSString *)dynameic;

//快捷支付验证银行卡信息
- (void)checkBankCardNo:(NSString*)cardNo;
//查询银行卡信息
- (void)checkBankCardInfo:(NSString*)cardNo;
//无卡支付申请
- (void)applyForQuickPay:(NSString*)name IDCard:(NSString*)IDCard cardNo:(NSString*)cardNo vaild:(NSString*)vaild cvv2:(NSString*)cvv2 phone:(NSString*)phone orderID:(NSString*)orderID bindID:(NSString*)bindID orderAmt:(NSString*)orderAmt productId:(NSString*)productId merchantId:(NSString*)merchantId;
//确认无卡支付
- (void)enSureQuickPay:(NSString*)validateCode orderID:(NSString*)orderID;
//发送无卡支付验证短信
- (void)getQuickPayCode:(NSString*)orderID;

//上传签名图片
- (void)UserSignatureUploadMobile:(NSString *)mobile longitude:(NSString *)logitude latitude:(NSString *)latitude merchantId:(NSString *)merchantId orderId:(NSString *)orderId signPicAscii:(NSString *)signPicAscii picSign:(NSString *)picSign;

//消息
-(void)msgList:(NSString *)firstMsgID andLastMsgID:(NSString *)lastMsgID andRequestType:(NSString *)requestType;

//修改密码
- (void)changePasswordWithMobileNo:(NSString *)mobileNo newPassword:(NSString *)newPassword olePassword:(NSString *)olePassword mobileMac:(NSString *)mobileMac;
//解除银行卡绑定
-(void)BankCardUnBind:(NSString *)cardldx;


//注册微信商户
- (void)registerWeixinPayphone:(NSString *)phone;

//查询注册微信状态
- (void)queryBindWeixinOrderStatephone:(NSString *)phone;

//微信支付订单成功状态查询
- (void)queryWeixinOrderStateorderId:(NSString *)orderId;

//功能频道开关
- (void)getChannelApplication;
//信用卡信息查询
- (void)checkCreditCardInfo:(NSString*)realName cardNum:(NSString*)accountNo;
//绑定信用卡
-(void)CreditCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType;

//绑定银行卡
//-(void)BankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType;

//绑定银行卡
-(void)BankCardBind:(NSString*)accountNumber andMobile:(NSString *)mobile andBandType:(NSString*)bandType bankName:(NSString *)bankName;

//绑定快捷⽀支付认证码
-(void)quickPayCode:(NSString*)organization;

// 查询快捷⽀支付认证码绑定状态
-(void)quickPayCodeState;

//扫码支付接口
-(void)queryScanMoneyWithOrderNo:(NSString *)orderNo;







/////
//获取理财产品列表
-(void)getManageListWithBranchname:(NSString*)appuser userid:(NSString*)telephontNum;
//查询我的理财资产接口
-(void)getMyMangeZiChanList;
//5、查看持有产品列表(持有中)
-(void)getHoldingList;
//8、开通理财账户
-(void)getZhuce;
//9、查看赎回产品列表 (已赎回)
-(void)showHadRedeem;
//2.产品详情
-(void)getProductDitailWithID:(NSString*)productID;
//3、申购产品 生成订单接口
-(void)getManageProductOrderWithProductID:(NSString*)ProductID Number:(NSNumber*)number amt:(NSNumber*)amt tranType:(NSString *)type;








//中农信合(溯源商城和跨境电商)产品列表接口
- (void)getProductIdWithCardId:(NSString*)cardId;
- (void)sendInfo;
- (void)getAD;
- (void)getProductWithCardId:(NSString*)cardId;
- (void)getInfoWithMobile:(NSString*)mobile;
- (void)getDetailInfoWithProductId:(NSString*)productId withTraceabilityId:(NSString*)traceabilityId;
- (void)getMoneyInfoWithProductId:(NSString*)productId productList:(id)productlist;
- (void)getTodyKillProductWithCardId:(NSString*)cardId;//今日秒杀商城
//- (void)getTodyKillProductWithCateId:(NSString*)cateId;//今日秒杀商城
- (void)getMastmallProductWithCardId:(NSString*)cateId;//百步商城
- (void)getCrossBorderProductWithCardId:(NSString*)cateId;//跨境电商
- (void)gettotalMoneyWithProductLists:(NSArray*)productlists withMobile:(NSString *)mobile withTotal:(NSString*)total;
//产品详情里--商品溯源接口
- (void)getproductId:(NSString*)productId;
- (void)getMallorderId:(NSString *)orderId ordStatus:(NSString *)ordStatus transStatus:(NSString *)transStatus receiverName:(NSString *)receiverName receiverPhone:(NSString *)receiverPhone receiverAddress:(NSString *)receiverAddress cardNo:(NSString *)cardNo txnAmt:(NSString *)txnAmt;//商城交易完成后 向习正发送支付状态接口




/********************习正手机充值接口**************************************/
//习正手机充值业务接口1
-(void)postPhoneRechargeOnwOrderId:(NSString*)orderId moneyAmt:(NSString*)moneyAmt mobileNo:(NSString*)mobile;
//习正手机充值业务接口2
-(void)postPhoneRechargeTwoOrderId:(NSString*)orderId;


//``````````````````````````````````````````````````````````````````````习正火车票查询``````````````````
//3.1 查询车次
- (void)checkTrainInfoBusType:(NSString*)busType orgID:(NSString*)orgId termID:(NSString*)termId trainDate:(NSString*)traindate fromStation:(NSString*)fromstation toStation:(NSString*)tostation purposeCodes:(NSString*)purposecodes;
//3.2 登录12306
-(void)logIN12306TermId:(NSString*)termID orgID:(NSString*)orgid busType:(NSString*)busType userName:(NSString*)username password:(NSString*)password;
//3.3下单接口
-(void)getProOrdNoWithtermId:(NSString*)termID orgId:(NSString*)orgID busType:(NSString*)busTypE checi:(NSString*)checI from_station_code:(NSString*)from_station_codE from_station_name:(NSString*)from_station_namE to_station_code:(NSString*)to_station_codE to_station_name:(NSString*)to_station_namE train_date:(NSString*)train_datE
                  passengers:(NSString*)passengerS mobile:(NSString*)mobilE zmoney:(NSString*)zmoneY uprice:(NSString*)upricE fee:(NSString*)feE count:(NSString*)counT;
//3.4 习正业务处理接口(出票)
-(void)getTrainTicketsWithprdOrdNo:(NSString*)prdOrdNO termId:(NSString*)termID orgId:(NSString*)orgID busType:(NSString*)busTypE isGrab:(NSString*)isGraB deadline:(NSString*)deadlinE;
//4.1支付宝 / 微信 预下单接口
-(void)trainTicketPayBuyZFBOrderWithID:(NSString*)orderID type:(NSInteger)type;
//4.2 支付宝 / 微信 支付结果查询
-(void)trainTicketPayBuyZFBOrderWithID:(NSString*)orderID readeID:(NSString*)tradeId type:(NSInteger)type;
//5.1 锁票成功 发送数据到捷丰后台
-(void)trainTicketPayToJiefengWithorderId:(NSString*)orderID orderNo:(NSString*)orderNO;









/**************************独立商品溯源************************************/
// 查询溯源企业
- (void)getCompanySYwihtName:(NSString*)name fieldNames:(NSString*)fieldNames regionCity:(NSString*)regionCity pageNo:(NSString*)pageNo pageSize:(NSString*)pageSize Bool:(BOOL)yes;
/**
 * 根据企业ID、条码或名称查询匹配的企业产品列表
 */
-(void)getCompanyListWithID:(NSString*)ID pageNo:(NSString*)pageNO pageSize:(NSString*)pagesize;
/**
 *3.4根据ID的产品查询
 */
- (void)getProductInfoWihtID:(NSString*)ID;
/**
 *3.5最近三笔三笔进货记录查询
 */
- (void)getProductInfoNearLyThreeList:(NSString*)CodeID;
/**
 *3.6追溯码的追溯查询
 */
-(void)getProductNodeListProductID:(NSString*)ID productionDate:(NSString*)date batch:(NSString*)batch;

//3.2平台产品分类查询
-(void)getProductSYcategories;
/**7
 * 根据产品名称查产品列表
 * */
-(void)getProductSYcategoriesWithName:(NSString*)name pageNo:(NSString*)pageNo pageSIze:(NSString*)pageSize;
//**6snCode搜索
- (void)getProductSYInfoByScCode:(NSString*)code;
// 投诉接口
- (void)postComplaintWithtagId:(NSString*)tagId tagSn:(NSString*)tagSn tagSnProducerCode:(NSString*)tagSnProducerCode enterpriseId:(NSString*)enterpriseId productId:(NSString*)productId  userName:(NSString*)userName mobile:(NSString*)mobile comments:(NSString*)comments;



@end
