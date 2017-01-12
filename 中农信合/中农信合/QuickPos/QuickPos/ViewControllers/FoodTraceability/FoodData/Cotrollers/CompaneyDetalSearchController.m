//
//  CompaneyDetalSearchController.m
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CompaneyDetalSearchController.h"
#import "Request.h"
#import "ProducyListSYModel.h"
#import "CompaneyProductInfoController.h"
#define TableViewCellH 50



@interface CompaneyDetalSearchController ()<ResponseData,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    Request *_req;
    ProducyListSYModel *_modell;
    ProducyListSYModel *_modell2;
    NSString *_batchB1;
    NSString *_batchB2;
    NSString *_batchB3;
    NSDictionary*dict1;
    NSDictionary*dict2;
    NSDictionary*dict3;
    UITableView *_tbaleview;

    
    
    
}
@property (weak, nonatomic) IBOutlet UIImageView *incnNameStr;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *firmLab; //生产厂商
@property (weak, nonatomic) IBOutlet UILabel *sallAddressLab; //销售网点
@property (weak, nonatomic) IBOutlet UILabel *productSizeLab; //规格
@property (weak, nonatomic) IBOutlet UILabel *ValidityLab;//有效期
@property (nonatomic,strong) NSString *codeID;  //产品近期三笔code🐴



@property (weak, nonatomic) IBOutlet UITextField *productID; //批次号
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;//追溯
@property (weak, nonatomic) IBOutlet UIView *tableVIewBGview; //tableview展示的背景view

@end

@implementation CompaneyDetalSearchController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"企业追溯";
    NSLog(@"%@",_idid);
    _req = [[Request alloc] initWithDelegate:self];
    [_req getProductInfoWihtID:_idid];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"查询中..."];
    
    [self hidenWhen:YES];
    
    _productID.tag = 1;
    _productID.delegate = self;
    
}
-(void)hidenWhen:(BOOL)booll{
    _tableVIewBGview.hidden = booll;
}
- (void)createTableview{
    _tbaleview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 3*TableViewCellH) style:UITableViewStylePlain];
    _tbaleview.dataSource = self;
    _tbaleview.delegate = self;
    [_tableVIewBGview addSubview:_tbaleview];
    
}

-(void) responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_PRODUCTINFO) {
        NSLog(@"dictionary========= %@",dict);
        _modell = [[ProducyListSYModel alloc] initWihtdictOne:dict];
        //赋值
        [_incnNameStr sd_setImageWithURL:[NSURL URLWithString:_modell.thumbnailUrl]];
        _productTitleLab.text = _modell.name;
        _firmLab.text = _modell.producerName;
        _sallAddressLab.text = _modell.producerName;
        _productSizeLab.text = _modell.standard;
        _ValidityLab.text = _modell.guaranteeDays;
        
        _codeID = _modell.ID;
        [_req getProductInfoNearLyThreeList:_codeID];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"最近三笔查询中"];
    }
    else if (type == REQUSET_ProductID ){  //最近三笔
        NSLog(@"%@%@",dict,[dict class]);
        NSArray *arr = (NSArray*)dict;
        if (!(arr.count>0)) {
            [self hidenWhen:YES];
             MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"暂无出货信息"];
            [hud hide:YES afterDelay:1.5];
        }else
        {
            [self hidenWhen:NO];
            [self createTableview];
            _modell2 = [[ProducyListSYModel alloc] initForProductOUTInfoWithArray:arr];
            [_tbaleview reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)clickwithBatch:(NSString*)batchCode ID:(NSString*)ID{
    CompaneyProductInfoController *vie = [[CompaneyProductInfoController alloc] initWithNibName:@"CompaneyProductInfoController" bundle:nil];
    vie.batchCode = batchCode;
    vie.productID =  ID;
    [self.navigationController pushViewController:vie animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    _tbaleview.frame = CGRectMake(0, 0, 320, _modell2.arrayInfoProductOUT.count*TableViewCellH);
    return _modell2.arrayInfoProductOUT.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TableViewCellH;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"批次号:%@",[_modell2.arrayInfoProductOUT[indexPath.row] batchProductOut]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"生产日期:%@      采购日期:%@",[_modell2.arrayInfoProductOUT[indexPath.row] productionDateProductOut],[_modell2.arrayInfoProductOUT[indexPath.row] purchaseDateProductOut]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![_modell2.arrayInfoProductOUT[indexPath.row] batchProductOut] ) {
        [Common showMsgBox:@"" msg:@"暂未获取有效批次号,请稍后重试" parentCtrl:self];
    }
    else
    {
         [self clickwithBatch:[_modell2.arrayInfoProductOUT[indexPath.row] batchProductOut] ID:_codeID];
    }
    
}

//按钮方法
- (IBAction)searchBtnClick:(id)sender {
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:0];
    if (a.count>0) {
        [a removeAllObjects];
    }
    
    for (int i = 0 ; i<_modell2.arrayInfoProductOUT.count; i++) {
        NSString *s = [NSString new];
        s = [_modell2.arrayInfoProductOUT[i] batchProductOut];
        NSLog(@"%@",s);
        if (s == nil) {
            //判空
        }else{
            [a addObject:s];
        }
    }
    
    if (a.count>0) {
        for (NSString *SS in a) {
            if ([_productID.text isEqualToString:SS]) {
                [self clickwithBatch:_productID.text  ID:_codeID];
                return;
            }
            else
            {
                [Common showMsgBox:@"" msg:@"请输入正确批次号" parentCtrl:self];
                return;
            }
        }
    }else{ //如果批次号返回为null  则输什么都不对
        [Common showMsgBox:@"" msg:@"请输入正确批次号" parentCtrl:self];
        return;
        
    }}


#pragma mark - textfileDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
