//
//  ShareOfUMi.m
//  iPhone
//
//  Created by 孙超凡 QQ:729397005 on 13-5-31.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "ShareOfUMi.h"
#import "AppDelegate.h"
@implementation ShareOfUMi
//+ (id<ISSContent>)content:(NSString *)content
//defaultContent:(NSString *)defaultContent
//image:(id<ISSCAttachment>)image
//title:(NSString *)title
//url:(NSString *)url
//description:(NSString *)description
//mediaType:(SSPublishContentMediaType)mediaType;

+(void)ShareWithContent:(NSString*)content image:(UIImage*)image title:(NSString *)title url:(NSString *)url description:(NSString *)description
{
    //定义菜单分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeQQSpace, ShareTypeRenren,ShareTypeDouBan, nil];
    id<ISSCAttachment> imageMessage=nil;
    if (image != nil) {
        imageMessage = [ShareSDK jpegImageWithImage:image quality:1.0f];
    }
    NSString* urlStr = nil;
    if (url == nil) {
        urlStr = @"http://m.umiwi.com/";
    }
    else{
        urlStr = url;
    }
    //创建分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@""
                                                image:imageMessage
                                                title:title
                                                  url:urlStr
                                          description:@"优米分享"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:[[UIApplication sharedApplication] windows][0] arrowDirect:UIPopoverArrowDirectionUp];
    
    //    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
    //                                                         allowCallback:YES
    //                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
    //                                                          viewDelegate:nil
    //                                               authManagerViewDelegate:(AppDelegate *)[UIApplication sharedApplication].delegate.viewDelegate];
    
    //    //在授权页面中添加关注官方微博
    //    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                    [ShareSDK userFieldWithType:SSUserFieldTypeName valeu:@"ShareSDK"],
    //                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
    //                                    [ShareSDK userFieldWithType:SSUserFieldTypeName valeu:@"ShareSDK"],
    //                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
    //                                    nil]];
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:nil
                                                              oneKeyShareList:shareList
                                                               qqButtonHidden:NO
                                                        wxSessionButtonHidden:NO
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:nil
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    //显示分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil//authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}
+(void)ShareiPadWithContent:(NSString*)content image:(UIImage*)image title:(NSString *)title url:(NSString *)url description:(NSString *)description andView:(UIView*)view
{
    //定义菜单分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeWeixiSession,ShareTypeWeixiTimeline,ShareTypeQQSpace, ShareTypeRenren,ShareTypeDouBan, nil];
    id<ISSCAttachment> imageMessage=nil;
    if (!image) {
        imageMessage = [ShareSDK jpegImageWithImage:image quality:1.0f];
    }
    
    //创建分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@""
                                                image:imageMessage
                                                title:title
                                                  url:@"http://m.umiwi.com/"
                                          description:@"优米分享"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:view arrowDirect:UIPopoverArrowDirectionUp];
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:nil
                                                              oneKeyShareList:shareList
                                                               qqButtonHidden:NO
                                                        wxSessionButtonHidden:NO
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:nil
                                                          friendsViewDelegate:nil
                                                        picViewerViewDelegate:nil];
    //显示分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil//authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

@end
