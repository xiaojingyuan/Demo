//
//  AFCheckVersion.m
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-6-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFCheckVersion.h"
#import "AppDelegate.h"
static AFCheckVersion *_checkVersion=nil;
@implementation AFCheckVersion
-(void)checkVersionIsAuto:(BOOL)isAuto
{
    if ([AFTools isEnableNet]) {
        [AFWEBSERVES getDetailVideoWithString:URL_APPSTORE_VERSION_CHECK WithSuccessBlock:^(NSDictionary *dict) {
            NSString* netVersion=dict[@"results"][0][@"version"];
            if (![netVersion isEqual:[NSNull null]]) {
                NSString* localVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
                if ([netVersion isEqualToString:localVersion]) {
                    if (!isAuto) {
                        [AFTools alertWithTitle:@"版本检查结果" message:@"您使用的软件为最新版本!"];
                    }
                }
                else{//不相等 ，弹出提醒
                    if ([[[netVersion componentsSeparatedByString:@"."] componentsJoinedByString:@""] intValue] > [[[localVersion componentsSeparatedByString:@"."] componentsJoinedByString:@""] intValue]) {
                        [AFTools alertViewWithTitle:@"检查到新的版本" message:[NSString stringWithFormat:@"最新版本: %@ \n当前版本: %@\n更新内容:\n%@",netVersion,localVersion,dict[@"results"][0][@"releaseNotes"]] delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"去更新"];
                    }
                    else{
                        if (!isAuto) {
                            [AFTools alertWithTitle:@"版本检查结果" message:@"您使用的软件为最新版本!"];
                        }
                    }
                }
            }
        } andFailBlock:^{
        }];
    }
    else{
        [AFTools alertWithTitle:@"版本检查结果" message:@"当前没有网络连接，无法检查是否有新版本"];
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_APPSTORE]];
    }
}
#pragma mark - common
-(void)dealloc
{
    [super dealloc];
}
- (id)init{
    self=[super init];
    if (self) {
    }
    return self;
}
+ (id)sharedCheckVersion{
    static dispatch_once_t predCheckVersion;
    dispatch_once(&predCheckVersion, ^{
        _checkVersion=[[AFCheckVersion alloc] init];
    });
    return _checkVersion;
}
+(id)alloc
{
	NSAssert(_checkVersion == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

@end
