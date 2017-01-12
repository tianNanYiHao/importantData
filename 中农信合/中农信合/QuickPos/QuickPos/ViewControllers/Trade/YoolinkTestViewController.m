//
//  YoolinkTestViewController.m
//  ipos
//
//  Created by 张倡榕 on 15/1/22.
//
//

#import "YoolinkTestViewController.h"

@interface YoolinkTestViewController ()
@property (retain, nonatomic) IBOutlet UILabel *appuserLbe;
@property (retain, nonatomic) IBOutlet UILabel *keyLbe;
@property (retain, nonatomic) IBOutlet UILabel *urlLbe;

@property (retain, nonatomic) IBOutlet UILabel *iposBundleID;
@property (retain, nonatomic) IBOutlet UILabel *iposVersion;



@end

@implementation YoolinkTestViewController
@synthesize appuserLbe;
@synthesize keyLbe;
@synthesize urlLbe;
@synthesize iposBundleID;
@synthesize iposVersion;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    appuserLbe.text = [NSString stringWithFormat:@"%@",APPUSER];

    keyLbe.text = [NSString stringWithFormat:@"%@",SIGN];

    urlLbe.text = [NSString stringWithFormat:@"%@",BASE_URL];
    
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSMutableString *bundleName = [NSMutableString stringWithFormat:@"%@", @""];
    [bundleName appendString:[[mainBundle infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    iposBundleID.text = bundleName;
    
    
    NSMutableString *shontversionId = [NSMutableString stringWithFormat:@"%@", @""];
    [shontversionId appendString:[[mainBundle infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    iposVersion.text = shontversionId;
    

    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
