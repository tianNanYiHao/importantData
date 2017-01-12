
//
//  PhoneRechargeViewController.m
//  QuickPos
//
//  Created by 张倡榕 on 15/3/6.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "PhoneRechargeViewController.h"
#import "NumberKeyBoard.h"
#import "Common.h"
#import "Request.h"
#import "UserBaseData.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "UserInfoView.h"
#import "OrderViewController.h"
#import "OrderData.h"
#import "PayType.h"
#import "ChooseView.h"
#import "MBProgressHUD+Add.h"
#import "ROllLabel.h"
#import "RadioButton.h"


@interface PhoneRechargeViewController ()<ResponseData,ABPeoplePickerNavigationControllerDelegate,ChooseViewDelegate>{
    NSUInteger payType;//账户支付 刷卡支付 快捷支付
    Request *request;
    OrderData *orderData;
    MBProgressHUD *hud;
    NSString *_merchID;
    NSString *_productID;
}
@property (weak, nonatomic) IBOutlet UIButton *phoneRechargeBtn;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *payTypeSeg;
@property (weak, nonatomic) IBOutlet UIView *_subview;

@property (weak, nonatomic) IBOutlet UIButton *comfirtButton;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewA;
@property (weak, nonatomic) IBOutlet RadioButton *button11;//刷卡支付按钮
@property (weak, nonatomic) IBOutlet RadioButton *button22;//快捷支付按钮


@end

@implementation PhoneRechargeViewController
- (IBAction)ShowHide:(id)sender {
    self.pickerViewA.hidden = !self.pickerViewA.hidden;
}

- (IBAction)changePayType:(RadioButton*)sender {
    if (sender.tag == 11) {
        payType = CardPayType;
        _merchID = @"0001000001";
        _productID = @"0000000000";
        
    }
    if (sender.tag == 22) {
         payType = QuickPayType;
        _merchID = @"0001000001";
        _productID = @"0000000001";
    }
    
}

@synthesize payLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    payLabel.text = @"¥10";
    self.title = @"手机充值";

    self.pickerViewA.hidden = YES;
    self.comfirtButton.layer.cornerRadius = 5;

    payType = CardPayType;
    _button11.groupButtons = @[_button11,_button22];
    _button11.selected = YES;
    _button22.hidden = YES;
    
    //自定义键盘
//    NumberKeyBoard*numberkeyboard=[[NumberKeyBoard alloc]init];
//    [numberkeyboard setTextView:self.phoneNumberTextField];
     self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _merchID = @"0001000001";
    _productID = @"0000000000";
      request = [[Request alloc]initWithDelegate:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择通讯录
- (IBAction)chooseAddressBook:(UIButton *)sender {
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
    [self presentViewController:peoplePicker animated:YES completion:^{
        
    }];
}

#pragma mark  - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneMulti, i));
        [phones addObject:aPhone];
        
    }
    NSLog(@"+qqqqqqqqqq++++%@",phones);
    NSLog(@"****************");
    NSString *mobileNo = [phones objectAtIndex:0];
    NSMutableString *newMobileNo = [NSMutableString stringWithString:@""];
    for (int i = 0; i < mobileNo.length; i ++) {
        NSString *str = [mobileNo substringWithRange:NSMakeRange(i, 1)];
        if (![str isEqualToString:@"-"]) {
            [newMobileNo appendString:str];
        }
    }
    if ([newMobileNo hasPrefix:@"+86 "]){
        newMobileNo = [NSMutableString stringWithString:[newMobileNo substringFromIndex:newMobileNo.length-11]];
    }
    
        self.phoneNumberTextField.text = newMobileNo;
    
    //    self.label.text = (NSString*)ABRecordCopyCompositeName(person);
    NSLog(@"++++++++++++++++++++%@",newMobileNo);
    [self dismissViewControllerAnimated:YES completion:^{
    }];

}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark - 确认充值
- (IBAction)phoneRecharge:(UIButton *)sender {
    if([Common isPhoneNumber:self.phoneNumberTextField.text]){
        
        //去¥
        NSString *m = [self.payLabel.text substringFromIndex:1];
        NSString *orderAmt = [Common orderAmtFormat:m];
      

//        //账户支付
//        if(payType == AccountPayType){
//           [request getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];
//        }
            //刷卡支付
            if (payType == CardPayType){
            
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:_merchID productId:_productID orderAmt:orderAmt orderDesc:self.phoneNumberTextField.text orderRemark:@"" commodityIDs:@"" payTool:@"01"];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderIsSubmitted")];
        }else{
            //快捷支付
            [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo
                              MerchanId:_merchID
                              productId:_productID
                               orderAmt:orderAmt
                              orderDesc:self.phoneNumberTextField.text
                            orderRemark:@""
                           commodityIDs:@""
                                payTool:@"03"];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"OrderIsSubmitted")];
        }

    }else{

        [Common showMsgBox:@"" msg:L(@"MobilePhoneNumberIsWrong") parentCtrl:self];
        
    }
    
}


- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if ([[dict objectForKey:@"respCode"]isEqualToString:@"0000"]) {
        if (type == REQUEST_USERLOGIN) {
            
            UserBaseData *u = [[UserBaseData alloc]initWithData:dict];
            if (u) {
                [AppDelegate getUserBaseData].token = u.token;
            }
            
        }else if(type == REQUEST_ACCTENQUIRY){
            //查询虚拟账户余额
            if([[dict objectForKey:@"availableAmt"] floatValue]>[self.payLabel.text floatValue]){
                //余额够
                NSString *orderAmt = [Common orderAmtFormat:self.payLabel.text];
                [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:_merchID productId:_productID orderAmt:orderAmt orderDesc:self.phoneNumberTextField.text orderRemark:@"" commodityIDs:@"" payTool:@"02"];
            
            }else{
                
                 [Common showMsgBox:@"" msg:L(@"AccountBalanceIsInsufficient") parentCtrl:self];
            
            }
            NSLog(@"availableAmt===%@",[dict objectForKey:@"availableAmt"]);
            NSLog(@"cashAvailableAmt===%@",[dict objectForKey:@"cashAvailableAmt"]);
            
        }else if(type == REQUSET_ORDER){  // 申请订单成功
            [hud hide:YES];
           
            if ([[dict objectForKey:@"respCode"] isEqualToString:@"0000"]) {
                NSString *orderID = [dict objectForKey:@"orderId"];
                NSString *amt = [dict objectForKey:@"orderAmt"];
                NSString *mob = [dict objectForKey:@"orderDesc"];
//                [request postPhoneRechargeOnwOrderId:orderID moneyAmt:amt mobileNo:mob];  //习正鸟接口 暂时不走
            }
            OrderViewController *shopVc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderViewController"];
            orderData = [[OrderData alloc]initWithData:dict];
            orderData.orderAccount = [AppDelegate getUserBaseData].mobileNo;
            orderData.orderPayType = payType;
            orderData.merchantId = _merchID;
            orderData.productId = _productID;
            //            orderData.mallOrder = YES;
            shopVc.orderData = orderData;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.navigationController pushViewController:shopVc animated:YES];
        }
        
    }else{

        [Common showMsgBox:@"" msg:[dict objectForKey:@"respDesc"] parentCtrl:self];
    }
    
}


#pragma mark - pickerView 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //拾取视图的列数
    return 1;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return [NSString stringWithFormat:@"￥%d",10];
    }else if (row == 1) {
        return [NSString stringWithFormat:@"￥%d",30];
    }else if (row == 2) {
        return [NSString stringWithFormat:@"￥%d",50];
    }else if (row == 3) {
        return [NSString stringWithFormat:@"￥%d",100];
    }else if (row == 4) {
        return [NSString stringWithFormat:@"￥%d",200];
    }else if (row == 5) {
        return [NSString stringWithFormat:@"￥%d",300];
    }
    else {
        return [NSString stringWithFormat:@"￥%d",500];
    }
    
    
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 7;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *numArr = @[@"￥10",@"￥30",@"￥50",@"￥100",@"￥200",@"￥300",@"￥500"];
    payLabel.text = [NSString stringWithFormat:@"%@",numArr[row]];
    
    self.pickerViewA.hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //     Get the new view controller using [segue destinationViewController].
    //     Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[OrderViewController class]]) {
        [(OrderViewController*)segue.destinationViewController setOrderData:orderData];
        
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"PhoneRechargeSegue"]) {
        if([Common isPhoneNumber:self.phoneNumberTextField.text]){
            hud = [MBProgressHUD showMessag:L(@"IsSubmitRequest") toView:self.view];
            request = [[Request alloc]initWithDelegate:self];
            if(payType == AccountPayType){
                [request getVirtualAccountBalance:@"00" token:[AppDelegate getUserBaseData].token];
            }else if (payType == CardPayType){
                NSString *orderAmt = [Common orderAmtFormat:self.payLabel.text];
                [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:_merchID productId:_productID orderAmt:orderAmt orderDesc:self.phoneNumberTextField.text orderRemark:@"" commodityIDs:@"" payTool:@"01"];
            }else{
                //快捷支付
                NSString *orderAmt = [Common orderAmtFormat:self.payLabel.text];
                [request applyOrderMobileNo:[AppDelegate getUserBaseData].mobileNo MerchanId:_merchID productId:_productID orderAmt:orderAmt orderDesc:self.phoneNumberTextField.text orderRemark:@"" commodityIDs:@"" payTool:@"03"];
            }
            
        }else{
            
            [Common showMsgBox:@"" msg:L(@"MobilePhoneNumberIsWrong") parentCtrl:self];
            
        }

        return NO;
    }
    return NO;
}


@end
