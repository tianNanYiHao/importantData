//
//  ViewController.m
//  transTableview
//
//  Created by tianNanYiHao on 2017/3/27.
//  Copyright © 2017年 tianNanYiHao. All rights reserved.
//

#import "ViewController.h"
#import "HtmlViewController.h"
#import "TransferTableViewCell.h"
#import "TransferPayToolSelMode.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TransferTableViewCellDelegate>
{
    UITableView *tbaleView;
    TransferTableViewCell *transFerCell;
    TransferPayToolSelMode *modelM;
    
    NSArray *titleArray;
    
    NSMutableArray *selectedArray;

}

@property (nonatomic,strong)NSMutableArray *selectedArray;
@property (nonatomic,strong)NSMutableArray *arr;
@end


@implementation ViewController
/**
 选中的对象数组
 */
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }return _selectedArray;
}

- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray new];
    }return _arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"Demo";
    titleArray = @[@"消费余额",@"现金余额",@"现金余额",@"现金余额",@"消费余额",@"现金余额",@"现金余额",@"现金余额",@"消费余额",@"现金余额",@"现金余额",@"现金余额",@"消费余额",@"现金余额",@"现金余额",@"现金余额"];
    for (int i = 0; i<titleArray.count; i++) {
        modelM = [[TransferPayToolSelMode alloc] init];
        modelM.payToolTitle = titleArray[i];
        modelM.index = i+1;
        [self.arr addObject:modelM];
    }

    
    
    tbaleView = [[UITableView alloc] init];
    tbaleView.frame = [UIScreen mainScreen].bounds;
    tbaleView.delegate = self;
    tbaleView.dataSource = self;
    [self.view addSubview:tbaleView];
}

#pragma mark TransferPayToolCellDelegate
-(void)showRightImageView:(UIButton *)btn{
    //存储状态
    
    if ([self.selectedArray containsObject:@(btn.tag)]) {
        [self.selectedArray removeObject:@(btn.tag)];
    }else{
        [self.selectedArray addObject:@(btn.tag)];
    }
    NSLog(@"%@",self.selectedArray);
    
    [tbaleView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    transFerCell = [TransferTableViewCell cellWithTableview:tableView];
    transFerCell.model = self.arr[indexPath.row];
    transFerCell.delegate = self;
    transFerCell.selectArr = self.selectedArray;
    return transFerCell;
}




@end
