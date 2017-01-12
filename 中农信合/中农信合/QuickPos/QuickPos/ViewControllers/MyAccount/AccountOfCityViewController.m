//
//  AccountOfCityViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/13.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "AccountOfCityViewController.h"
#import "CityTableViewCell.h"
#import "Common.h"
#define KcityID                           @"cityID"

@interface AccountOfCityViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ResponseData,UISearchBarDelegate>{
    
    NSDictionary *dataDic;//请求返回数组
    
    NSMutableArray *cityArray;//城市数组
    
    NSMutableArray *cityID;//城市id数组
    
    NSMutableArray *searchBankIDResults;//搜索银行id数组
    
    NSMutableArray *searchResults;//搜索数组
    
    Request *request;
    
    UISearchDisplayController *searchDisplayController;//搜索控制
    
}
@property (weak, nonatomic) IBOutlet UITableView *accoutOfCityTableView;//tableview

@property (weak, nonatomic) IBOutlet UISearchBar *CitySearchBar;//搜索栏

@end

@implementation AccountOfCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = L(@"CityList");
    
    cityArray = [NSMutableArray array];
    cityID = [NSMutableArray array];
    searchResults = [NSMutableArray array];
    searchBankIDResults = [NSMutableArray array];
    
    
    request = [[Request alloc]initWithDelegate:self];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    
    self.accoutOfCityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    [Common setExtraCellLineHidden:self.accoutOfCityTableView];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.CitySearchBar contentsController:self];
    
    searchDisplayController.active = NO;
    
    searchDisplayController.searchResultsDataSource = self;
    
    searchDisplayController.searchResultsDelegate = self;
    
    self.CitySearchBar.delegate = self;

    self.accoutOfCityTableView.tableHeaderView = self.CitySearchBar;
    
    [request BankofCity:[def objectForKey:KFprovincesID]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
    
    [hud hide:YES afterDelay:1];

    
    
    
}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    if(type == REQUSET_CITY && [dict[@"respCode"]isEqual:@"0000"]){
        
       [MBProgressHUD hideHUDForView:self.view animated:YES];
        
       dataDic = dict;
    
       NSDictionary *getDic = dataDic[@"data"];
    
       NSArray*resultBeanrray = getDic[@"resultBean"];
    
   
       for (NSDictionary*dic in resultBeanrray) {
        
          [cityArray addObject:dic[@"cityName"]];//获取城市名
           
          [cityID addObject:dic[@"cityCode"]];//获取城市ID
       
        
    }
    
    
          [self.accoutOfCityTableView reloadData];
        
    }
}





#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        return searchResults.count;
        
    }else {
        
        return cityArray.count;
    }
    
    

        return cityArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    static NSString *cityCellIdentifier = @"CityTableViewCell";
    
    CityTableViewCell *cityCell = (CityTableViewCell *) [self.accoutOfCityTableView dequeueReusableCellWithIdentifier:cityCellIdentifier];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        cityCell.cityNameLabel.text = searchResults[indexPath.row];
        
    }else {
        
        cityCell.cityNameLabel.text = cityArray[indexPath.row];
    }

    
    
    
    
     return cityCell;
 
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        [userDefaults setObject:searchResults[indexPath.row] forKey:KFcity];
        [userDefaults setObject:searchBankIDResults[indexPath.row] forKey:KcityID];
        
        dic = [NSDictionary dictionaryWithObjectsAndKeys:searchResults[indexPath.row],@"cityName",searchBankIDResults[indexPath.row],@"cityId", nil];
        
        
    }else {
        
        [userDefaults setObject:cityArray[indexPath.row] forKey:KFcity];
        [userDefaults setObject:cityID[indexPath.row] forKey:KcityID];
       
        dic = [NSDictionary dictionaryWithObjectsAndKeys:cityArray[indexPath.row],@"cityName",cityID[indexPath.row],@"cityId", nil];


    }
    
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"citytongzhi" object:dic];

    
        [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma UISearchDisplayDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"您点击了键盘上的Search按钮");
    
    [self.CitySearchBar resignFirstResponder];
    
    [self.CitySearchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    searchResults = [[NSMutableArray alloc]init];
    
    if (_CitySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_CitySearchBar.text]) {
        
        for (int i=0; i<cityArray.count; i++) {
            
            if ([ChineseInclude isIncludeChineseInString:cityArray[i]]) {
                
//                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:cityArray[i]];
//                NSRange titleResult=[tempPinYinStr rangeOfString:_CitySearchBar.text options:NSCaseInsensitiveSearch];
//                if (titleResult.length>0) {
//                    [searchResults addObject:cityArray[i]];
//                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:cityArray[i]];
                
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:_CitySearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleHeadResult.length>0) {
                    
                    [searchResults addObject:cityArray[i]];
                    
                }
            }
            else {
                NSRange titleResult=[cityArray[i] rangeOfString:_CitySearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0) {
                    
                    [searchResults addObject:cityArray[i]];
                }
            }
        }
        
        for (NSString *provincesStr in cityArray) {
            
            for (NSString *str1 in searchResults ){
                
                if ([str1 isEqualToString:provincesStr]){
                    
                    NSUInteger n = [cityArray indexOfObject:provincesStr];
                    
                    NSLog(@"n------%d",n);
                    
                    NSString *ID = [NSString stringWithFormat:@"%@",[cityID objectAtIndex:n]];
                    
                    NSLog(@"ID=====%@",ID);
                    
                    [searchBankIDResults addObject:ID];
                    
                    NSLog(@"searchProvincesIDResults=====%@",searchBankIDResults);
                }
            }
            
            
        }

        
        
        
        
        
        
        
        
        
    } else if (self.CitySearchBar.text.length > 0 && [ChineseInclude isIncludeChineseInString:self.CitySearchBar.text]) {
        for (NSString *tempStr in cityArray) {
            
            NSRange titleResult = [tempStr rangeOfString:self.CitySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length > 0) {
                [searchResults addObject:tempStr];
            }
            
        }
        
        for (NSString *provincesStr in cityArray) {
            for (NSString *str1 in searchResults ){
                if ([str1 isEqualToString:provincesStr]){
                    
                    NSUInteger n = [cityArray indexOfObject:provincesStr];
                    
                    NSLog(@"n------%d",n);
                    
                    NSString *ID = [NSString stringWithFormat:@"%@",[cityID objectAtIndex:n]];
                    
                    NSLog(@"ID=====%@",ID);
                    
                    [searchBankIDResults addObject:ID];
                    
                    NSLog(@"searchBankIDResults=====%@",searchBankIDResults);
                }
            }
        }
      
    }
}


@end
