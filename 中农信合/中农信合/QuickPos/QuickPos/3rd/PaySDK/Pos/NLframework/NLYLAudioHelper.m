//
//  NLYLAudioHelper.m
//  ipos
//
//  Created by ZhangSx on 14-11-18.
//
//

#import "NLYLAudioHelper.h"
@interface NLYLAudioHelper()<NLAudioPortListener>
@property (nonatomic,strong) id<NLYLAudioListener> delegate;
@end
static NLYLAudioHelper * sharedInstance = nil;
@implementation NLYLAudioHelper
@synthesize delegate;
+(BOOL)isNLDevicePresent
{
  return  [NLAudioPortHelper isDevicePresent];
}
+(void)unregisterNLAudioPortListener
{
    [NLAudioPortHelper unregisterAudioPortListener];
}
+(void)registerNLAudioPortListener:(id<NLYLAudioListener>)listener
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc]initWithListener:listener];
        }
    }
}
-(id)initWithListener:(id<NLYLAudioListener>)listener
{
    self = [super init];
    if (self) {
        delegate = listener;
        [NLAudioPortHelper registerAudioPortListener:self];
    }
    return self;
}
#pragma mark - NLAudioPortListener
-(void)onDevicePlugged
{
    if ([delegate respondsToSelector:@selector(onNLDevicePlugged)]) {
        [delegate onNLDevicePlugged];
    }
}
-(void)onDeviceUnplugged
{
    if ([delegate respondsToSelector:@selector(onNLDeviceUnplugged)]) {
        [delegate onNLDeviceUnplugged];
    }
}
@end
