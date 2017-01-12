//
//  AddCardDetailInfoViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/8.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "AddCardDetailInfoViewController.h"
#import "QuickPayOrderViewController.h"
#import "NumberKeyBoard.h"
#import "QuickBankData.h"

@interface AddCardDetailInfoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *validDate;//卡有效期
@property (weak, nonatomic) IBOutlet UITextField *cvv2;//背面校验码
@property (weak, nonatomic) IBOutlet UIButton *comfirt;

@end

@implementation AddCardDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.comfirt.layer.cornerRadius = 5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyBoard:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)closeKeyBoard:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication]keyWindow] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 1) {
        if (range.location>3) {
            return NO;
        }
//        if (range.location>1) {
//            NSMutableString *newText = [NSMutableString stringWithString:@""];
//            for (int i = 0; i < textField.text.length; i ++) {
//                NSString *str = [textField.text substringWithRange:NSMakeRange(i, 1)];
//                if (![str isEqualToString:@"/"]) {
//                    [newText appendString:str];
//                }
//                
//            }
//            string = [NSString stringWithFormat:@"%@/%@",[newText substringToIndex:2],[newText substringFromIndex:2]];
//            textField.text = string;
//        }

    }else{
        if (range.location>2) {
            return NO;
        }
    
    }
    return YES;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.destinationViewController isKindOfClass:[QuickPayOrderViewController class]]){
        [(QuickPayOrderViewController*)segue.destinationViewController setOrderData:self.orderData];
        self.quickBankItem.validateCode = self.validDate.text;
        self.quickBankItem.cvv2 = self.cvv2.text;
        [(QuickPayOrderViewController*)segue.destinationViewController setBankCardItem:self.quickBankItem];
    }

}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"DetailToOrderSegue"]) {
        if (self.validDate.text.length != 5 && self.cvv2.text.length != 3) {
            return NO;
        }
    }
    return YES;
}

@end
