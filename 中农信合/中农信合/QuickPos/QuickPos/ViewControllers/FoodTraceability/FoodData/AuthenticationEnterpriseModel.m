//
//  AuthenticationEnterpriseModel.m
//  QuickPos
//
//  Created by Lff on 16/7/27.
//  Copyright © 2016年 张倡榕. All rights reserved.
//

#import "AuthenticationEnterpriseModel.h"
@interface AuthenticationEnterpriseModel(){
//    NSMutableArray *_arrayModel;
    
}
@end
@implementation AuthenticationEnterpriseModel
- (instancetype)initWithArrayM:(NSArray*)array{
    if (self) {
        if (!self.infoModelArray) {
            self.infoModelArray = [[NSMutableArray alloc]init];
        }
        for (NSDictionary *dict in array) {
            AuthenticationEnterpriseModel *model = [[AuthenticationEnterpriseModel alloc]initWithDict:dict];
            [self.infoModelArray addObject:model];
        }

    }return self;
    

}
-(instancetype)initWithDict:(NSDictionary *)dictt{
    if (self = [super init]) {
        self.ID = [dictt objectForKey:@"id"] ;
        self.code = [dictt objectForKey:@"code"];
        self.name = [dictt objectForKey:@"name"];
        self.regionProvince = [dictt objectForKey:@"regionProvince"];
        self.regionCity = [dictt objectForKey:@"regionCity"];
        self.regionDistrict = [dictt objectForKey:@"regionDistrict"];
        self.regionCity = [dictt objectForKey:@"regionCity"];
        
        NSString *s = [NSString stringWithFormat:@"%@",dictt];
        NSString *ss = @"description = ,";
        NSString *sss = @"description = ";
        NSLog(@"%d",ss.length);
        if ([s rangeOfString:@"description"].location != NSNotFound) {
            if ([s rangeOfString:ss].location != NSNotFound) {
                NSLog(@"donothing");
            }else if ([s rangeOfString:sss].location != NSNotFound){
                NSLog(@"donothing2");
            }else{
                 self.descriptions = [dictt objectForKey:@"description"];
            }
        }
        
    }return self;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
