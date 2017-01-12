//
//  NoteViewController.m
//  QuickPos
//
//  Created by 胡丹 on 15/4/24.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.noteTextView.text = [self.item objectForKey:@"announce"];
    self.navigationItem.title = [self.item objectForKey:@"title"];
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
