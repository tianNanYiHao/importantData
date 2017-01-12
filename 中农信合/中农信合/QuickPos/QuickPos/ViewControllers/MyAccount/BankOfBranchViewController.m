//
//  BankOfBranchViewController.m
//  QuickPos
//
//  Created by Leona on 15/3/13.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "BankOfBranchViewController.h"
#import "BranchTableViewCell.h"
#import "Common.h"


@interface BankOfBranchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,ResponseData>{
    
    NSMutableArray *branchArray;//支行数组
    
    NSMutableArray *branchIDArray;//支行id数组
    
    NSMutableArray *searchResults;//搜索数组
    
    NSMutableArray *searchBankIDResults;//搜索对应的银行id数组
    
    UISearchDisplayController *searchDisplayController;//搜索控制
    
    NSDictionary *dataDic;//请求返回字典
    
    NSDictionary *userDefaultsDic;//存取
    
    Request *request;
}

@property (weak, nonatomic) IBOutlet UITableView *bankOfBranchTableView;//tableView

@property (weak, nonatomic) IBOutlet UISearchBar *branchSearchBar;//搜索栏

@end

@implementation BankOfBranchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = L(@"BranchList");
    
    request = [[Request alloc]initWithDelegate:self];
    
    branchArray = [NSMutableArray array];
    dataDic = [NSDictionary dictionary];
    branchIDArray = [NSMutableArray array];
    searchBankIDResults = [NSMutableArray array];
    searchResults = [NSMutableArray array];
    
    [Common setExtraCellLineHidden:self.bankOfBranchTableView];
    
    self.bankOfBranchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:self.branchSearchBar contentsController:self];
    
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    self.branchSearchBar.delegate = self;

    
    self.bankOfBranchTableView.tableHeaderView = self.branchSearchBar;
    
    [request GetBranch];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES WithString:L(@"MBPLoading")];
    
    [hud hide:YES afterDelay:1];

}

- (void)responseWithDict:(NSDictionary *)dict requestType:(NSInteger)type{
    
    if(type == REQUSET_Branch && [dict[@"respCode"]isEqual:@"0000"]){
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        dataDic = dict;
    
        NSDictionary *getDic = dataDic[@"data"];
        
        NSArray *resultBeanrray = getDic[@"resultBean"];
    
        for (userDefaultsDic in resultBeanrray) {
    
            
        [branchArray addObject:userDefaultsDic[@"bankName"]];
        [branchIDArray addObject:userDefaultsDic[@"bankId"]];
        
     
        
    }
    
    
        [self.bankOfBranchTableView reloadData];
        
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
        return branchArray.count;

    }
    
    
    return branchArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *BranchCellIdentifier = @"BranchTableViewCell";
    
    BranchTableViewCell *branchCell = (BranchTableViewCell *) [self.bankOfBranchTableView dequeueReusableCellWithIdentifier:BranchCellIdentifier];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        branchCell.branchNameLabel.text = searchResults[indexPath.row];
        branchCell.branchNameLabel.adjustsFontSizeToFitWidth = YES;

        
    }else {
        
        branchCell.branchNameLabel.text = branchArray[indexPath.row];
        branchCell.branchNameLabel.adjustsFontSizeToFitWidth = YES;

    }

 
    
    return branchCell;
    

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        [userDefaults setObject:searchResults[indexPath.row] forKey:KFbranch];
        [userDefaults setObject:searchBankIDResults[indexPath.row] forKey:branchID];
      
        dic = [NSDictionary dictionaryWithObjectsAndKeys:searchResults[indexPath.row],@"branchName",searchBankIDResults[indexPath.row],branchID, nil];
        
    }else {
        
        [userDefaults setObject:branchArray[indexPath.row] forKey:KFbranch];
        [userDefaults setObject:branchIDArray[indexPath.row] forKey:branchID];
        
        dic = [NSDictionary dictionaryWithObjectsAndKeys:branchArray[indexPath.row],@"branchName",branchIDArray[indexPath.row],@"branchId", nil];
    }
    
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"branchtongzhi" object:dic];

     [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma UISearchDisplayDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"您点击了键盘上的Search按钮");
    
    [self.branchSearchBar resignFirstResponder];
    
    [self.branchSearchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    searchResults = [[NSMutableArray alloc]init];
    
    if (_branchSearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_branchSearchBar.text]) {
        
        for (int i=0; i<branchArray.count; i++) {
            
            if ([ChineseInclude isIncludeChineseInString:branchArray[i]]) {
                
//                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:branchArray[i]];
//                NSRange titleResult=[tempPinYinStr rangeOfString:_branchSearchBar.text options:NSCaseInsensitiveSearch];
//                if (titleResult.length>0) {
//                    [searchResults addObject:branchArray[i]];
//                }
                
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:branchArray[i]];
                
                NSRange titleHeadResult = [tempPinYinHeadStr rangeOfString:_branchSearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleHeadResult.length>0) {
                    
                    [searchResults addObject:branchArray[i]];
                    
                }
            }
            else {
                
                NSRange titleResult = [branchArray[i] rangeOfString:_branchSearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleResult.length > 0) {
                    
                    [searchResults addObject:branchArray[i]];
                }
            }
        }
        
       
        
        
        
        
        
    } else if (self.branchSearchBar.text.length > 0 && [ChineseInclude isIncludeChineseInString:self.branchSearchBar.text]) {
        
        for (NSString *tempStr in branchArray) {
            
            NSRange titleResult = [tempStr rangeOfString:_branchSearchBar.text options:NSCaseInsensitiveSearch];
            
            if (titleResult.length>0) {
                
                [searchResults addObject:tempStr];
            }
        }
        for (NSString *provincesStr in branchArray) {
            for (NSString *str1 in searchResults ){
                if ([str1 isEqualToString:provincesStr]){
                    
                    NSUInteger n = [branchArray indexOfObject:provincesStr];
                    
                    NSLog(@"n------%d",n);
                    
                    NSString *ID = [NSString stringWithFormat:@"%@",[branchIDArray objectAtIndex:n]];
                    
                    NSLog(@"ID=====%@",ID);
                    
                    [searchBankIDResults addObject:ID];
                    
                    NSLog(@"searchBankIDResults=====%@",searchBankIDResults);
                }
            }
        }
        
    }
}

        
@end
