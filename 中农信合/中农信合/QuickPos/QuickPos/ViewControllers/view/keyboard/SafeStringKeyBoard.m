//
//  PMCustomKeyboard.m
//  PunjabiKeyboard
//
//  Created by Kulpreet Chilana on 7/31/12.
//  Copyright (c) 2012 Kulpreet Chilana. All rights reserved.
//

#import "SafeStringKeyBoard.h"
#import "UIImage+wiRoundedRectImage.h"


@interface SafeStringKeyBoard ()<UIGestureRecognizerDelegate>{
    UIColor *keyColor;
    
    
}


@property (nonatomic, assign, getter=isShifted) BOOL shifted;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@end

@implementation SafeStringKeyBoard
@synthesize textView = _textView;
@synthesize tap;

- (void)didMoveToSuperview {
    if (!tap) {
        [self setSuperViewClickRemove];
    }
}

- (id)init {
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
	CGRect frame;
    
	if(UIDeviceOrientationIsLandscape(orientation))
        frame = CGRectMake(0, 0, 480, 162);
    else
        frame = CGRectMake(0, 0, 320, 216);
	
	self = [super initWithFrame:frame];
	
	if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SafeStringKeyBoard" owner:self options:nil];
		[[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
        
        keyColor = [UIColor colorWithRed:104.0/255.0 green:213.0/255.0 blue:163.0/255.0 alpha:1.0];
        
        self.shiftButton.layer.cornerRadius = 5.0;
        [self.shiftButton setTitle:kShiftLabel forState:UIControlStateNormal];
        
        self.deleteButton.layer.cornerRadius = 5.0;
        [self.deleteButton setTitle:kdeleteLabel forState:UIControlStateNormal];
        
        [self.altButton setTitle:kAltLabel forState:UIControlStateNormal];
        self.altButton.layer.cornerRadius = 5.0;
        
        [self.returnButton setTitle:kDoneLabel forState:UIControlStateNormal];
        self.returnButton.layer.cornerRadius = 5.0;
        
        self.returnButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self loadCharactersWithArray:kChar];
        
        self.spaceButton.layer.cornerRadius = 5.0;
        self.spaceButton.layer.borderWidth = 0;
        [self.spaceButton setTitle:kSpaceLabel forState:UIControlStateNormal];
        UIImage*spaceButtonBg=[self imageWithColor:keyColor];
        
        //给image加上圆角
        [self.spaceButton setBackgroundImage:[UIImage createRoundedRectImage:spaceButtonBg size:self.spaceButton.frame.size radius:5.0] forState:UIControlStateHighlighted];
    
    }
    
    
	return self;
}

-(void)setTextView:(id<UITextInput>)textView {
	
	if ([textView isKindOfClass:[UITextView class]])
        [(UITextView *)textView setInputView:self];
    else if ([textView isKindOfClass:[UITextField class]])
        [(UITextField *)textView setInputView:self];
    
    _textView = textView;
    

}

-(id<UITextInput>)textView {
	return _textView;
}
//获取和创建字母键盘的title。
-(void)loadCharactersWithArray:(NSArray *)a {
	int i = 0;
	for (UIButton *b in self.characterKeys) {
		[b setTitle:[a objectAtIndex:i] forState:UIControlStateNormal];
        b.layer.cornerRadius = 3.0;
        [b.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
		i++;
	}
}

- (BOOL) enableInputClicksWhenVisible {
    return YES;
}

/* IBActions for Keyboard Buttons */
//return响应
- (IBAction)returnPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
    [self remove];
    
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

//shift
- (IBAction)shiftPressed:(id)sender {
	[[UIDevice currentDevice] playInputClick];
	if (!self.isShifted) {
		[self.shiftButton setBackgroundImage:[UIImage imageNamed:@"glow.png"] forState:UIControlStateNormal];
		[self loadCharactersWithArray:kChar_shift];
        [self.altButton setTitle:kAltLabel forState:UIControlStateNormal];
	}
}
//shift
- (IBAction)unShift {
	if (self.isShifted) {
		[self.shiftButton setBackgroundImage:nil forState:UIControlStateNormal];
		[self loadCharactersWithArray:kChar];
	}
	if (!self.isShifted)
		self.shifted = YES;
	else
		self.shifted = NO;
}
//space响应
- (IBAction)spacePressed:(UIButton*)sender {
    
    [[UIDevice currentDevice] playInputClick];
	[self.textView insertText:@" "];
    
	if (self.isShifted)
		[self unShift];
	
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}
//alt响应
- (IBAction)altPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	[self.shiftButton setBackgroundImage:nil forState:UIControlStateNormal];
	self.shifted = NO;
	UIButton *button = (UIButton *)sender;
	
	if ([button.titleLabel.text isEqualToString:kAltLabel]) {
		[self loadCharactersWithArray:kChar_alt];
        [self.altButton setTitle:@"a b c" forState:UIControlStateNormal];
	}
	else {
		[self loadCharactersWithArray:kChar];
        [self.altButton setTitle:kAltLabel forState:UIControlStateNormal];
	}
}
//delete按钮响应
- (IBAction)deletePressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	[self.textView deleteBackward];
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}


//输出字母键盘按钮字符
- (IBAction)characterPressed:(id)sender {
	UIButton *button = (UIButton *)sender;
	NSString *character = [NSString stringWithString:button.titleLabel.text];
	if ([[character substringToIndex:1] isEqualToString:@"◌"])
        character = [character substringFromIndex:1];
	else if ([[character substringFromIndex:character.length - 1] isEqualToString:@"◌"])
		character = [character substringToIndex:character.length - 1];
	[self.textView insertText:character];
	if (self.isShifted)
		[self unShift];
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}
//获取
- (void) setSuperViewClickRemove{
    if (!tap) {
        for (UIView* next = [(UIView*)self.textView superview]; next; next = next.superview) {
            UIResponder* nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                UIViewController *ctrl = (UIViewController*)nextResponder;

                
                tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
                [tap setDelegate:self];
                [ctrl.view addGestureRecognizer:tap];
            }

        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    BOOL isTouch = YES;
    if ([touch.view isMemberOfClass:[UINavigationBar class]]) {
        isTouch = NO;
    }else if([touch.view isMemberOfClass:[UIButton class]]){
        isTouch = NO;
    }else if ([touch.view isMemberOfClass:[UITextField class]]){
        isTouch = NO;
    }
    else {
        isTouch = YES;
    }
    return isTouch;
}

//收键盘
-(void)remove{
    if ([self.textView isKindOfClass:[UITextField class]]) {
        [(UITextField*)self.textView resignFirstResponder];
    }else if([self.textView isKindOfClass:[UITextView class]]){
        [(UITextView*)self.textView resignFirstResponder];
    }
}


-(void) touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event{
    //松开手指后键盘变色（实现键盘的弹性效果）
    
    for (UIButton *b in self.characterKeys) {
        b.backgroundColor=[UIColor whiteColor];
        
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    
    CGPoint location = [[touches anyObject] locationInView:self];
    
    for (UIButton *b in self.characterKeys) {
        b.backgroundColor=[UIColor whiteColor];
        if ([b subviews].count > 1) {
            
            [[[b subviews] objectAtIndex:1] removeFromSuperview];
            
        }
        if(CGRectContainsPoint(b.frame, location))
        {
            
            b.backgroundColor=keyColor;
            
            
            [self characterPressed:b];
        }
    }
    
    
    
    
}


#define _UPPER_WIDTH   (52.0 * [[UIScreen mainScreen] scale])
#define _LOWER_WIDTH   (32.0 * [[UIScreen mainScreen] scale])

#define _PAN_UPPER_RADIUS  (7.0 * [[UIScreen mainScreen] scale])
#define _PAN_LOWER_RADIUS  (7.0 * [[UIScreen mainScreen] scale])

#define _PAN_UPPDER_WIDTH   (_UPPER_WIDTH-_PAN_UPPER_RADIUS*2)
#define _PAN_UPPER_HEIGHT    (61.0 * [[UIScreen mainScreen] scale])

#define _PAN_LOWER_WIDTH     (_LOWER_WIDTH-_PAN_LOWER_RADIUS*2)
#define _PAN_LOWER_HEIGHT    (32.0 * [[UIScreen mainScreen] scale])

#define _PAN_UL_WIDTH        ((_UPPER_WIDTH-_LOWER_WIDTH)/2)

#define _PAN_MIDDLE_HEIGHT    (11.0 * [[UIScreen mainScreen] scale])

#define _PAN_CURVE_SIZE      (7.0 * [[UIScreen mainScreen] scale])

#define _PADDING_X     (15 * [[UIScreen mainScreen] scale])
#define _PADDING_Y     (10 * [[UIScreen mainScreen] scale])
#define _WIDTH   (_UPPER_WIDTH + _PADDING_X*2)
#define _HEIGHT   (_PAN_UPPER_HEIGHT + _PAN_MIDDLE_HEIGHT + _PAN_LOWER_HEIGHT + _PADDING_Y*2)


#define _OFFSET_X    -25 * [[UIScreen mainScreen] scale])
#define _OFFSET_Y    59 * [[UIScreen mainScreen] scale])


- (UIImage *)imageWithColor:(UIColor *)color

{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
}

@end

