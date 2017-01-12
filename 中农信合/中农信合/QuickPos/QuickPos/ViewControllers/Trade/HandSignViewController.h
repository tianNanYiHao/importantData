//
//  HandSignViewController.h
//  jfpal
//
//  Created by Chunhui Luo on 2/25/13.
//
//

#import "OrderViewController.h"
#import "ACEDrawingView.h"
@class OrderData;

@protocol HandSignActionDelegate <NSObject>
- (void)handsignFinished:(UIImage *)img;
@end

@interface HandSignViewController : UIViewController <UIActionSheetDelegate, ACEDrawingViewDelegate>
@property (assign, nonatomic) BOOL isShow;
@property (retain, nonatomic) OrderData *order;
@property (nonatomic,retain)NSString *printInfo;
@property (retain, nonatomic) IBOutlet UIView *navView;
@property (nonatomic, assign) id<HandSignActionDelegate>delegate;
@property (nonatomic, retain) IBOutlet ACEDrawingView *drawingView;
@property (retain, nonatomic) IBOutlet UILabel *moneyLbl;


// actions
- (void) showPanelIn: (UIView *)supview;
- (void) hidePanel;
- (IBAction)clear:(id)sender;
- (IBAction)takeScreenshot:(id)sender;

@end
