//
//  CommenDef.h
//  shMetro3.0
//
//  Created by syzhou on 13-4-12.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//


#ifndef Tutor_CommenDef_h
#define Tutor_CommenDef_h

#define NavigationBar_HEIGHT 44
#define StatusBar_HEIGHT 20
#define TabBar_HEIGHT 49

#define kChangeToIphone5Height(x) (x * 320) / 1080

#define __WEAKSELF typeof(self) __weak wself = self;

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SAFE_RELEASE(x) [x release];x=nil
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define BACKGROUND_COLOR RGBCOLOR(245.0,245.0,245.0)

#define kDEFAUT_RED_COLOR  RGB(219, 42, 49)

#define isPad  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#define isIPhone5 ([[UIScreen mainScreen]bounds].size.height == 568)

#define isIPhone6 ([[UIScreen mainScreen]bounds].size.height == 667)
#define isIPhone6P ([[UIScreen mainScreen]bounds].size.height == 736)

#define IOS7 ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0 ? YES : NO)

#define IsIOS8_Or_Later ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0 ? YES : NO)

#define IOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS_App_Version  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)@"CFBundleShortVersionString"]

#define SYSTEMFONT(x) [UIFont systemFontOfSize:x]

#define JNSLOG(x,y) NSLog(@"",x,y)
//----------%@-------%@
#define fontYaHeiOfSize(fontSize) [UIFont fontWithName:@"FZXH1JW--GB1-0" size:fontSize]
#define fontSong(fontSize) [UIFont fontWithName:@"SimSun" size:fontSize]
#define fontDigital(fontSize) [UIFont fontWithName:@"DS-Digital" size:fontSize]
#define fontStr @"FZXH1JW--GB1-0"
#define ClearColor [UIColor clearColor]

#define iPhone_H 88

#define textBackGroundColor RGB(95, 96, 98)
#define textGrayColor RGB(138, 145, 141)
#define textPressColor [UIColor lightTextColor]


#define debug() do{\
NSLog(@"func = %s, line = %d, file = %s", __FUNCTION__, __LINE__, __FILE__);\
}while(0)

//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif


//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]



#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }


#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)



#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)

#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

#endif
