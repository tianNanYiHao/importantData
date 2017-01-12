//
//  AuthenticationEnterpriseModel.h
//  QuickPos
//
//  Created by Lff on 16/7/27.
//  Copyright © 2016年 张倡榕. All rights reserved.
//


/*
 "id": 9317,
 "code": "lalsc",
 "name": "上海辰凯农贸综合市场经营管理有限公司隆安路分公司",
 "alias": "",
 "description": "",
 "foodLicense": "JY13101160000083",
 "foodLicenseUrl": "http://www.shfda.org/platform/download/labelfile.do?id=local://e-9317/enterprise/abe4f8d0-e503-4916-b7d3-a30de0028bd1.jpg",
 "regionProvince": "上海",
 "regionCity": "金山区",
 "regionDistrict": "石化所",
 "address": "石化隆安路363弄25号1层",
 "zip": "",
 "email": "544780949@qq.com",
 "contact": "王友光",
 "tel": "13505505955",
 "fieldName": "retailer",
 "country": "中国",
 "province": "上海",
 "city": "金山区",
 "linkTemplate": ""
 */


#import <Foundation/Foundation.h>

@interface AuthenticationEnterpriseModel : NSObject
@property (nonatomic,strong) NSString *ID ;
@property (nonatomic,strong) NSString *code ;
@property (nonatomic,strong) NSString *name ;
@property (nonatomic,strong) NSString *regionProvince ;
@property (nonatomic,strong) NSString *regionCity ;
@property (nonatomic,strong) NSString *regionDistrict ;
@property (nonatomic,strong) NSString *address ;
@property (nonatomic,strong) NSString *descriptions;


@property (nonatomic,strong) NSMutableArray *infoModelArray;

-(instancetype) initWithArrayM:(NSArray*)array;




@end
