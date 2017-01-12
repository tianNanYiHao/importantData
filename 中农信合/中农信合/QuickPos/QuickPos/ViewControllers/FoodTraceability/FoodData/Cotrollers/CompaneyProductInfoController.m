//
//  CompaneyProductInfoController.m
//  QuickPos
//
//  Created by Lff on 16/7/29.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CompaneyProductInfoController.h"
#import "ProducyListSYModel.h"
#import "ComplaintViewController.h"
@interface CompaneyProductInfoController ()<ResponseData>
{
    Request *_req;
    ProducyListSYModel *_model;
    NSArray *_arraySY;
    
}
@property (weak, nonatomic) IBOutlet UIView *coverView1;
@property (weak, nonatomic) IBOutlet UIView *coverView2;

@property (weak, nonatomic) IBOutlet UIImageView *incnNameStr;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *firmLab; //生产厂商
@property (weak, nonatomic) IBOutlet UILabel *sallAddressLab; //销售网点
@property (weak, nonatomic) IBOutlet UILabel *productSizeLab; //规格
@property (weak, nonatomic) IBOutlet UILabel *ValidityLab;//有效期

@property (weak, nonatomic) IBOutlet UILabel *batchShow1;
@property (weak, nonatomic) IBOutlet UILabel *batchShow2;
@property (weak, nonatomic) IBOutlet UILabel *batchLitleShow1;
@property (weak, nonatomic) IBOutlet UILabel *batchLitleShow2;
@property (weak, nonatomic) IBOutlet UILabel *productDate1;
@property (weak, nonatomic) IBOutlet UILabel *productDate2;
@property (weak, nonatomic) IBOutlet UILabel *productCompany1;

@property (weak, nonatomic) IBOutlet UILabel *productStateLab1;
@property (weak, nonatomic) IBOutlet UILabel *productStateLab2;

@property (weak, nonatomic) IBOutlet UIButton *complaintBtn; //投诉建议



@end

@implementation CompaneyProductInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"溯源信息";
    
    _arraySY = [[NSArray alloc] init];
    _req = [[Request alloc] initWithDelegate:self];

    
    if ([_formeWhere isEqualToString:@"ManualSearchSYViewController"]) {  //手动搜索走这里
           [_req getProductSYInfoByScCode:_snCode];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"查询中..."];
        _coverView1.hidden = NO;
        _coverView2.hidden = NO; // 这里用两个coverView来遮挡 , 权宜之计
    
    }
    else{
        [_req getProductNodeListProductID:_productID productionDate:@"" batch:_batchCode];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"查询中..."];
        _coverView1.hidden = YES;
        _coverView2.hidden = YES;
    }


    
    
}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_validation) {
        NSLog(@"%@",dict);
        _model = [[ProducyListSYModel alloc] initWithSYInfoWithDict:dict];
        [_incnNameStr sd_setImageWithURL:[NSURL URLWithString:_model.enterpriseLogoUrlSY]];
        _productTitleLab.text = _model.productNameSY;
        _firmLab.text = _model.enterpriseNameSY;
        _sallAddressLab.text =_model.enterpriseAddressSY;
        _arraySY = _model._productInfoArraySY;  //数据

        //1 生产      model2._nodeCodeNameSY
        NSDictionary *dict1 = _arraySY[0];
        ProducyListSYModel *model1 = [[ProducyListSYModel alloc] initWithSYProductListByDict:dict1];
        _batchShow1.text = model1.companyBatchSY;
        NSLog(@"%@",_batchShow1.text);
        _batchLitleShow1.text = model1.companyBatchSY;
        _productDate1.text = model1.companyDateSY;
        _productCompany1.text = model1.companyNameSY;
        _productStateLab1.text = model1.nodeCodeNameSY;
        

        //2 进货     model2._nodeCodeNameSY
        NSDictionary *dict2 = _arraySY[1];
        ProducyListSYModel *model2 = [[ProducyListSYModel alloc] initWithSYProductListByDictStoke:dict2];
        _batchShow2.text = model2.companyNameSY;
        _batchLitleShow2.text = model2.companyNameSY;
        _productDate2.text = model2.companyDateSY;
        _productStateLab2.text = model2.nodeCodeNameSY;
    }
    
    if (type == REQUSET_snCode) {
        _model = [[ProducyListSYModel alloc] initWithSYInfoWithDict:dict];
        
        [_incnNameStr sd_setImageWithURL:[NSURL URLWithString:_model.enterpriseLogoUrlSY]];
        _productTitleLab.text = _model.productNameSY;
        _firmLab.text = _model.enterpriseNameSY;
        _sallAddressLab.text =_model.enterpriseAddressSY;
        _arraySY = _model._productInfoArraySY;  //数据
        
        if (_arraySY.count>0) {
            
            //1 生产      model2._nodeCodeNameSY
            NSDictionary *dict1 = _arraySY[0];
            ProducyListSYModel *model1 = [[ProducyListSYModel alloc] initWithSYProductListByDict:dict1];
            _batchShow1.text = model1.companyBatchSY;
            NSLog(@"%@",_batchShow1.text);
            _batchLitleShow1.text = model1.companyBatchSY;
            _productDate1.text = model1.companyDateSY;
            _productCompany1.text = model1.companyNameSY;
            _productStateLab1.text = model1.nodeCodeNameSY;
            _coverView1.hidden = YES;

            if (_arraySY.count>1) {
                //2 进货     model2._nodeCodeNameSY
                NSDictionary *dict2 = _arraySY[1];
                ProducyListSYModel *model2 = [[ProducyListSYModel alloc] initWithSYProductListByDictStoke:dict2];
                _batchShow2.text = model2.companyNameSY;
                _batchLitleShow2.text = model2.companyNameSY;
                _productDate2.text = model2.companyDateSY;
                _productStateLab2.text = model2.nodeCodeNameSY;
                _coverView2.hidden = YES;

            }else
            {
                _coverView2.hidden = NO;
            }
        }else{
               _coverView1.hidden = NO;
        }
        
        
    


    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//投诉建议
- (IBAction)complaintBtnClick:(id)sender {
    ComplaintViewController *view = [[ComplaintViewController alloc] initWithNibName:@"ComplaintViewController" bundle:nil];
    
    [self.navigationController pushViewController:view animated:YES];

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
