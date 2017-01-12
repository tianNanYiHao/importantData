//
//  ME11Controller.h
//  ipos
//
//  Created by ZhangSx on 14-11-18.
//
//

#import <Foundation/Foundation.h>
#import <MESDK/MESDK.h>

#define CString(s, ... ) [NSString stringWithFormat:s, ##__VA_ARGS__]
@interface ME11Controller : NSObject<NLEmvControllerListener>
@property (nonatomic, strong) id<NLDevice> device;
@property (nonatomic, strong) id<NLDeviceDriver> driver;
+(ME11Controller *)getInstance;
-(NSString *)deviceInfo;
- (void)startReadCard:(NSDictionary*)data;
@end
