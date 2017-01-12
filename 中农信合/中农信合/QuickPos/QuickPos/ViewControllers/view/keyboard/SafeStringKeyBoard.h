//
//  PMCustomKeyboard.h
//  PunjabiKeyboard
//
//  Created by Kulpreet Chilana on 7/31/12.
//  Copyright (c) 2012 Kulpreet Chilana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kFont [UIFont fontWithName:@"GurmukhiMN" size:20]
#define kShiftLabel @"Shift"
#define kdeleteLabel @"Delete"
#define kAltLabel @"Alt"
#define kDoneLabel @"Done"
#define kSpaceLabel @"Space"
#define kChar @[ @"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p", @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"z", @"x", @"c", @"v", @"b", @"n", @"m" ]
#define kChar_shift @[ @"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M" ]
#define kChar_alt @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @"\"", @"<", @">", @".", @",", @"?", @"!" ]

@interface SafeStringKeyBoard : UIView <UIInputViewAudioFeedback>

@property (strong, nonatomic) IBOutlet UIImageView *keyboardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@property (strong, nonatomic) IBOutlet UIButton *shiftButton;
@property (strong, nonatomic) IBOutlet UIButton *altButton;
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong) id<UITextInput> textView;
@property (strong, nonatomic) IBOutlet UIButton *spaceButton;

- (IBAction)returnPressed:(id)sender;
- (IBAction)characterPressed:(id)sender;
- (IBAction)shiftPressed:(id)sender;
- (IBAction)altPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)unShift;
- (IBAction)spacePressed:(id)sender;

- (void)remove;

@end
