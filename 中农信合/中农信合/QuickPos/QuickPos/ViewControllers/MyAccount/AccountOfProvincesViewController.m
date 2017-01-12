//
//  AccountOfProvincesViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/13.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "AccountOfProvincesViewController.h"
#import "ProvincesTableViewCell.h"
#import "Common.h"

#define kProvinces                             @"provincesName"
#define KprovincesID                           @"provincesID"

@interface AccountOfProvincesViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ResponseData,UISearchBarDelegate,UITextViewDelegate>{
    
    NSMutableArray *provincesArray;//省份数组
    
    NSMutableArray *provincesID;//省份ID数组
    
    NSDictionary *dataDic;//请求返回
   
    NSMutableArray *searchResults;//搜索数组
    
    NSMutableArray *searchProvincesIDResults;//搜索ID数组
    
    UISearchDisplayController *searchDisplayController;//搜索控制
    
    NSDictionary *getNameDic;//省份名字
    
    NSDictionary *getDic;//过度用字典
    
    NSArray *resultBeanrray;//数据列表字典
    
    Request *request;
    
    NSMutableArray *searchListArray;//搜索列表数组
    
    
    
}
@property (weak, nonatomic) IBOutlet UISearchBar *provincesSearchBar;//搜索栏

@property (weak, nonatomic) IBOutlet UITableView *AccountOfProvincesTableView;//tableView

@property (strong, nonatomic) UITableView *searchTableView;//搜索下拉
@end

@implementation AccountOfProvincesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = L(@"ProvincesList");
    
    request = [[Request alloc]initWithDelegate:self];

    dataDic = [NSDictionary dictionary];
    searchResults = [NSMutableArray array];
    searchProvincesIDResults = [NSMutableArray array];
    provincesArray = [NSMutableArray array];
    provincesID = [NSMutableArray array];

    
    getDic = [NSDictionary dictionary];

    
    [Common setExtraCellLineHidden:self.AccountOfProvincesTableView];
    
    self.AccountOfProvincesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.provincesSearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    self.provincesSearchBar.delegate = self;
    
    self.AccountOfProvincesTableView.tableHeaderView = self.provincesSearchBar;
    
    [request BankofProvinces];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
    
    [hud hide:YES afterDelay:1];
    
    
   
    
}






- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
  if(type == REQUSET_PROVINCES && [dict[@"respCode"]isEqual:@"0000"]){
      
    [MBProgressHUD hideHUDForView:self.view animated:YES];
      
    dataDic = dict;
      
    getDic = dataDic[@"data"];
    
    resultBeanrray = getDic[@"resultBean"];
    
    
    
    for (NSDictionary *dic in resultBeanrray) {
        
        [provincesArray addObject:dic[@"provinceName"]];
        
        [provincesID addObject:dic[@"provinceCode"]];
    }
    
    
        [self.AccountOfProvincesTableView reloadData];
    

    }
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
        
    }
    else {
       return provincesArray.count;
    }

    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    getNameDic = provincesArray[indexPath.row];
    
    
    static NSString *ProvincesCellIdentifier = @"provincesTableViewCell";
    
    ProvincesTableViewCell *provincesCell = (ProvincesTableViewCell*) [self.AccountOfProvincesTableView dequeueReusableCellWithIdentifier:ProvincesCellIdentifier];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        provincesCell.provincesNameLabel.text = searchResults[indexPath.row];
        
    }else {
        provincesCell.provincesNameLabel.text = provincesArray[indexPath.row];
    }

    
    
    return provincesCell;
    
    

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        [userDefaults setObject:searchResults[indexPath.row] forKey:kProvinces];
        [userDefaults setObject:searchProvincesIDResults[indexPath.row] forKey:KprovincesID];
  
        dic = [NSDictionary dictionaryWithObjectsAndKeys:searchResults[indexPath.row],@"provinceName",searchProvincesIDResults[indexPath.row],@"provinceId", nil];
        
    }else {
        
        [userDefaults setObject:provincesArray[indexPath.row] forKey:kProvinces];
        [userDefaults setObject:provincesID[indexPath.row] forKey:KprovincesID];

        dic = [NSDictionary dictionaryWithObjectsAndKeys:provincesArray[indexPath.row],@"provinceName",provincesID[indexPath.row],@"provinceId", nil];
        
    }

    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tongzhi" object:dic];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma UISearchDisplayDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"您点击了键盘上的Search按钮");
    
    [self.provincesSearchBar resignFirstResponder];
    
    [self.provincesSearchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
     searchResults = [NSMutableArray array];
    
    if (_provincesSearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_provincesSearchBar.text]) {
        
        for (int i=0; i<provincesArray.count; i++) {
            
            if ([ChineseInclude isIncludeChineseInString:provincesArray[i]]) {
                
//                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:provincesArray[i]];
//                
//                NSRange titleResult=[tempPinYinStr rangeOfString:_provincesSearchBar.text options:NSCaseInsensitiveSearch];
//                
//                if (titleResult.length>0) {
//                    [searchResults addObject:provincesArray[i]];
//                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:provincesArray[i]];
                
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:_provincesSearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleHeadResult.length>0) {
                    
                    [searchResults addObject:provincesArray[i]];
                }
            }
            else {
                NSRange titleResult=[provincesArray[i] rangeOfString:_provincesSearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0) {
                    
                    [searchResults addObject:provincesArray[i]];
                }
            }
        }
        
        
        for (NSString *tempStr in provincesArray) {
            
            NSRange titleResult = [tempStr rangeOfString:_provincesSearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                
                [searchResults addObject:tempStr];
            }
            
        }
        
        
        
        for (NSString *provincesStr in provincesArray) {
            
            for (NSString *str1 in searchResults ){
                
                if ([str1 isEqualToString:provincesStr]){
                    
                    NSUInteger n = [provincesArray indexOfObject:provincesStr];
                    
                    NSLog(@"n------%d",n);
                    
                    NSString *ID = [NSString stringWithFormat:@"%@",[provincesID objectAtIndex:n]];
                    
                    NSLog(@"ID=====%@",ID);
                    
                    [searchProvincesIDResults addObject:ID];
                    
                    NSLog(@"searchProvincesIDResults=====%@",searchProvincesIDResults);
                }
            }
            
            
        }

  
    
        
    } else if (self.provincesSearchBar.text.length > 0 && [ChineseInclude isIncludeChineseInString:self.provincesSearchBar.text]) {
        
        
        for (NSString *tempStr in provincesArray) {
            
            NSRange titleResult = [tempStr rangeOfString:self.provincesSearchBar.text options:NSCaseInsensitiveSearch];
            
            if (titleResult.length > 0) {
               
                [searchResults addObject:tempStr];
            }
            
        }
        
       
        
        for (NSString *provincesStr in provincesArray) {
            
            for (NSString *str1 in searchResults ){
                
                if ([str1 isEqualToString:provincesStr]){
                
                    NSUInteger n = [provincesArray indexOfObject:provincesStr];
                    
                    NSLog(@"n------%d",n);
                    
                    NSString *ID = [NSString stringWithFormat:@"%@",[provincesID objectAtIndex:n]];
                    
                    NSLog(@"ID=====%@",ID);
                    
                    [searchProvincesIDResults addObject:ID];
                    
                    NSLog(@"searchProvincesIDResults=====%@",searchProvincesIDResults);
                }
            }
            
            
        }
        
        
    }
}


@end
