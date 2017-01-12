//
//  CertificationGoodsViewController.m
//  QuickPos
//
//  Created by caiyi on 16/2/1.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "CertificationGoodsViewController.h"

#define PRODUCT_URL @"http://shfda.org/data/showdatamobile.do?menu-id=product"
#import "CertificationGoodsCell.h"
#import "CertificationGoodsModel.h"

#import "CompaneyDetialController2.h"




@interface CertificationGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,ResponseData,UISearchBarDelegate>
{
    UIWebView *_webView;
    UITableView *_tableView;
    NSMutableArray *_array;
    CertificationGoodsModel *_model;
    Request *_req;
    UISearchBar *_sarchBar;
    

}
@end

@implementation CertificationGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"认证商品";
    
//    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:PRODUCT_URL]];
//    [self.view addSubview:_webView];
//    [_webView loadRequest:request];
    
    _req = [[Request alloc] initWithDelegate:self];
    [_req getProductSYcategories];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:@"查询中...."];
    
    
    _sarchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _sarchBar.delegate = self;
    _sarchBar.placeholder = @"搜索";
    _sarchBar.barStyle = UISearchBarStyleDefault;
    _sarchBar.showsCancelButton = YES;
    [self.view addSubview:_sarchBar];
    _tableView.tableHeaderView = _sarchBar;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
  
    _array  = [[NSMutableArray alloc] initWithCapacity:0];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"CertificationGoodsCell" bundle:nil] forCellReuseIdentifier:@"CertificationGoodsCell"];
    [_tableView reloadData];
    _tableView.tableHeaderView = _sarchBar;
    [self.view addSubview:_tableView];
    
    NSArray *arricon = @[@"粮食图标",@"畜产品图标",@"禽图标",@"蔬菜图标",@"水果图标",@"水产品",@"豆制品",@"乳制品图标",@"食用油图标"];
    NSArray *arrcompLab = @[@"粮食及其制品",@"畜产品及其制品",@"禽及产品制品",@"蔬菜",@"水果",@"水产品",@"豆制品",@"乳品",@"食用油"];
    NSArray *arrdicripLab = @[@"粳米(包装)",@"猪肉 牛肉(包装) 羊肉(包装)",@"鸡(活) 肉鸽(活) 冷鲜鸡(包装)",@"豇豆 番茄 土豆 冬瓜 辣椒",@"苹果 香蕉",@"鲳鱼 带鱼 黄鱼 梭子蟹 虾仁",@"内脂豆腐",@"婴幼配方乳粉",@"大豆油"];
    
    for (int i = 0; i<arricon.count; i++) {
        _model = [[CertificationGoodsModel alloc] init];
        _model.iconNameStr = arricon[i];
        _model.compLabStr = arrcompLab[i];
        _model.discripLabStr = arrdicripLab[i];
        [_array addObject:_model];
    }
    NSLog(@"%@",[_array[2] compLabStr]);
       [_tableView reloadData];
}

#pragma mark ------searchBar代理方法
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{


    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        [searchBar resignFirstResponder];
        CompaneyDetialController2 *view = [[CompaneyDetialController2 alloc] initWithNibName:@"CompaneyDetialController2" bundle:nil];
        view.name = _sarchBar.text;
        [self.navigationController pushViewController:view animated:YES];
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //显示取消按钮
    searchBar.showsCancelButton = YES;
    _sarchBar.text  =  @"";
}
//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
     _sarchBar.text = @"";
}
-(void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    if (type == REQUSET_categories) {
//        NSArray *arr = (NSArray*)dict;
//        for (NSDictionary *dictt in arr) {
//            _model = [[CertificationGoodsModel alloc] initwithDictForcategories:dictt];
//            [_array addObject:_model];
//        }
//        [_tableView reloadData];
//    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID  = @"CertificationGoodsCell";
    CertificationGoodsCell *cell = (CertificationGoodsCell*)[tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.model = _array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CompaneyDetialController2 *view = [[CompaneyDetialController2 alloc] initWithNibName:@"CompaneyDetialController2" bundle:nil];
    view.name = [_array[indexPath.row] compLabStr];
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
