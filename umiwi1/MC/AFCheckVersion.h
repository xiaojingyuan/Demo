//
//  AFCheckVersion.h
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-6-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>
//评分及程序更新相关
#define AFCHECKVERSION [AFCheckVersion sharedCheckVersion]
#define AppIdInAppStore (isPad)?(@"491273690"):(@"464253192")
#define PingFenURL [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8",AppIdInAppStore]
#define URL_APPSTORE [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@?mt=8",AppIdInAppStore]
#define URL_APPSTORE_VERSION_CHECK [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@&country=cn",AppIdInAppStore]
@interface AFCheckVersion : NSObject<UIAlertViewDelegate>
+ (id)sharedCheckVersion;
#pragma mark - 检查版本
-(void)checkVersionIsAuto:(BOOL)isAuto;
@end
