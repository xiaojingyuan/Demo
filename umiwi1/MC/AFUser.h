//
//  AFUser.h
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-3-26.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFWebServesDefineHeader.h"
#define AFUSER [AFUser sharedUser]
@interface AFUser : NSObject<UIAlertViewDelegate>
{
    //用户信息区
    NSString             *_uid;
    NSString             *_username;
    NSString             *_email;
    NSString             *_token;
    NSString             *_avatar;
    //用户详情
    NSString             *_identity_user;
    NSString             *_identity_expire;
    NSString             *_balance;
    NSString             *_moblie;
    
    //人人=1   sina=2   QQ=4
    int                   _bindFlag;
    NSDictionary         *_renrenBindDict;
    NSDictionary         *_sinaBindDict;
    NSDictionary         *_qqBindDict;
    
    //用户是否登录
    BOOL                  _isUserLogin;
    
}
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *avatar;

@property (nonatomic, readwrite, retain) NSString *identity_user;
@property (nonatomic, readwrite, retain) NSString *identity_expire;
@property (nonatomic, readwrite, retain) NSString *balance;
@property (nonatomic, readwrite, retain) NSString *moblie;

@property (nonatomic, assign) int bindFlag;
@property (nonatomic, retain) NSDictionary* renrenBindDict;
@property (nonatomic, retain) NSDictionary* sinaBindDict;
@property (nonatomic, retain) NSDictionary* qqBindDict;
@property (nonatomic, assign) BOOL isUserLogin;

+ (id)sharedUser;
//登录后从cookies中获得基本信息
-(void)getMessageFromCookies;
//从网络获取详情
-(void)getDetailMessageFromNetWithSuccessBlock:(getBackDictionaryBlock)dictBlock;

//退出
-(void)logout;
//设置用户绑定信息
- (void)setUserBindMessageArray:(NSArray*)array;
@end
