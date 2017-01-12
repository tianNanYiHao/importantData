//
//  ComplaintViewController.m
//  QuickPos
//
//  Created by Lff on 16/8/1.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ComplaintViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ComplaintViewController ()<ResponseData>
{
    ALAssetsLibrary *_library;
    NSMutableArray  *_dataArray;
    Request *_rep;
    
}
@property (weak, nonatomic) IBOutlet UIView *BGview1;//模块1
@property (weak, nonatomic) IBOutlet UIView *BGview2;
@property (weak, nonatomic) IBOutlet UIView *BGview3;


@property (weak, nonatomic) IBOutlet UITextField *nameProduct;
@property (weak, nonatomic) IBOutlet UITextField *sizeProduct;
@property (weak, nonatomic) IBOutlet UITextField *dateProduct;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *address;

@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"投诉建议";
    self.view.backgroundColor = [Common hexStringToColor:@"eeeeee"];
    
    _rep = [[Request alloc] initWithDelegate:self];
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//相机
- (IBAction)cameraGetBtn:(id)sender {
    _library = [[ALAssetsLibrary alloc] init];
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        //        [_dataArray addObject:group];
        //        ALAsset *alasset = _dataArray[0];
        //        NSLog(@"%@",alasset);
        NSLog(@"()()()()()()()()()()()%@%s",group,stop);
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$,%@,===== %d,==== %s",result,index,stop);
//            [_dataArray addObject:result];
        }];
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}
//提交
- (IBAction)upDateBtn:(id)sender {
    [_rep postComplaintWithtagId:@"F1060F560C2002E0" tagSn:@"000000000777" tagSnProducerCode:@"SHFDA" enterpriseId:@"3" productId:@"47" userName:@"INESA芥花油" mobile:@"15151474388" comments:@"123"];
    
}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    if (type == REQUSET_Complaint) {
        
        
    }
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
