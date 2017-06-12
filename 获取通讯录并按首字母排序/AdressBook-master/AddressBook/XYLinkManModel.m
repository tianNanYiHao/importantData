//
//  XYLinkManModel.m
//  AddressBook
//
//  Created by 肖友 on 16/3/4.
//  Copyright © 2016年 肖友. All rights reserved.
//

#import "XYLinkManModel.h"

@implementation XYLinkManModel


- (instancetype)init{
    if (self = [super init]) {
        _emailCount     = [[NSMutableArray alloc] init];
        _address        = [[NSMutableArray alloc] init];
        _dates          = [[NSMutableArray alloc] init];
        _instantMessage = [[NSMutableArray alloc] init];
        _phones          = [[NSMutableArray alloc] init];
        _url            = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)setPhones:(NSMutableArray *)phones{
    _phones = phones;
    
    NSArray *phoneArray = phones;
    NSMutableArray *newPhoneArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < phoneArray.count; i++) {
            NSArray *tempPhoneArray = phoneArray[i];
            NSString *phoneLabel = tempPhoneArray[0];
            NSString *phoneNumber = tempPhoneArray[1];
            NSString *pattern = @"((^\\+86)?\\d{3}-\\d{3,4}-)|(^\\+86)";
            NSString *pattern1 = @"^\\+\\d{2}";
            NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern1 options:0 error:nil];
            NSArray *results = [regex matchesInString:phoneNumber options:0 range:NSMakeRange(0, phoneNumber.length)];
            NSMutableString *mString = [[NSMutableString alloc] initWithString:phoneNumber];
            
            if (results.count > 0) {
                for (NSTextCheckingResult *result in results) {
                    [mString deleteCharactersInRange:result.range];
                }
            }
            
            while (1) {
                NSRange range = [mString rangeOfString:@"-"];
                if (range.location != NSNotFound) {
//                   NSString *string = [NSString  stringWithString:mString];
                     mString = [mString stringByReplacingCharactersInRange:range withString:@""];
//                   mString = [NSMutableString stringWithString:string];
                }else{
                    break;
                }
            }
            if (mString.length > 6) {
            mString = [mString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

            }
            NSString *tempStr = [self removeNoUseCharOfString:mString];
            tempPhoneArray = [NSArray arrayWithObjects:phoneLabel, tempStr, nil];
            [newPhoneArray addObject:tempPhoneArray];
            _phones = newPhoneArray;
        }
}
- (NSString *)removeNoUseCharOfString:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"#" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"(" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@")" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"-" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return temp;
}

@end
