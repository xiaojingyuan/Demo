//
//  AFTools.m
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-3-22.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFTools.h"
#import <AFGithub/AFGithub.h>
#import "SVWebViewController.h"
#import "MobClick.h"
#import "AppDelegate.h"

static MBProgressHUD *HUD = nil;
static NSDateFormatter *_dateFormatter = nil;
static dispatch_once_t predDateFormatter;
@implementation AFTools
#pragma mark - 设备的唯一识别ID
+ (NSString*)uniqueDeviceIdentifier
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.0f) {
        return [[[[UIDevice currentDevice] identifierForVendor] UUIDString] md5String];
    }
    else{
        return [UIDevice uniqueDeviceIdentifier];
    }
}
#pragma mark - 会员视频加密解密
+ (void)decodeMp4File:(NSString *)srcString
{
    //NSLog(@"解密");
    //AFTimeStart
    //NSLog(@"decode:%@",srcString);
    if (![FM fileExistsAtPath:srcString]) {
        /*
         容错，忘记加起始路径的情况
         */
        srcString = [DocumentPath stringByAppendingPathComponent:srcString];
    }
    if (![FM fileExistsAtPath:srcString]) {
        /*
         加了起始路径还不存在就算了
         */
        return;
    }
    //根据文件名拿一个md5的串
    //把md5的串转换成NSData
    NSData *_encodeData= [[srcString md5String] dataUsingEncoding:NSASCIIStringEncoding];
    
    NSFileHandle *_encodedFile = [NSFileHandle fileHandleForUpdatingAtPath:srcString];
    if (_encodedFile) {
        NSData *_oldHeaderData = [_encodedFile readDataOfLength:_encodeData.length];
        if ([_oldHeaderData isEqualToData:_encodeData]) {
            //说明需要解密
            NSInteger _fileLength = _encodedFile.seekToEndOfFile;
            [_encodedFile seekToFileOffset:_fileLength - _encodeData.length];
            NSData *_headOfOk = [_encodedFile readDataToEndOfFile];
            [_encodedFile seekToFileOffset:0];
            [_encodedFile writeData:_headOfOk];
            [_encodedFile truncateFileAtOffset:_fileLength - _encodeData.length];
        }
        else{
            /*
             可能存在解密以后未加密的情况。
             */
        }
        [_encodedFile closeFile];
    }
    //AFTimeEndANDOut
}
+ (void)encodeMp4File:(NSString *)srcString{
    /*
     说下加密原理:
     1.把文件路径的32字节的MD5值转成二进制
     2.获取视频文件的文件头，长度和上面的二进制一致
     3.把上面的二进制写到视频的文件头
     4.把视频真正的文件头写到文件尾
     */
    //传说中的加密部分
    //NSLog(@"encode:%@",srcString);
    //NSLog(@"加密");
    //AFTimeStart
    if (![FM fileExistsAtPath:srcString]) {
        srcString = [DocumentPath stringByAppendingPathComponent:srcString];
    }
    if (![FM fileExistsAtPath:srcString]) {
        return;
    }
    NSString *_headStr = [srcString md5String];
    NSLog(@"_headStr.length=%d",_headStr.length);
    //NSLog(@"encode _headStr:%@",_headStr);
    NSFileHandle *_encodeFile = [NSFileHandle fileHandleForUpdatingAtPath:srcString];
    if (_encodeFile) {
        NSData *_headDataNew = [_headStr dataUsingEncoding:NSASCIIStringEncoding];
        NSData *_headDataOld = [_encodeFile readDataOfLength:_headDataNew.length];
        NSLog(@"_headDataNew.length=%d",_headDataNew.length);
        if ([_headDataOld isEqualToData:_headDataNew]) {
            //NSLog(@"已经替换过了？");
        }
        else{
            //写入文件头
            [_encodeFile seekToFileOffset:0];
            [_encodeFile writeData:_headDataNew];
            //把原来的头写到尾
            [_encodeFile seekToEndOfFile];
            [_encodeFile writeData:_headDataOld];
        }
        [_encodeFile closeFile];
    }
    //AFTimeEndANDOut
}
#pragma mark - 与AppStore有关
+ (NSString*)channelName
{
    NSArray* channelArray=[NSArray arrayWithObjects:@"App Store",@"优米网",@"91",@"快用",@"多多",@"PP助手",@"同步推",@"威锋",@"当乐网",@"苹果园",@"猫人吧", nil];
    NSString* nowChannel=[channelArray objectAtIndex:CHANNEL_ID];
    return nowChannel;
}
+ (BOOL)isNewVersionOutStore
{
    if ([self isAppStore]) { //是不是APPStore版本 isNewVersionOutStore
        int currentVersion=[[NDSUD objectForKey:@"version"] intValue];
        int online=[[MobClick getConfigParams:@"iOS"] intValue];
        //NSLog(@"currentVersion=%d,online=%d>>%d",currentVersion,online,(currentVersion < online));
        if (currentVersion < online) {
            return YES;
        }
        else{
            return NO;
        }
    }
    else{
        return YES;
    }
}
+ (BOOL)isAppStore
{
    return (CHANNEL_ID == 0);
}
#pragma mark - MBProgressHUD
+ (void)removeHUD
{
    [HUD hide:YES];
    [HUD removeFromSuperViewOnHide];
    [HUD release];
    HUD = nil;
}
+ (void)showHUD:(NSString *)msg atView:(UIView*)view
{
    if (HUD == nil) {
        HUD= [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        HUD.labelText = msg;
        [HUD show:YES];
    }
}
+ (void)showHUD:(NSString *)msg
{
    if (HUD == nil) {
        HUD= [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] windows][0]];
        [[[UIApplication sharedApplication] windows][0] addSubview:HUD];
        HUD.labelText = msg;
        [HUD show:YES];
    }
}
#pragma mark - SVWebViewController 专门打开URL用
+ (void)openURLString:(NSString*)urlString onViewController:(UIViewController*)vc
{
    if ([self isEnableNet]) {
//        if (isPad) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25f;
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithAddress:urlString];
        webViewController.hidesBottomBarWhenPushed = YES;
        [vc.navigationController.view.layer addAnimation:transition forKey:nil];
        [vc.navigationController pushViewController:webViewController animated:NO];
        [webViewController release];
//        }
//        else{
//            SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:urlString];
//            webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsOpenInChrome | SVWebViewControllerAvailableActionsCopyLink | SVWebViewControllerAvailableActionsMailLink;
//            webViewController.modalPresentationStyle=UIModalPresentationFullScreen;
//            [vc presentModalViewController:webViewController animated:YES];
//            [webViewController release];
//        }

    } else {
        [self alertTKWithMessage:@"当前没有网络连接"];
    }
}
#pragma mark - TKAlertCenter 提示框
+ (void)alertTKWithMessage:(NSString*)msg
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:msg];
}
#pragma mark - 判断网络
// 是否wifi
+ (BOOL) isEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}
// 是否3G
+ (BOOL) isEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
// 是否有网络链接
+ (BOOL) isEnableNet{
    return ([self isEnable3G] || [self isEnableWIFI]);
}
#pragma mark - 时间戳
+ (NSString*)getDayTimeStamp
{
    dispatch_once(&predDateFormatter, ^{
        _dateFormatter=[[NSDateFormatter alloc] init];
    });
    [_dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *timeStamp = [_dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
}
+ (NSString*)getHourTimeStamp
{
    dispatch_once(&predDateFormatter, ^{
        _dateFormatter=[[NSDateFormatter alloc] init];
    });
    [_dateFormatter setDateFormat:@"yyyyMMddHH"];
    NSString *timeStamp = [_dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
}
+ (NSString*)getMinuteTimeStamp
{
    dispatch_once(&predDateFormatter, ^{
        _dateFormatter=[[NSDateFormatter alloc] init];
    });
    [_dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    NSString *timeStamp = [_dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
}
+ (NSString*)getSecondTimeStamp
{
    dispatch_once(&predDateFormatter, ^{
        _dateFormatter=[[NSDateFormatter alloc] init];
    });
    [_dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeStamp = [_dateFormatter stringFromDate:[NSDate date]];
    return timeStamp;
}
#pragma mark - 弹出框
+ (void)alertWithTitle:(NSString *)title message:(NSString*)msg
{
    [self alertWithTitle:title message:msg andDelegate:nil];
}
+ (void)alertWithTitle:(NSString *)title message:(NSString*)msg andDelegate:(id<UIAlertViewDelegate>)delegate
{
    [self alertViewWithTitle:title message:msg delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
}
+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle 
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    alert.transform = CGAffineTransformTranslate(alert.transform, 0.0, 25);
    if (IOSSystemVersion < 7.0) {
        [alert setContentLabelAlignment:NSTextAlignmentLeft];
    }
    else{
        for(UIView * v in [alert subviews]){
            if( [v isKindOfClass:[UILabel class]] ){
                    UILabel *label = (UILabel*)v;
                    label.textAlignment = NSTextAlignmentLeft;
                NSLog(@"textAlignment = %d",label.textAlignment);
            }
        }
    }
    
    [alert show];
    [alert release];
}
@end
