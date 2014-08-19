//
//  AFTools.h
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-3-22.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

//做一个基于自定义框架，符合与项目的类
//里面全部是一些自定义的定制函数
/* @"App Store",@"优米网",@"91",@"快用",@"多多",
 @"PP助手",@"同步推",@"威锋",@"当乐网",
 */
#define CHANNEL_ID 0
//测时间的
#include <mach/mach.h>
#include <mach/mach_time.h>
#include <unistd.h>
//测试的时间用法
#define AFTimeStart       static uint64_t __AFStartTime__ = mach_absolute_time();
#define AFTimeEndANDOut   uint64_t __AFDrawTime__ = mach_absolute_time() - __AFStartTime__; \
    mach_timebase_info_data_t __AFInfo__;  \
    uint64_t __AFNanos__ = __AFDrawTime__ * __AFInfo__.numer / __AFInfo__.denom;\
    NSLog(@"AFTime=%fs",(CGFloat)__AFNanos__ / NSEC_PER_SEC);

@interface AFTools : NSObject{
}
#pragma mark - 设备的唯一识别ID
+ (NSString*)uniqueDeviceIdentifier;
#pragma mark - 会员视频加密解密
+ (void)decodeMp4File:(NSString *)srcString;
+ (void)encodeMp4File:(NSString *)srcString;
#pragma mark - 与AppStore有关
+ (NSString*)channelName;
+ (BOOL)isNewVersionOutStore;
+ (BOOL)isAppStore;
#pragma mark - MBProgressHUD
+ (void)removeHUD;
+ (void)showHUD:(NSString *)msg atView:(UIView*)view;
+ (void)showHUD:(NSString *)msg;
#pragma mark - SVWebViewController 专门打开URL用
+ (void)openURLString:(NSString*)urlString onViewController:(UIViewController*)vc;

#pragma mark - TKAlertCenter 提示框
+ (void)alertTKWithMessage:(NSString*)msg;

#pragma mark - 判断网络
// 是否wifi
+ (BOOL) isEnableWIFI;
// 是否3G
+ (BOOL) isEnable3G;
// 是否有网络链接
+ (BOOL) isEnableNet;
#pragma mark - 时间戳
+ (NSString*)getDayTimeStamp;
+ (NSString*)getHourTimeStamp;
+ (NSString*)getMinuteTimeStamp;
+ (NSString*)getSecondTimeStamp;
#pragma mark - Alert弹出框
+ (void)alertWithTitle:(NSString *)title message:(NSString*)msg;
+ (void)alertWithTitle:(NSString *)title message:(NSString*)msg andDelegate:(id<UIAlertViewDelegate>)delegate;
+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle;


@end
