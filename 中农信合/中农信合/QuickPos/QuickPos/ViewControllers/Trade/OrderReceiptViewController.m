//
//  ReceiptViewController.m
//  jfpal
//
//  Created by Chunhui Luo on 2/27/13.
//
//

#import "OrderReceiptViewController.h"
#import "OrderReceiptCell.h"
#import "Utils.h"
#import "UIView+MLScreenshot.h"
#import "Common.h"

#define METERS_PER_MILE 2609.344

@interface OrderReceiptViewController ()

@end

@implementation OrderReceiptViewController
@synthesize order, signImg;

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
    
    //[self initBackTitle:nil];
    //[self initRightBar:@"完成"];
    //[self initLeftBar:@"保存"];
    [self setTitle:L(@"SignTheOrder")];
    
//    self.navigationItem.rightBarButtonItem = [Utils rightNextButtonItemWithTitle:@"完成" target:self action:@selector(showInfo:)];
//
//    UIBarButtonItem *over = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"over"] style:UIBarButtonItemStylePlain target:self action:@selector(showInfo:)];
//    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"save"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonTapped:)];
    UIBarButtonItem *over = [[UIBarButtonItem alloc]initWithTitle:L(@"Complete") style:UIBarButtonItemStylePlain target:self action:@selector(showInfo:)];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:L(@"Save") style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonTapped:)];
//    over.image = [UIImage imageNamed:@"over"];
//    save.image = [UIImage imageNamed:@"save"];
    
//    save.tintColor = [UIColor clearColor];
//    over.tintColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = save;
    self.navigationItem.rightBarButtonItem = over;

    [self initUI];
}

- (void)initUI
{
    CGRect frame = self.scrollView.frame;
    frame.size.height = 504;
    self.scrollView.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *appName = [[mainBundle infoDictionary] objectForKey:@"CFBundleDisplayName"];

    
    appName = [appName stringByReplacingOccurrencesOfString:L(@"CommercialVersion") withString:@""];
    
    self.orderReceiptTitleLabel.text = [NSString stringWithFormat:L(@"TransactionSlip"), appName];
    self.orderReceiptAddLabel.text = [NSString stringWithFormat:L(@"MobilePaymentTerminal"), appName];
}

- (void) showInfo: (id) sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
//    [self goHome];
}

- (void)leftBarButtonTapped: (id) sender
{
    CGRect frame = self.scrollView.frame;
    frame.size.height = 504;
    self.scrollView.frame = frame;
    self.scrollView.contentSize = frame.size;
    
    UIView *screenView = self.scrollView;
    UIImage *screenshot = [screenView screenshot];
    
    UIImageWriteToSavedPhotosAlbum(screenshot, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void) image: (UIImage *) image didFinishSavingWithError: (NSError *) error
   contextInfo: (void *) contextInfo
{
    if (error != NULL)
    {
//        [self showErrorMsg:@"保存失败!"];
        [MBProgressHUD showHUDAddedTo:self.view WithString:L(@"SaveFailed")];
    }
    else
    {
        [self showInfo:nil];
    }
}

- (NSString *)getValueFromPrintInfoByKey:(NSString *)key
{
    NSString *value = @"";
    NSArray *array = [self.printInfo componentsSeparatedByString:@","];
    
    for (NSString *str in array) {
        NSArray *arr = [str componentsSeparatedByString:@" "];
        
        if (arr == nil || [arr count] == 1) {
            continue;
        }
        else {
            if ([[arr objectAtIndex:0] rangeOfString:key].length > 0) {
                value = [arr objectAtIndex:1];
                break;
            }
        }
    }
    
    return value;
}

- (void) viewWillAppear:(BOOL)animated {
    //交易类型
    self.transTypeLabel.text = [self getValueFromPrintInfoByKey:L(@"TransactionType")];
    // [NSString stringWithFormat:@"(%@(刷卡))", order.merchantName];
//    self.transSiteNoLabel.text = [self getValueFromPrintInfoByKey:@"终端编号"];
    self.transTimeLabel.text = [NSString stringWithFormat:@"%@ %@", [self getValueFromPrintInfoByKey:L(@"Date")], [self getValueFromPrintInfoByKey:L(@"Time")]];
    self.paymentAccountLabel.text = [self getValueFromPrintInfoByKey:L(@"ThePersonThatHoldCardCardNumber")];
    self.receiveAccountLabel.text = order.orderDesc;
    self.transAmountLabel.text = [Common rerverseOrderAmtFormat:order.orderAmt];
    self.transSerialLabel.text = [self getValueFromPrintInfoByKey:L(@"TransactionSerialNumber")];
    
    _signImgView.image = signImg;
    
    CLLocationCoordinate2D zoomLocation;
//
    NSString *longitude = [NSString stringWithFormat:@"%f",[AppDelegate getUserBaseData].lon];
    NSString *latitude = [NSString stringWithFormat:@"%f",[AppDelegate getUserBaseData].lat];
    if (longitude == nil) {
        longitude = @"0";
    }
    if (latitude == nil) {
        latitude = @"0";
    }
    if(longitude == nil && latitude == nil ) {
        [_mapView setHidden:YES];
    }
    else {
        zoomLocation.latitude = [latitude doubleValue];
        zoomLocation.longitude= [longitude doubleValue];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        [_mapView setRegion:[self.mapView regionThatFits:viewRegion] animated:YES];
        [_mapView setScrollEnabled:NO];
        [_mapView setZoomEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"OrderReceiptCell";
    OrderReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil][0];
    }
    NSArray *info = _tableData[indexPath.row];
    cell.descLabel.text = info[0];
    cell.resultLabel.text = info[1];
    
    if (indexPath.row%2 == 0) {
        cell.bgview.backgroundColor = [UIColor clearColor];
    }else {
        cell.bgview.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
