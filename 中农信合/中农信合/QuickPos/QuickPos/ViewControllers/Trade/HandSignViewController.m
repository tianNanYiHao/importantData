//
//  HandSignViewController.m
//  jfpal
//
//  Created by Chunhui Luo on 2/25/13.
//
//

#define ALERT_TAG_CANCEL       100

#import "HandSignViewController.h"
#import "OrderData.h"
#import "Common.h"

@interface HandSignViewController () {
    BOOL drawed;
}

@end

@implementation HandSignViewController
@synthesize delegate;
@synthesize isShow;
@synthesize order;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // set the delegate
    _drawingView.delegate = self;
    _drawingView.lineWidth = 6.0f;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)cancelBtnClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:L(@"ConfirmToCancel?") message:nil delegate:self cancelButtonTitle:L(@"ConfirmCancel") otherButtonTitles:L(@"ShutDown"),nil];
    alert.tag = ALERT_TAG_CANCEL;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_TAG_CANCEL) {
        if (buttonIndex == 0) {
            [self hidePanel];
        }
    }
}

- (void) showPanelIn: (UIView *)supview {
    self.isShow = YES;
    _moneyLbl.text = [NSString stringWithFormat:L(@"PayTheAmount"),[Common rerverseOrderAmtFormat:self.order.orderAmt]];
    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(M_PI / 2);
    [self.view setTransform:landscapeTransform];
    self.view.frame = [UIScreen mainScreen].bounds;
    [supview addSubview:self.view];
}

- (void) hidePanel{
    self.isShow = NO;
    [self.drawingView clear];
    [self.view removeFromSuperview];
}

- (IBAction)takeScreenshot:(id)sender
{
    if ( ! [self.drawingView canUndo] ) {
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"Sign")];
        return;
    }
    [delegate handsignFinished:self.drawingView.image];
    
    OrderViewController *orderSign = [[OrderViewController alloc]init];
//    orderSign.imageSign = self.drawingView.image;
    
    
    [self hidePanel];
}


- (IBAction)clear:(id)sender
{
    [self.drawingView clear];
}

- (void) viewDidUnload {
    [self setNavView:nil];
    [self setMoneyLbl:nil];
    [super viewDidUnload];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
