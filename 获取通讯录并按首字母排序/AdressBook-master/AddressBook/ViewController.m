//
//  ViewController.m
//  AddressBook
//
//  Created by 肖友 on 16/3/4.
//  Copyright © 2016年 肖友. All rights reserved.
//

#import "ViewController.h"
#import "XYLinkManModel.h"
#define XYCell @"XYCell"
#import "ICPinyinGroup.h"

@implementation XYCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 45, 45)];
        self.headImageView.layer.cornerRadius = 8;
        [self.contentView addSubview:self.headImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 20)];
        [self.contentView addSubview:self.titleLabel];
        
        self.summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 200, 20)];
        [self.contentView addSubview:self.summaryLabel];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.rightButton.frame = CGRectMake(280, 15, 50, 30);
        [self.rightButton setTitle:@"添加" forState:UIControlStateNormal];
        self.rightButton.backgroundColor = [UIColor greenColor];
        self.rightButton.layer.cornerRadius = 5;
        [self.contentView addSubview:self.rightButton];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"联系人";
    [self createLinkManTableView];
    [self loadPresion];
}

- (void)createLinkManTableView{
    self.linkManTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.linkManTableView.delegate = self;
    self.linkManTableView.dataSource = self;
    [self.view addSubview:self.linkManTableView];
    [self.linkManTableView registerClass:[XYCustomCell class] forCellReuseIdentifier:XYCell];
}

- (void)loadPresion{
  
    ABAddressBookRef addressBookref = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookref, ^(bool granted, CFErrorRef error) {
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        CFErrorRef *error1 = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
        [self copyAddressBook:addressBook];
    
    }else{
        UIAlertView *alert  = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有获取通讯录权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.delegate = self;
        [alert show];
    }
}

- (void)copyAddressBook:(ABAddressBookRef)addressBook{
    //获取联系人个数
    CFIndex numberOfPeoples = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef peoples = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSLog(@"有%ld个联系人", numberOfPeoples);
    //循环获取联系人
    for (int i = 0; i < numberOfPeoples; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(peoples, i);
        XYLinkManModel *linkMan = [[XYLinkManModel alloc] init];
        linkMan.firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        linkMan.lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        linkMan.nickName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
        linkMan.organiztion = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        linkMan.headImage = (__bridge NSData*)ABPersonCopyImageData(person);
        
        
        if (linkMan.firstName && linkMan.lastName) {
            linkMan.name = [NSString stringWithFormat:@"%@%@",linkMan.lastName, linkMan.firstName];
        }else if(!linkMan.firstName){
            linkMan.name = linkMan.lastName;
        }else{
            linkMan.name = linkMan.firstName;
        }
        if (!linkMan.name) {
            linkMan.name = linkMan.organiztion;
        }
        if (linkMan.nickName) {
            linkMan.name =[NSString stringWithFormat:@"%@", linkMan.nickName];
        }
        
        //读取电话多值
        NSMutableArray *phoneArray = [[NSMutableArray alloc] init];
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * tempstr = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            NSArray *array = [NSArray arrayWithObjects:personPhoneLabel, tempstr, nil];
            [phoneArray addObject:array];
        }
         linkMan.phones = phoneArray;
        [self.linkManArray addObject:linkMan];
    }
    NSDictionary *dict = [ICPinyinGroup group:self.linkManArray  key:@"name"];
  
    self.tableHeaderArray = [dict objectForKey:LEOPinyinGroupCharKey];
    self.sortedArrForArrays = [dict objectForKey:LEOPinyinGroupResultKey];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
}

- (void)reloadTable{
    [self.linkManTableView reloadData];

}
#pragma TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sortedArrForArrays count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.sortedArrForArrays objectAtIndex:section] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableHeaderArray objectAtIndex:section];
}
//侧边栏
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.tableHeaderArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:XYCell];
    
    if(self.sortedArrForArrays.count > indexPath.section){
        NSArray *array = [self.sortedArrForArrays objectAtIndex:indexPath.section];
        if (array.count > indexPath.row) {
            XYLinkManModel *linkManModel = [array objectAtIndex:indexPath.row];
            cell.headImageView.image = [UIImage imageWithData:linkManModel.headImage];
            if (!linkManModel.headImage) {
            cell.headImageView.image = [UIImage imageNamed:@"headImage"];
            }
            
            cell.titleLabel.text = linkManModel.name;
            if (linkManModel.phones.count == 0) {
                return cell;
            }
            NSString *numStr = @"电话";
            if (linkManModel.phones.count > 1){
                numStr = @"电话一";
            }
            NSArray *array = [linkManModel.phones objectAtIndex:0];
            cell.summaryLabel.text = [NSString stringWithFormat:@"%@:%@", numStr, [array objectAtIndex:1]];
        }
    }
    return cell;
}

- (NSMutableArray *)linkManArray{
    if (_linkManArray == nil) {
        _linkManArray = [[NSMutableArray alloc] init];
    }
    return _linkManArray;
}
- (NSMutableArray *)tableHeaderArray{
    if (_tableHeaderArray == nil) {
        _tableHeaderArray = [[NSMutableArray alloc] init];
    }
    return _tableHeaderArray;
}
- (NSMutableArray *)sortedArrForArrays{
    if (_sortedArrForArrays == nil) {
        _sortedArrForArrays = [[NSMutableArray alloc] init];
    }
    return _sortedArrForArrays;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
