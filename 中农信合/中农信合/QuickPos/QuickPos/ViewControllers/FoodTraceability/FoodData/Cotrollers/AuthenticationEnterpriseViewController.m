//
//  AuthenticationEnterpriseViewController.m
//  QuickPos
//
//  Created by caiyi on 16/2/1.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "AuthenticationEnterpriseViewController.h"
#import "AuthenticationEnterpriseModel.h"
#import "BoRefreshHeader.h"
#import "BoRefreshAutoStateFooter.h"
#import "CompaneyDetialController.h"

@interface AuthenticationEnterpriseViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,ResponseData>
{
       Request *_req;
    UISearchDisplayController *searchDisplayCtrl;
    
    UITableView *_CompanyTableView;
    
    NSMutableArray *_dataArray;
    AuthenticationEnterpriseModel *_model;
    int _index;
    UISearchBar *searchBarView;
    NSString * _searchBarClick;
    

}

@property (nonatomic,strong) NSString *keyword;



@end

@implementation AuthenticationEnterpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证企业";
    _req = [[Request  alloc] initWithDelegate:self];
    _index = 0;
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    _searchBarClick = @"NO";
    
    
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
    
    [_req getCompanySYwihtName:@"" fieldNames:@"" regionCity:@"" pageNo:[NSString stringWithFormat:@"%d",_index] pageSize:@"20" Bool:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"商品企业查询..."];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self creatSearchBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark - RequestDelegate
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (type == REQUSET_GETCOMPENYSY) {
        NSLog(@"%@",dict);
        NSArray *array = [dict objectForKey:@"pageData"];
        _model = [[AuthenticationEnterpriseModel alloc] initWithArrayM:array];
        [_dataArray addObject:_model.infoModelArray];
        [_CompanyTableView reloadData];
    }
    
}
- (void)creatTableView
{
    _CompanyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _CompanyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _CompanyTableView.backgroundColor = [UIColor whiteColor];
    _CompanyTableView.delegate = self;
    _CompanyTableView.dataSource = self;
    _CompanyTableView.header = [BoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDown)];
    _CompanyTableView.footer = [BoRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(OnPull)];
    [self.view addSubview:_CompanyTableView];
}

- (void)creatSearchBar
{
    searchBarView = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    searchBarView.delegate = self;
    searchBarView.placeholder = @"搜索";
    searchBarView.barStyle = UISearchBarStyleDefault;
    searchBarView.showsCancelButton = YES;
    [self.view addSubview:searchBarView];
    _CompanyTableView.tableHeaderView = searchBarView;
 
}
-(void)dropDown{ //下拉加载
    NSLog(@"下拉下拉下拉");
    _index= 0;
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
    [_req getCompanySYwihtName:@"" fieldNames:@"" regionCity:@"" pageNo:[NSString stringWithFormat:@"%d",_index] pageSize:@"20" Bool:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_CompanyTableView reloadData];
    [_CompanyTableView.header endRefreshing];

}
-(void)OnPull{
    NSLog(@"上拉上拉上拉");
    if ([_searchBarClick isEqualToString:@"YES"]) {
        [_dataArray removeAllObjects];
        _searchBarClick = @"NO"; //防止 搜索之后上啦奔溃
        _index = 0;
    }else{
        _index= _index+1;
    }
    [_req getCompanySYwihtName:@"" fieldNames:@"" regionCity:@"" pageNo:[NSString stringWithFormat:@"%d",_index] pageSize:@"20" Bool:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_CompanyTableView reloadData];
    [_CompanyTableView.footer endRefreshing];


}

#pragma mark ------tableView 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.infoModelArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identif = @"indentif";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identif];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identif];
    }
    NSArray *arr = _dataArray[indexPath.section];
    
    cell.textLabel.text = [arr[indexPath.row] name];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.numberOfLines = 1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompaneyDetialController *viewC = [[CompaneyDetialController  alloc] initWithNibName:@"CompaneyDetialController" bundle:nil];
    NSArray *arr = _dataArray[indexPath.section];
    viewC.enterpriseId = [arr[indexPath.row] ID];
    viewC.descriptionS = [arr[indexPath.row] descriptions];
    
    [self.navigationController pushViewController:viewC animated:YES];
}

#pragma mark ------searchBar代理方法
//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    
//    [_req getCompanySYwihtName:searchText fieldNames:@"" regionCity:@"" pageNo:[NSString stringWithFormat:@"%d",_index] pageSize:@"20"];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
//    [_CompanyTableView reloadData];
//    [_CompanyTableView.footer endRefreshing];
//}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //显示取消按钮
    searchBar.showsCancelButton = YES;
    
}
//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
    _index = 0;
    [_req getCompanySYwihtName:@"" fieldNames:@"" regionCity:@"" pageNo:[NSString stringWithFormat:@"%d",_index] pageSize:@"20" Bool:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_CompanyTableView reloadData];
    [_CompanyTableView.footer endRefreshing];
    
}

//点击搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
    _searchBarClick = @"YES";
    _index = 0;
    [_req getCompanySYwihtName:searchBarView.text fieldNames:@"" regionCity:@"" pageNo:[NSString stringWithFormat:@"%d",_index] pageSize:@"20" Bool:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"数据加载中..."];
    [_CompanyTableView reloadData];
    [_CompanyTableView.footer endRefreshing];
    //收起键盘
    [searchBar resignFirstResponder];
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
