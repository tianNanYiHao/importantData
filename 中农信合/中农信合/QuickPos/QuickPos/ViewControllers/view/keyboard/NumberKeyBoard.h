//
//  NumberKeyBoard.h

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kFont [UIFont fontWithName:@"GurmukhiMN" size:20]
#define kShiftLabel @"Shift"
#define kNumberdeleteLabel @"Delete"
#define kAltLabel @"Alt"
#define kDoneLabel @"Done"
#define kSpaceLabel @"Space"
#define kNumber @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"."]


@interface NumberKeyBoard : UIView <UIInputViewAudioFeedback>

//@property (strong, nonatomic) IBOutlet UIImageView *keyboardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong) id<UITextInput> textView;



- (IBAction)returnPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;


- (void)remove;

@end
