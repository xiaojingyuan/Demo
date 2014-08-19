//
//  AFUser.m
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-3-26.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFUser.h"
static AFUser *_afUser=nil;
@implementation AFUser

-(void)getMessageFromCookies
{
    //if (!_isUserLogin) {
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    //根据cookies来判断是否登陆
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        if ([cookie.domain isEqualToString:@".umiwi.com"]) {
            if ([cookie.name isEqualToString:@"username"]) {
                _isUserLogin=YES;
                [_username release];
                _username=[[cookie.value URLDecodedString] copy];
            }
            if ([cookie.name isEqualToString:@"U"]){
                NSArray* values=[[cookie.value URLDecodedString] componentsSeparatedByString:@"&"];
                [_uid release];
                _uid=[[[[values[0] componentsSeparatedByString:@"="] lastObject] URLDecodedString] copy];
                [_email release];
                _email=[[[[values[2] componentsSeparatedByString:@"="] lastObject] URLDecodedString] copy];
            }
        }
    }
    if (_isUserLogin) {
        [self getDetailMessageFromNetWithSuccessBlock:^(NSDictionary *dict) {
            [AFWEBSERVES getCanLoginWithSuccessBlock:^(NSDictionary *dict) {
                if ([dict[@"status"] isEqualToString:@"N"]) {
                    [AFTools alertWithTitle:@"提示" message:@"请重新登录" andDelegate:self];
                }
            } andFailBlock:^{
            }];
        }];
    }
    NSLog(@"username=%@",_username);
    NSLog(@"uid=%@",_uid);
    NSLog(@"email=%@",_email);
    [pool release];
    //}
}
-(void)getDetailMessageFromNetWithSuccessBlock:(getBackDictionaryBlock)dictBlock
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    if (_isUserLogin) {
        [AFWEBSERVES getUserOnLineInformationWithSuccessBlock:^(NSDictionary *dict){
            NSLog(@"userDetailDict=%@",dict);
            self.identity_user=dict[@"identity"];
            self.identity_expire=dict[@"identity_expire"];
            self.avatar=dict[@"avatar"];
            self.balance=dict[@"balance"];
            self.moblie=dict[@"moblie"];
            dictBlock(dict);
        } andFailBlock:^{
        }];
    }
    [pool release];
}
-(void)logout
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    //清空记录
    self.uid=nil;
    self.email=nil;
    self.username=nil;
    self.isUserLogin=NO;
    
    //这些也得清
    self.identity_user=@"";
    self.identity_expire=@"";
    self.balance=@"";
    self.moblie=@"";
    
    //清空cookies
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *tempArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (NSHTTPCookie *cookie in tempArray) {
        if ([cookie.name isEqualToString:@"username"] || [cookie.name isEqualToString:@"U"] || [cookie.name isEqualToString:@"E"]) {
            [cookieJar deleteCookie:cookie];
            NSLog(@"cookieJar = %@",cookie);
        }
    }
    //向服务器发送一下消息
    [AFWEBSERVES getLogoutWithSuccessBlock:^(NSDictionary *dict) {
    } andFailBlock:^{
    }];
    
    [NNCDC postNotificationName:LOGIN_SUCCESS_NOTIFICATION object:nil];
    [pool release];
}
//设置用户绑定信息  人人=1   sina=2   QQ=4
- (void)setUserBindMessageArray:(NSArray*)array
{
    for (NSDictionary* dict in array) {
        switch ([[dict objectForKey:@"type"] intValue]) {
            case 1:
                self.renrenBindDict=dict;
                _bindFlag += 1;
                break;
            case 2:
                self.sinaBindDict=dict;
                _bindFlag += 2;
                break;
            case 4:
                self.qqBindDict=dict;
                _bindFlag += 4;
                break;
            default:
                break;
        }
    }
}
#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
        _bindFlag=0;
        [self getMessageFromCookies];
    }
    return self;
}
+ (id)sharedUser{
    static dispatch_once_t predUser;
    dispatch_once(&predUser, ^{
        _afUser=[[AFUser alloc] init];
    });
    return _afUser;
}

+(id)alloc
{
	NSAssert(_afUser == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
-(void)dealloc
{
    [super dealloc];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self logout];
}
@end
