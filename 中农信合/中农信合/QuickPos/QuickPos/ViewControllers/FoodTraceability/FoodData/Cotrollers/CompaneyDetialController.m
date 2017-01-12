//
//  CompaneyDetialController.m
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CompaneyDetialController.h"
#import "ProducyListSYCell.h"
#import "CompaneyDetalSearchController.h"
#import "ProducyListSYModel.h"
#import "MBProgressHUD.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"
@interface CompaneyDetialController ()<UITableViewDelegate,UITableViewDataSource,ResponseData>
{
    Request *_req;
    int _pageNo;
    ProducyListSYModel *_model;
      NSMutableArray *_dataArray;
    
}

@end

@implementation CompaneyDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.title = @"企业详情";
    _req = [[Request alloc] initWithDelegate:self];
    _pageNo = 1;
    _dataArray  = [[NSMutableArray alloc] initWithCapacity:0];
    [_req getCompanyListWithID:_enterpriseId pageNo:[NSString stringWithFormat:@"%d",_pageNo] pageSize:@"20"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"查询中..."];
    
    
    _companyIntroDutionLab.numberOfLines = 0;
    _companyIntroDutionLab.text = @"暂无信息";
    CGSize rec = [CompaneyDetialController labelAutoCalculateRectWith:_descriptionS Font:[UIFont systemFontOfSize:13] MaxSize:CGSizeZero];
    _companyIntroDutionLab.frame = CGRectMake(0, 0, rec.width, rec.height);
    
    
        //修改位置
        _compenyDetalVIew2.frame = CGRectMake(0, CGRectGetMaxY(_companyIntroDutionLab.frame), self.view.frame.size.width, 300);
//        _tableview.backgroundColor= [UIColor orangeColor];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    _tableview.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDown)];
    _tableview.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(OnPull)];
        [_tableview registerNib:[UINib nibWithNibName:@"ProducyListSYCell" bundle:nil] forCellReuseIdentifier:@"ProducyListSYCell"];
    _tableview.hidden = YES;
    


}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    if (type == REQUSET_products) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSArray *arr = [dict objectForKey:@"pageData"];
        if (arr.count>0) {
            _tableview.hidden = NO;
            _model = [[ProducyListSYModel alloc] initWithArrayM:arr];
            [_dataArray addObject:_model.infoModelArray];
             [_tableview reloadData];
            NSLog(@"%d",_dataArray.count);
        }else
        {
//            [_dataArray removeAllObjects];
            _companyIntroDutionLab.text = @"该企业暂无介绍";
//            [_tableview reloadData];
        }
        
    }
    
}
-(void)dropDown{ //下拉加载
    NSLog(@"下拉下拉下拉");
    _pageNo= 1;
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
      [_req getCompanyListWithID:_enterpriseId pageNo:[NSString stringWithFormat:@"%d",_pageNo] pageSize:@"20"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_tableview reloadData];
    [_tableview.header endRefreshing];
}
-(void)OnPull{
    NSLog(@"上拉上拉上拉");
    _pageNo= _pageNo+1;
    [_req getCompanyListWithID:_enterpriseId pageNo:[NSString stringWithFormat:@"%d",_pageNo] pageSize:@"20"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_tableview reloadData];
    [_tableview.footer endRefreshing];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.infoModelArray.count;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentif = @"ProducyListSYCell";
    
    ProducyListSYCell *cell = [tableView dequeueReusableCellWithIdentifier:indentif forIndexPath:indexPath];
    NSArray *arr = _dataArray[indexPath.section];
    cell.model = arr[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"1111111111111111111111");
    CompaneyDetalSearchController *vieC = [[CompaneyDetalSearchController alloc] initWithNibName:@"CompaneyDetalSearchController" bundle:nil];
       NSArray *arr = _dataArray[indexPath.section];
    vieC.idid = [arr[indexPath.row] ID];
    
    [self.navigationController pushViewController:vieC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  根据文字算出文字所占区域大小
 *
 *  @param text    文字内容
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *
 *  @return 实际尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text Font:(UIFont*)font MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

@end
