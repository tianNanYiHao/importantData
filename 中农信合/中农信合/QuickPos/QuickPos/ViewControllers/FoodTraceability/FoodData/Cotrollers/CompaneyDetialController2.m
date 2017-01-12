//
//  CompaneyDetialController2.m
//  QuickPos
//
//  Created by Lff on 16/7/28.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CompaneyDetialController2.h"
#import "ProducyListSYCell.h"
#import "CompaneyDetalSearchController.h"
#import "ProducyListSYModel.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"
@interface CompaneyDetialController2 ()<UITableViewDelegate,UITableViewDataSource,ResponseData>
{
    Request *_req;
    int _pageNO;
    ProducyListSYModel *_model;
    NSMutableArray *_dataArray;
    
    
}
@end

@implementation CompaneyDetialController2


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _name;
    _pageNO = 1;
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _req = [[Request alloc] initWithDelegate:self];
     [_req getProductSYcategoriesWithName:_name pageNo:[NSString stringWithFormat:@"%d",_pageNO] pageSIze:@"20"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"查询中.."];
    
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.hidden = YES;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDown)];
    _tableview.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(OnPull)];
    [_tableview registerNib:[UINib nibWithNibName:@"ProducyListSYCell" bundle:nil] forCellReuseIdentifier:@"ProducyListSYCell"];
}

-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_categoriesProduct ) {
        
        NSArray *arr = [dict objectForKey:@"pageData"];
        if (arr.count>0) {
            _tableview.hidden = NO;
            _model = [[ProducyListSYModel alloc] initWithArrayM:arr];
            [_dataArray addObject:_model.infoModelArray];
            [_tableview reloadData];
            NSLog(@"%d",_dataArray.count);
        }

    }
    
}
-(void)dropDown{ //下拉加载
    NSLog(@"下拉下拉下拉");
    _pageNO= 1;
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
       [_req getProductSYcategoriesWithName:_name pageNo:[NSString stringWithFormat:@"%d",_pageNO] pageSIze:@"20"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_tableview reloadData];
    [_tableview.header endRefreshing];
}

-(void)OnPull{
    NSLog(@"上拉上拉上拉");
    _pageNO= _pageNO+1;
     [_req getProductSYcategoriesWithName:_name pageNo:[NSString stringWithFormat:@"%d",_pageNO] pageSIze:@"20"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_tableview reloadData];
    [_tableview.footer endRefreshing];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.infoModelArray.count;
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
@end
