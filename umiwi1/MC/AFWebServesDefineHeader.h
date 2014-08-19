//
//  AFWebServesDefineHeader.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//
#import "MCDefineHeader.h"
#ifndef MC_AFWebServesDefineHeader_h
#define MC_AFWebServesDefineHeader_h

typedef void (^getBackBlock)(id anything);
typedef void (^getBackStringBlock)(NSString* str);
typedef void (^getBackArrayBlock)(NSArray* array);
typedef void (^getBackDictionaryBlock)(NSDictionary* dict);
typedef void (^getBackNSUIntegerBlock)(NSUInteger dataLength);
typedef void (^getFailBlock)();

#pragma mark - 首页的视频请求
//获取轮播
#define URL_LUNBO @"http://api.v.umiwi.com/api3/androidlunbolist"

//获取首页推荐
#define URL_RECOMMEND @"http://api.v.umiwi.com/api3/androidrecommendlist"

//创业百问的获取接口
#define URL_CYBW @"http://i.v.umiwi.com/api3/cybwlist"

//本周热播
#define URL_HOTSELL @"http://api.v.umiwi.com/api3/hotsell"

////优米品牌视频  免费的
#define URL_HOTFREE @"http://app.umiwi.com/api/video/hotfreevideo.php"

#pragma mark - 登录
//登录
#define URL_LOGIN @"http://passport.umiwi.com/login/login/?expire=315360000&logintype=token"

//第三方登录
#define otherLoginPre  @"http://passport.umiwi.com/login/mobileoauth?to="
#define otherLoginBind @"http://passport.umiwi.com/login/mobilebind/?to="
#define otherBindCheck @"http://passport.umiwi.com/bind/getSelfBind"
#define otherBindDel   @"http://mili.umiwi.com/setting/delbind/?type="
#define otherLoginEnd  @"http://passport.umiwi.com/login/mobileclose/"

//忘记密码
#define URL_FORGET_PASSWORD @"http://passport.umiwi.com/retrieve/"
//意见反馈
#define URL_FEEDBACK_BASE   @"http://v.umiwi.com/feedback/"

#pragma mark - 远程推送通知
#define URL_APNS_STRING  (isPad)?(@"http://ipadapns.m.umiwi.com/"):(@"http://apns.m.umiwi.com/")

#pragma mark - 版本检查 评分
#define APP_ID  (isPad)?(@"491273690"):(@"464253192")
#define URL_PING_FEN [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8",APP_ID]
#define URL_APP_STORE [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%@?mt=8",APP_ID]
#define URL_APP_VERSION [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@&country=cn",APP_ID]


#pragma mark - 首页更新
#define URL_STARTUP (isPad)?(@"http://api.v.umiwi.com/clientApi/loadimg?d=ipad"):(@"http://app.umiwi.com/api/video/loadimgforiphone.php?k=1ef34aed524ef5c6f856bcb12492fd42")

#define URL_GOODAPP @"http://app.umiwi.com/api/video/get_application.php?k=1ef34aed524ef5c6f856bcb12492fd42"

#define URL_LOGOUT @"http://passport.umiwi.com/login/logout/"

#pragma mark - 登录注册

#define URL_REGISTER @"http://passport.umiwi.com/register?app=1"
#define URL_LOGIN_WEB   @"http://v.umiwi.com/mobile/login"

#endif






