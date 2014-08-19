//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFWebServes.h"
#import <AFNetworking/AFNetworking.h>
#import "AFWebServesDefineHeader.h"

static AFWebServes *_afWebServes=nil;
@implementation AFWebServes
-(void)doHttpWithUrlString:(NSString*)urlString andOperateType:(AFWebServesType)operateType  WithSuccessBlock:(getBackBlock)doBlock andFailBlock:(getFailBlock)failBlock
{
    //有网的下载一个
    NSURLRequestCachePolicy  cachePolicy;
    if ([AFTools isEnableNet]) {
        cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    else{
        cachePolicy = NSURLRequestReturnCacheDataDontLoad;
    }
    
    NSURLRequest *request ;
    if (operateType == AFWebServesGetUserinfo || operateType == AFWebServesDetail ||operateType == AFWebServesYulu || operateType == AFWebServesLogin || operateType == AFWebServesStore || operateType == AFWebServesCommitInfo) {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30 ];
    }
    else{
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:cachePolicy timeoutInterval:30 ];
    }
    NSLog(@"request = %d,%@",[request cachePolicy],request);
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        switch (operateType) {
            case AFWebServesLunBo:
            case AFWebServesRecommend:
            case AFWebServesCybw:
            case AFWebServesHotsell:
            case AFWebServesHotFree:
            case AFWebServesMember:
                
            case AFWebServesAllCourse:
            case AFWebServesExp:
            case AFWebServesSilver:
            case AFWebServesGold:
            case AFWebServesDiamond:
            case AFWebServesHotFreeList:
            case AFWebServesTypeList:
                
            case AFWebServesSearchKey:
            case AFWebServesSearchResult:
            case AFWebServesSuggest:
                
            case AFWebServesLogin:
            case AFWebServesRegister:
            case AFWebServesBindCheck:
            case AFWebServesGetUserinfo:
            case AFWebServesCanLogin:
            case AFWebServesCanLogout:
            
            case AFWebServesStartUp:
            case AFWebServesYulu:
            case AFWebServesDetail:
            case AFWebServesRelative:
            case AFWebServesMusic:
                
            case AFWebServesOrder:
            case AFWebServesCourse:
            case AFWebServesStore:
            case AFWebServesRecord:
            case AFWebServesStoreCommit:
            case AFWebServesStoreDelete:
            case AFWebServesRecordDelete:
            case AFWebServesHuoDong:
                
            case AFWebServesGoodApp:
            case AFWebServesNewOrder:
            case AFWebServesCoupon:
                
            case AFWebServesLoginCourse:
            case AFWebServesNewWorker:
            case AFWebServesManagement:
            case AFWebServesMarketSales:
            case AFWebServesBusiness:
            case AFWebServesSkill:
            case AFWebServesCollege:
                
            case AFWebServesRank:
            case AFWebServesActivity:
            case AFWebServesTutor:
                
            case AFWebServesCommitInfo:
            case AFWebServesLatest:
            case AFWebServesZhuanTi:
            case AFWebServesTimeLimitFree:
                
            case AFWebServesLuckyMenu:
            case AFWebServesLotteryList:
            case AFWebServesLotteryResult:
            case AFWebServesHomeShow:
                doBlock([[JSON retain] autorelease]);
                break;
            
            default:
                break;
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error=%@，type = %d",error,operateType);
        failBlock();
    }];
    [operation start];
}
#pragma mark - 首页的视频请求
-(void)getLunBoWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://i.v.umiwi.com/ClientApi/list?type=lunbo&version=2";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLunBo WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getRecommendWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://api.v.umiwi.com/ClientApi/list?type=recommend";
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesRecommend WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getCybwlistAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?type=cybw&p=%d&pagenum=%d",page,perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCybw WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getHotsellWithSuccessBlock:(getBackDictionaryBlock)arrayBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://api.v.umiwi.com/ClientApi/list?type=hotplay";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesHotsell WithSuccessBlock:^(id anything) {
        arrayBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getHotFreeWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/ClientApi/list?type=umipinpai";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesHotFree WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getMemberIndexWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/clientApi/memberindex";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesMember WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 分类
-(void)getAllCourseListAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)orderType andVIPType:(AFVIPType)VIPType andClassName:(NSString*)classname andTutor:(NSString*)tutor WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSMutableString* urlString=[NSMutableString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?p=%d&pagenum=%d",page,perPage];
    
    if (classname != nil && ![classname isEqualToString:@""]) {
        [urlString appendFormat:@"&type=classname&value=%@",classname];
    }
    else if(tutor != nil && ![tutor isEqualToString:@""]){
        [urlString appendFormat:@"&type=tutor&value=%@",tutor];
    }
    else{
        switch (VIPType) {
            case AFVIPTypeFree:
                [urlString appendFormat:@"&type=pinpailist"];
                break;
            case AFVIPTypeExp:
                [urlString appendFormat:@"&type=exp"];
                break;
            case AFVIPTypeSilver:
                [urlString appendFormat:@"&type=silver"];
                break;
            case AFVIPTypeGold:
                [urlString appendFormat:@"&type=gold"];
                break;
            case AFVIPTypeDiamond:
                [urlString appendFormat:@"&type=diamond"];
                break;
            default:
                break;
        }
    }
    
    if (orderType == AFOrderTypeHot) {
        [urlString appendFormat:@"&orderby=watchnum"];
    }
    else{
        [urlString appendFormat:@"&orderby=ctime"];
    }
    
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesAllCourse WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getExpAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* orderByString;
    if (type == AFOrderTypeHot) {
        orderByString = @"watchnum";
    }
    else{
        orderByString = @"ctime";
    }
    NSString* cgString = @"";
    if (categoryString != nil) {
        cgString = [NSString stringWithFormat:@"&category=%@",categoryString];
    }
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?type=exp&p=%d&pagenum=%d&orderby=%@%@",page,perPage,orderByString,cgString];
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesExp WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getSilverAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* orderByString;
    if (type == AFOrderTypeHot) {
        orderByString = @"watchnum";
    }
    else{
        orderByString = @"ctime";
    }
    NSString* cgString = @"";
    if (categoryString != nil) {
        cgString = [NSString stringWithFormat:@"&category=%@",categoryString];
    }
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?type=silver&p=%d&pagenum=%d&orderby=%@%@",page,perPage,orderByString,cgString];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesSilver WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getGoldAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* orderByString;
    if (type == AFOrderTypeHot) {
        orderByString = @"watchnum";
    }
    else{
        orderByString = @"ctime";
    }
    NSString* cgString = @"";
    if (categoryString != nil) {
        cgString = [NSString stringWithFormat:@"&category=%@",categoryString];
    }
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?type=gold&p=%d&pagenum=%d&orderby=%@%@",page,perPage,orderByString,cgString];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesGold WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getDiamondAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* orderByString;
    if (type == AFOrderTypeHot) {
        orderByString = @"watchnum";
    }
    else{
        orderByString = @"ctime";
    }
    NSString* cgString = @"";
    if (categoryString != nil) {
        cgString = [NSString stringWithFormat:@"&category=%@",categoryString];
    }
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?type=diamond&p=%d&pagenum=%d&orderby=%@%@",page,perPage,orderByString,cgString];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesDiamond WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
//优米品牌视频  免费的
-(void)getHotFreeListAtPage:(int)page perPage:(int)perPage orderBy:(AFOrderType)type category:(NSString*)categoryString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* orderByString;
    if (type == AFOrderTypeHot) {
        orderByString = @"pv";
    }
    else{
        orderByString = @"published";
    }
    NSString* cgString = @"";
    if (categoryString != nil) {
        cgString = [NSString stringWithFormat:@"&category=%@",categoryString];
    }
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/list?type=pinpailist&p=%d&pagenum=%d&orderby=%@%@",page,perPage,orderByString,cgString];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesHotFreeList WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getTypeListWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://i.v.umiwi.com/ClientApi/typelist";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesTypeList WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 搜索
-(void)getSearchKeyWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://app.umiwi.com/api/video/hotwords.php?k=1ef34aed524ef5c6f856bcb12492fd42";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesSearchKey WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getSearchResultWithKey:(NSString*)key WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/search?q=%@",key];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesSearchResult WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getSuggestWithKey:(NSString*)key WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/suggest?q=%@",key];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesSuggest WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 登录相关
-(void)doLoginWithUsername:(NSString*)nameString password:(NSString*)password WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"%@&username=%@&password=%@",URL_LOGIN,nameString,[password md5String]];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLogin WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getgetOnLineUserBindWithSuccessBlock:(getBackArrayBlock)arrayBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=otherBindCheck;
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesBindCheck WithSuccessBlock:^(id anything) {
        arrayBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)registerUserAccountWithUsername:(NSString*)nameString password:(NSString*)password email:(NSString*)emailString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://passport.umiwi.com/register/reg/?username=%@&email=%@&password=%@",[nameString URLEncodedString],emailString,password];
    //NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesRegister WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getUserOnLineInformationWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/apimember/getUserinfo";
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesGetUserinfo WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getCanLoginWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/ClientApi/canlogin";
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCanLogin WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getLogoutWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=URL_LOGOUT;
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCanLogout WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 首页启动logo
-(void)getStartUpMessageWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=URL_STARTUP;
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesStartUp WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 名人名言
-(void)getYuluWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://app.umiwi.com/api/video/get_sayinglist.php?k=1ef34aed524ef5c6f856bcb12492fd42&num=10&orderby=rand&cate=saying";
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesYulu WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 获取详情的
-(void)getDetailVideoWithString:(NSString*)detailUrlString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=detailUrlString;
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesDetail WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getRelativeVedioAtID:(NSString*)vedioID andNum:(int)num WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://api.v.umiwi.com/ClientApi/getRelate?id=%@&n=%d",vedioID,num];
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesRelative WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getMusicWithID:(NSString*)vedioID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/getAudioByid?id=%@",vedioID];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesMusic WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 更多 订单，课程，收藏，播放记录
-(void)getOrderListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://api.v.umiwi.com/iapOrders.do?cp=%d&pagesize=%d&g=%@",page,perPage,[AFTools getSecondTimeStamp]];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesOrder WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getCourseListAtPage:(int)page perPage:(int)perPage andClassName:(NSString*)classname andTutor:(NSString*)tutor WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSMutableString* urlString=[NSMutableString stringWithFormat:@"http://v.umiwi.com/ClientApi/mycourse?p=%d&pagenum=%d",page,perPage];
    if (classname != nil && ![classname isEqualToString:@""]) {
        [urlString appendFormat:@"&classname=%@",classname];
    }
    else if(tutor != nil && ![tutor isEqualToString:@""]){
        [urlString appendFormat:@"&tutor=%@",tutor];
    }
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCourse WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getStoreListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/myfavlist?p=%d&pagenum=%d",page,perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesStore WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getRecordListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/mywatchlog?p=%d&pagenum=%d",page,perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesRecord WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)commitStoreVideoId:(NSString*)stringID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/putfav?id=%@",stringID];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesStoreCommit WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)deleteStoreVideoId:(NSString*)stringID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/favalbum/remove?id=%@",stringID];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesStoreDelete WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)deleteRecordVideoId:(NSString*)stringID WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/member/delwatchlog/?vid=%@",stringID];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesRecordDelete WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getHuoDongWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/ClientApi/gethuodong";
    //NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesHuoDong WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 应用推荐
-(void)getGoodApplicationWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=URL_GOODAPP;
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesGoodApp WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 我的订单（新型）  &&  优惠劵
-(void)getNewOrderListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/myorders?p=%d&pagenum=%d",page,perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesNewOrder WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getCouponListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/mycoupon/?p=%d&pagenum=%d",page,perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCoupon WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - iPad >> 首页新加的视频请求
-(void)getLoginCourseWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/ClientApi/logincourse";
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLoginCourse WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
//职场新人 NewWorker
-(void)getNewWorkerAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/recommendlist/?n=%d&s=职场新人&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesNewWorker WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
//管理进阶 Management
-(void)getManagementAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/recommendlist/?n=%d&s=管理进阶&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesManagement WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
//市场销售 MarketSales
-(void)getMarketSalesAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/recommendlist/?n=%d&s=市场销售&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesMarketSales WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
//创业商机 Business
-(void)getBusinessAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/recommendlist/?n=%d&s=创业商机&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesBusiness WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getSkillAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/recommendlist/?n=%d&s=职业技能&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesSkill WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getCollegeAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/ClientApi/recommendlist/?n=%d&s=大学生&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCollege WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - iPad >> 排行榜
-(void)getRankWithType:(AFRankType)rankType WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/getToptoClient?type=%@",@[@"day",@"pay",@"free",@"best"][rankType]];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesRank WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - iPad >> 线下活动列表
-(void)getActivityListAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/huodonglist/?p=%d&pagenum=%d",page,perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesActivity WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - iPad >> 获取导师名字
-(void)getTutorWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=@"http://v.umiwi.com/clientApi/getTutor";
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesTutor WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 每次提交信息
-(void)getCommitInfoWithApp:(NSString*)app deviceid:(NSString*)deviceid channel:(NSString*)channel model:(NSString*)model version:(NSString*)version WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://i.v.umiwi.com/appver/register?app=%@&deviceid=%@&channel=%@&model=%@&version=%@",app,deviceid,channel,model,version];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesCommitInfo WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 获取最近的更新
-(void)getLatestAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/clientApi/getLatest?pagenum=%d",perPage];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLatest WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 专题获取
-(void)getZhuanTiAtPage:(int)page perPage:(int)perPage WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/clientApi/getZhuanti2List?pagenum=%d&p=%d",perPage,page];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesZhuanTi WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - 今日限免课程
-(void)getTimeLimitFreeWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/clientApi/getTodayLimitedFree"];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesTimeLimitFree WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}

#pragma mark - 中奖配置
-(void)getLuckyMenuWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://api.v.umiwi.com/clientApi/luckymenu"];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLuckyMenu WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getLotteryListWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/lottery/list"];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLotteryList WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getLotteryResultWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/lottery/draw"];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesLotteryResult WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)getHomeShowWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSString* urlString=[NSString stringWithFormat:@"http://v.umiwi.com/ClientApi/shoupinghjzs"];
    NSLog(@"urlString=%@",urlString);
    [self doHttpWithUrlString:urlString andOperateType:AFWebServesHomeShow WithSuccessBlock:^(id anything) {
        dictBlock(anything);
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
    }
    return self;
    
}
+ (id)sharedWebServes{
    static dispatch_once_t predWebServes;
    dispatch_once(&predWebServes, ^{
        _afWebServes=[[AFWebServes alloc] init];
    });
    return _afWebServes;
}
+(id)alloc
{
	NSAssert(_afWebServes == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
@end
