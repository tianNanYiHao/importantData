//
//  ViewController.m
//  TextFieldTextDidChangeNotification
//
//  Created by tianNanYiHao on 2017/6/23.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+CheckLenght.h"



@interface ViewController ()
{
    UITextField *nameTextField;
}
@property (weak, nonatomic) IBOutlet UITextField *textFiledA;
@property (weak, nonatomic) IBOutlet UILabel *lableA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _textFiledA.autocorrectionType = UITextAutocorrectionTypeNo;
    _textFiledA.returnKeyType = UIReturnKeyNext;
 

    
    nameTextField = [[UITextField alloc] init];
    nameTextField.tag = 1;
    nameTextField.placeholder = @"持卡人姓名";
    nameTextField.text = @"刘斐斐";
    nameTextField.textColor = [UIColor greenColor];
    [nameTextField setMinLenght:@"4"];
    [nameTextField setMaxLenght:@"16"];
    nameTextField.frame = CGRectMake(0, 230, self.view.frame.size.width, 20);
    nameTextField.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:nameTextField];

    //添加键盘输入框 变化的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification object:nameTextField];
    
}
#pragma mark - 把所有的输入框放到数组中
/**
 *@brief 把所有的输入框放到数组中
 *@return NSArray
 */
- (NSArray *)allInputFields {
    return @[nameTextField];
}

#pragma mark - UITextFieldDelegate

/**
 *当用户按下return键或者按回车键，我们注销KeyBoard响应，它会自动调用textFieldDidEndEditing函数
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone) {
//        [self dismissKeyboard];
    }
    
    return [self setNextResponder:textField] ? NO : YES;
}


- (BOOL)setNextResponder:(UITextField *)textField {
    
    NSArray *textFields = [self allInputFields];
    NSInteger indexOfInput = [textFields indexOfObject:textField];
    if (indexOfInput != NSNotFound && indexOfInput < textFields.count - 1) {
        UIResponder *next = [textFields objectAtIndex:(NSUInteger)(indexOfInput + 1)];
        if ([next canBecomeFirstResponder]) {
            [next becomeFirstResponder];
            return YES;
        }
    }
    return NO;
}









- (void)textFiledEditChanged:(NSNotification*)noti{
    
    UITextField *textField = (UITextField *)noti.object;
    NSString *content = textField.text;
    
    NSLog(@"--> %@",content);
    
    _lableA.text = content;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
