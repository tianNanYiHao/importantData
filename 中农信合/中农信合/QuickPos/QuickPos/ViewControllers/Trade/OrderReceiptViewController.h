//
//  ReceiptViewController.h
//  jfpal
//
//  Created by Chunhui Luo on 2/27/13.
//
//

#import <MapKit/MapKit.h>
#import "OrderData.h"

@interface OrderReceiptViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) OrderData *order;
@property (retain, nonatomic) IBOutlet UITableView *receiptTbl;
@property (retain, nonatomic) UIImage *signImg;
@property (nonatomic, retain) NSArray *tableData;
@property (retain, nonatomic) IBOutlet UIImageView *signImgView;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, copy) NSString *printInfo;

@property (retain, nonatomic) IBOutlet UILabel *transTypeLabel;
@property (retain, nonatomic) IBOutlet UILabel *transSiteNoLabel;
@property (retain, nonatomic) IBOutlet UILabel *transTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *paymentAccountLabel;
@property (retain, nonatomic) IBOutlet UILabel *receiveAccountLabel;
@property (retain, nonatomic) IBOutlet UILabel *transAmountLabel;
@property (retain, nonatomic) IBOutlet UILabel *transSerialLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *orderReceiptTitleLabel;
@property (retain, nonatomic) IBOutlet UILabel *orderReceiptAddLabel;


@end
