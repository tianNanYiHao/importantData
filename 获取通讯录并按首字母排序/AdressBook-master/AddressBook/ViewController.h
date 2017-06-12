//
//  ViewController.h
//  AddressBook
//
//  Created by 肖友 on 16/3/4.
//  Copyright © 2016年 肖友. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
//#import <Contacts/Contacts.h>



@interface XYCustomCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *summaryLabel;
@property (nonatomic, strong)UIButton *rightButton;

@end

@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong)NSMutableArray *linkManArray;
@property (nonatomic, strong)UITableView    *linkManTableView;
@property (nonatomic, strong)NSMutableArray *tableHeaderArray;//保存分组的组头
@property (nonatomic, strong)NSMutableArray *sortedArrForArrays;//保存每组的联系人

@end

