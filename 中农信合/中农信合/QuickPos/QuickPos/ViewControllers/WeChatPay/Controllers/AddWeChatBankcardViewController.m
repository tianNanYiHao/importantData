//
//  AddWeChatBankcardViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/12.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "AddWeChatBankcardViewController.h"
#import "BankListViewController.h"
#import "AccountOfProvincesViewController.h"
#import "AccountOfCityViewController.h"
#import "BankOfBranchViewController.h"
#import "PayType.h"
#import "TakeCashViewController.h"
#import "TransferViewController.h"
#import "CreditCardPayDetailViewController.h"
#import "Common.h"
#import "UserInfo.h"
#import "ObtainScanViewController.h"
#import "TSTWechatViewController.h"



@interface AddWeChatBankcardViewController ()<UITextFieldDelegate,ResponseData>{

    
    NSUserDefaults *userDefaults;//存取
    NSDictionary *dataDic;//请求返回字典
    
    Request *request;
    
    int banktag;//银行类标记
    int provincestag;//省份类标记
    int citytag;//城市类标记
    int branchtag;//支行类标记
    
    BankCardItem *item;
    UserInfo *info;
    
    
}
@property (weak, nonatomic) IBOutlet UIButton *comfirtbtn;

@property (weak, nonatomic) IBOutlet UIView *ios6UseAddView;//用于ios6显示

@property (weak, nonatomic) IBOutlet UITextField *bankCardNumberTextField;//银行卡输入框

@property (weak, nonatomic) IBOutlet UIView *confirmBankCardNumberTextFiedBg;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;//手机号


@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;//真实姓名输入框

@property (weak, nonatomic) IBOutlet UILabel *IDNumberLabel;//身份证号

@property (weak, nonatomic) IBOutlet UITextField *IDNumberTextField;//身份证号textField



@property (weak, nonatomic) IBOutlet UIView *bankCardNumberTextFieldBg;//银行卡输入框容器view

@property (weak, nonatomic) IBOutlet UIView *bankBelongTextFieldBg;//总行输入框容器view

@property (weak, nonatomic) IBOutlet UIView *accountOfProvincesTextFieldBg;//省份输入框容器view

@property (weak, nonatomic) IBOutlet UIView *accountOfCityTextFieldBg;//城市输入框容器view

@property (weak, nonatomic) IBOutlet UIView *accountOfBankDataTextFieldBg;//支行输入框容器view

@property (weak, nonatomic) IBOutlet UIButton *bankListButton;//总行

@property (weak, nonatomic) IBOutlet UIButton *provincesListButton;//省份

@property (weak, nonatomic) IBOutlet UIButton *cityListButton;//城市

@property (weak, nonatomic) IBOutlet UIButton *banchListButton;//支行

@property (weak, nonatomic) IBOutlet UIScrollView *addBankcardScrollView;

@property (nonatomic,strong) NSString *authenFlag;

@end



@implementation AddWeChatBankcardViewController


@synthesize destinationType;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    banktag = 1000;
    provincestag = 1001;
    citytag = 1002;
    branchtag = 1003;
    
    request = [[Request alloc]initWithDelegate:self];
    [request userInfo:[AppDelegate getUserBaseData].mobileNo];
    
    if(![UIDevice currentDevice].isIOS6){
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    //    self.ios6UseAddView.hidden = YES;
    //
    //    if([UIDevice currentDevice].isIOS6){
    //
    //        self.ios6UseAddView.hidden = NO;
    //
    //
    //    }else{
    //
    //        self.ios6UseAddView.hidden = YES;
    //
    //    }
    
    
    self.title = L(@"AddBankCard");
    self.comfirtbtn.layer.cornerRadius = 5;
    
    dataDic = [NSDictionary dictionary];
    item = [[BankCardItem alloc]init];
    
    self.realNameTextField.delegate = self;
    
    self.bankCardNumberTextFieldBg.layer.masksToBounds = YES;
    self.bankCardNumberTextFieldBg.layer.cornerRadius = 1;
    
    self.confirmBankCardNumberTextFiedBg.layer.masksToBounds = YES;
    self.confirmBankCardNumberTextFiedBg.layer.cornerRadius = 1;
    
    self.accountOfProvincesTextFieldBg.layer.masksToBounds = YES;
    self.bankCardNumberTextFieldBg.layer.cornerRadius = 1;
    
    self.accountOfProvincesTextFieldBg.layer.masksToBounds = YES;
    self.accountOfProvincesTextFieldBg.layer.cornerRadius = 1;
    
    self.accountOfCityTextFieldBg.layer.masksToBounds = YES;
    self.accountOfCityTextFieldBg.layer.cornerRadius = 1;
    
    self.accountOfBankDataTextFieldBg.layer.masksToBounds = YES;
    self.accountOfBankDataTextFieldBg.layer.cornerRadius = 1;
    
    self.bankCardNumberTextField.tintColor = [Common hexStringToColor:@"#068bf4"];
    self.phoneNumberTextField.tintColor = [Common hexStringToColor:@"#068bf4"];
    self.IDNumberTextField.tintColor = [Common hexStringToColor:@"#068bf4"];
    
    //自定义键盘
//        NumberKeyBoard *numberkeyboard = [[NumberKeyBoard alloc]init];
//        [numberkeyboard setTextView:self.bankCardNumberTextField];
//    
//        NumberKeyBoard *confirmNumberkeyboard = [[NumberKeyBoard alloc]init];
//        [confirmNumberkeyboard setTextView:self.confirmBankCardNumberTextFied];
    
    
    
    
}

-(void)viewDidLayoutSubviews
{
    
    if([UIDevice currentDevice].isIphone4){
        
        self.addBankcardScrollView.contentSize = CGSizeMake(0,500);
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.realNameTextField.text = [AppDelegate getUserBaseData].userName;
    self.realNameTextField.userInteractionEnabled = NO;
    //省份的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    //银行的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(banktongzhi:) name:@"banktongzhi" object:nil];
    
    //城市的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citytongzhi:) name:@"citytongzhi" object:nil];
    
    //支行的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(branchtongzhi:) name:@"branchtongzhi" object:nil];
    
//    NSString *s = self.banchListButton.titleLabel.text;
    
    
}



//省份赋值
- (void)tongzhi:(NSNotification *)text{
    
    
    NSDictionary *dic = (NSDictionary*)text.object;
    
    item.bankProvince = [dic objectForKey:@"provinceName"];
    item.bankProviceId = [dic objectForKey:@"provinceId"];
    
    [self.provincesListButton setTitle:item.bankProvince forState:UIControlStateNormal];
    
    NSLog(@"%@",text.object);
    NSLog(@"－－－－－接收到通知------");
    
    
}

//银行赋值
- (void)banktongzhi:(NSNotification *)text{
    
    
    NSDictionary *dic = (NSDictionary*)text.object;
    
    item.bankName = [dic objectForKey:@"bankName"];
    item.cardIdx = [dic objectForKey:@"bankId"];
    [self.bankListButton setTitle:item.bankName forState:UIControlStateNormal];
    
    NSLog(@"%@",text.object);
    NSLog(@"－－－－－接收到通知------");
    
    
}


//城市赋值
- (void)citytongzhi:(NSNotification *)text{
    
    
    
    NSDictionary *dic = (NSDictionary*)text.object;
    
    item.bankCity = [dic objectForKey:@"cityName"];
    item.bankCityId = [dic objectForKey:@"cityId"];
    
    
    [self.cityListButton setTitle:item.bankCity forState:UIControlStateNormal];
    
    
    
    NSLog(@"%@",text.object);
    NSLog(@"－－－－－接收到通知------");
    
    
}

//支行赋值
//- (void)branchtongzhi:(NSNotification *)text{
//    
//    
//    NSDictionary *dic = (NSDictionary*)text.object;
//    
//    item.branchBankName = [dic objectForKey:@"branchName"];
//    item.branchBankId = [dic objectForKey:@"branchId"];
//    
//    [self.banchListButton setTitle:item.branchBankName forState:UIControlStateNormal];
//    
//    
//    NSLog(@"%@",text.object);
//    NSLog(@"－－－－－接收到通知------");
//    
//    
//}

- (IBAction)addBankCard:(UIButton *)sender {
    

   
    if (self.bankCardNumberTextField.text.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputBankCardNumber")];
    }
    else if (self.bankCardNumberTextField.text.length < 16){
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectBankCardNumber")];
    }
    else if (self.bankCardNumberTextField.text.length > 23){
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputCorrectBankCardNumber")];
    }else if (self.phoneNumberTextField.text.length == 0){
    
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"手机号不能为空"];
    }else if (self.phoneNumberTextField.text.length != 11){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"手机号有误"];
    }else if (self.IDNumberTextField.text.length == 0){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"请输入身份证号码"];
    }else if (self.IDNumberTextField.text.length != 18){
        [MBProgressHUD showHUDAddedTo:self.view WithString:@"身份证号码有误"];
    }
    else if (banktag == 1000 || provincestag == 1001 || citytag == 1002 )
    {
         
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ImproveCardInformation")];
        
    }else{
        item.accountNo = self.bankCardNumberTextField.text;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"正在验证卡信息"];
        [request WeixinCardAuthentcardappUser:@""
                                        cardOwner:[AppDelegate getUserBaseData].userName
                                           bankId:item.cardIdx
                                         bankName:item.bankName
                                     bankBranchId:item.branchBankId
                                   bankBranchName:item.branchBankName
                                       provinceId:item.bankProviceId
                                     bankProvince:item.bankProvince
                                           cityId:item.bankCityId
                                         bankCity:item.bankCity
                                           cardNo:[self.bankCardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]
                                            phone:@""
                                        real_name:@""
                                             cmer:self.realNameTextField.text
                                          cert_no:self.IDNumberTextField.text
                                           mobile:self.phoneNumberTextField.text
        ];
    }
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    
    if ([dict[@"respCode"]isEqual:@"0000"]) {
        if(type == REQUSET_VERIFYWEIXINPAY ){
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ObtainScanViewController *ObtainScanVc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ObtainScanVc"];
            ObtainScanVc.acctNo2 = [self.bankCardNumberTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.navigationController pushViewController:ObtainScanVc animated:YES];
            //    TSTWechatViewController *ystWechat = [[TSTWechatViewController alloc] initWithNibName:@"TSTWechatViewController" bundle:nil];
            //    ystWechat.WeChatBankCardNum = _accountNo;
            //    [self.navigationController pushViewController:ystWechat animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else if (type == REQUSET_USERINFOQUERY){
            self.authenFlag = [[[dict objectForKey:@"data"]objectForKey:@"resultBean"]objectForKey:@"authenFlag"];
            NSLog(@"%@",self.authenFlag);
            if ([self.authenFlag isEqualToString:@"3"]) {
                
            }else
            {
                [Common showMsgBox:nil msg:@"请实名认证后,再进行操作" parentCtrl:self];
                self.bankCardNumberTextField.userInteractionEnabled = NO;
                self.IDNumberTextField.userInteractionEnabled = NO;
                self.phoneNumberTextField.userInteractionEnabled = NO;
                
            }
        }

    }
    else{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Common showMsgBox:nil msg:dict[@"respDesc"] parentCtrl:self];
        
    }
    
}
- (IBAction)CardNumberTextFildAct:(UITextField *)sender {
    
    
    
    
    
}

//输入银行卡号时,每4位,空格隔开
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.bankCardNumberTextField) {
            NSString *text = [self.bankCardNumberTextField text];
//        NSString *text = self.bankCardNumberTextField.text;
        
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        //        if (newString.length >= 20) {
        //            return NO;
        //        }
        
        [textField setText:newString];
        
    }else
    {
        return YES;
    }
    
    
    
    return NO;
}



- (IBAction)bankListAct:(UIButton *)sender {
    
    if(![self.bankCardNumberTextField.text isEqual:@""]){
        
        item.accountNo = self.bankCardNumberTextField.text;
        
        banktag =88;
        BankListViewController *BankList = [self.storyboard instantiateViewControllerWithIdentifier:@"banklistVC"];
        
        [self.navigationController pushViewController:BankList animated:YES];
        
    }else{
        
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"InputBankCardNumber")];
        
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField

{ if (!textField.window.isKeyWindow)
    
    [textField.window makeKeyAndVisible];
    
}

- (IBAction)provincesListAst:(UIButton *)sender {
    
    if(banktag == 88){
        
        AccountOfProvincesViewController *provincesVC = [self.storyboard instantiateViewControllerWithIdentifier:@"provincesVC"];
        
        provincestag = 99;
        
        [self.navigationController pushViewController:provincesVC animated:YES];
        
    }else if (banktag == 1000){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChooseBelongBank")];
        
        
    }
    
}


- (IBAction)cityListAct:(UIButton *)sender {
    
    if(provincestag == 99){
        
        AccountOfCityViewController*cityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"cityVC"];
        
        citytag = 77;
        
        [self.navigationController pushViewController:cityVC animated:YES];
        
    }else if(provincestag == 1001){
        
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChooseProvinces")];
        
    }
}

- (IBAction)banchListAct:(UIButton *)sender {
    
    if(citytag == 77){
        
        BankOfBranchViewController*branchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"branchVC"];
        
        branchtag = 66;
        
        [self.navigationController pushViewController:branchVC animated:YES];
        
    }else if (branchtag ==1003){
        
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"ChooseCity")];
        
    }
    
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isFirstResponder]) {
        
        [textField resignFirstResponder];
        
    }
    return YES;
}



@end
