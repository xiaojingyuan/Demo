//
//  MCDefineHeader.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#ifndef MC_MCDefineHeader_h
#define MC_MCDefineHeader_h

/**
 此文件需要引用在
 #import <Foundation/Foundation.h>
 后面
 因为重定义了NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define DLog(FORMAT, ...) fprintf(stderr,"%s\n", \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define DDLog(o) DLog(@"%@", (o))
#define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#define NPO(o) NSLog(@"%@", (o))
#define NPD(o) NSLog(@"%d", (o))
#define NPLD(o) NSLog(@"%ld", (o))
#define NPF(o) NSLog(@"%f", (o))
#define NPS(o) NSLog(NSStringFromCGSize(o))
#define NPR(o) NSLog(NSStringFromCGRect(o))
#define DOBJ(obj)  NSLog(@"%s: %@", #obj, [(obj) description])
#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) NSLog([NSString stringWithFormat:"%@ Time = %f", msg, \
[NSDate timeIntervalSinceReferenceDate] - start]);
#else
#define NSLog(FORMAT, ...) nil
#define DLog(FORMAT, ...) nil
#define DDLog(o) nil
#define ULog(fmt, ...) nil
#define NPO(o) nil
#define NPD(o) nil
#define NPLD(o) nil
#define NPF(o) nil
#define NPS(o) nil
#define NPR(o) nil
#define DOBJ(obj) nil
#define MARK nil
#define START_TIMER nil
#define END_TIMER(msg) nil
#endif

//***************************************
//通知的定义
#define LOGIN_SUCCESS_NOTIFICATION      @"L_O_G_I_N_SUCCESS_NOTIFICATION"
#define BUY_SUCCESS_NOTIFICATION        @"B_U_Y_SUCCESS_NOTIFICATION"
#define VIP_SUCCESS_NOTIFICATION        @"V_I_P_SUCCESS_NOTIFICATION"
#define DOWN_SUCCESS_NOTIFICATION       @"D_O_W_N_SUCCESS_NOTIFICATION"

//****************************************
//系统配置
#define NDSUD [NSUserDefaults standardUserDefaults]
#define NNCDC [NSNotificationCenter defaultCenter]
#define FM    [NSFileManager defaultManager]
#define APPSHAREAPP [UIApplication sharedApplication]
#define appOrientation [[UIApplication sharedApplication] statusBarOrientation]
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define IOSSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//当前应用版本 版本比较用
#define APP_CURRENT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//GCD
#define BLOCKEXEC(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define BLOCKMAINEXEC(block) dispatch_async(dispatch_get_main_queue(), block)

//Device
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//区分模拟器和真机
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

#define FONT_OF_GLOBAL(SIZE)       [UIFont fontWithName:@"Heiti SC" size:SIZE]
#define COLOR_OF_GREEN_IPAD        COLOR_HEX_RGB(0x7eb706)
#define HEIGHT_ADJUST_IOS7_BAR     ((IOSSystemVersion >= 7.0)?20:0)
#define AFTRY    @try {

#define AFCATCH    }\
@catch (NSException *exception) {\
NSString* info = [NSString stringWithFormat:@"exception = %@\n Class = %@\n SEL = %@\n USER = %@\n",exception,self,NSStringFromSelector(_cmd),[AFUSER uid]];\
NSLog(@"info = %@",info);\
[AFHTTPSERVES commitRunningLog:info];\
if ([AFGLOBALDATA isDebug]) {\
[AFTools alertWithTitle:@"DEBUG" message:info];\
}\
}
#endif
