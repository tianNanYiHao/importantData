//
//  ManualSearchSYViewController.m
//  QuickPos
//
//  Created by Lff on 16/8/1.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "ManualSearchSYViewController.h"
#import "CompaneyProductInfoController.h"


@interface ManualSearchSYViewController ()<ResponseData>
{
    Request *_req;
    
}
@property (weak, nonatomic) IBOutlet UITextField *searchCode;


@end

@implementation ManualSearchSYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"追溯查询";
}

- (IBAction)btnSerach:(id)sender {

    if (!(_searchCode.text.length>0)) {
        [Common showMsgBox:@"" msg:@"请输入查询码" parentCtrl:self];
    }
    else{
        CompaneyProductInfoController *v = [[CompaneyProductInfoController alloc] initWithNibName:@"CompaneyProductInfoController" bundle:nil];
        v.formeWhere = @"ManualSearchSYViewController";
        v.snCode = _searchCode.text;
        [self.navigationController pushViewController:v animated:YES];

    }
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
