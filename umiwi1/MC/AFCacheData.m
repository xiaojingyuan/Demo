//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFCacheData.h"
#import "AFTools.h"
#import "AFWebServes.h"
#import "AFSqliteServes.h"
#define AFCacheDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/AFCacheData.bin"]
static AFCacheData *_cacheData=nil;

@implementation AFCacheData

#pragma mark - 返回数据，类似于get方法的升级版本
- (NSArray*)homePageCycleArrayyWithUpdateBlock:(getCacheDataArrayBlock)block
{
    //if ((![[_homePageCycleDictionary objectForKey:@"time"] isEqualToString:[AFTools getHourTimeStamp]] && [AFTools isEnableNet]) || ([_homePageCycleDictionary objectForKey:@"array"] == nil)) {
    if (1) {
        [AFWEBSERVES getLunBoWithSuccessBlock:^(NSDictionary *dict) {
            //更新时间戳
            [_homePageCycleDictionary setValue:[AFTools getHourTimeStamp] forKey:@"time"];
            //更新缓存
            [_homePageCycleDictionary setValue:[dict objectForKey:@"record"] forKey:@"array"];
            //保存
            [self storeThePlistDictionary];
            //执行
            block([dict objectForKey:@"record"]);
        } andFailBlock:^{
            //如果失败了，就悄悄的不说一句话。
        }];
    }
    return [_homePageCycleDictionary objectForKey:@"array"];
}

- (NSArray*)homePageShowArrayWithUpdateBlock:(getCacheDataArrayBlock)block
{
    if (isPad) {
        for (int i=0; i<7; i++) {
            NSMutableDictionary* tempDict=[_homePageShowArray objectAtIndex:i];
            //if ((![[tempDict objectForKey:@"time"] isEqualToString:[AFTools getHourTimeStamp]] && [AFTools isEnableNet]) || ([tempDict objectForKey:@"array"] == nil)) {
            if (1) { //@"限时免费",@"创业商机",@"管理进阶",@"市场销售",@"职场新人",@"精品专题",@"品牌视频",
                switch (i) {
                    case 0:
                        //创业商机
                        [AFWEBSERVES  getBusinessAtPage:0 perPage:14 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 1:
                        //管理进阶
                        [AFWEBSERVES  getManagementAtPage:0 perPage:14 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 2:
                        //市场销售
                        [AFWEBSERVES  getMarketSalesAtPage:0 perPage:14 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 3:
                        //职业技能
                        [AFWEBSERVES  getSkillAtPage:0 perPage:14 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 4:
                        [AFWEBSERVES getNewWorkerAtPage:0 perPage:14 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 5:
                        //热门专题
                        [AFWEBSERVES getZhuanTiAtPage:1 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 6:
                        //品牌视频
                        [AFWEBSERVES getHotFreeWithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }]; 
                        break;
                    default:
                        break;
                }
            }
        }
    }
    else{ //最近更新 创业商机 管理进阶 市场销售 职业技能 职场新人 热门专题 品牌视频
        for (int i=0; i<8; i++) {
            NSMutableDictionary* tempDict=[_homePageShowArray objectAtIndex:i];
            //if ((![[tempDict objectForKey:@"time"] isEqualToString:[AFTools getHourTimeStamp]] && [AFTools isEnableNet]) || ([tempDict objectForKey:@"array"] == nil)) {
            if (1) {
                switch (i) {
                    case 0://最近更新
                        [AFWEBSERVES getLatestAtPage:1 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        [AFWEBSERVES getRecommendWithSuccessBlock:^(NSDictionary *dict) {
                            
                        } andFailBlock:^{
                        }];
                        break;
                    case 1:
                        //创业商机
                        [AFWEBSERVES  getBusinessAtPage:0 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 2:
                        //管理进阶
                        [AFWEBSERVES  getManagementAtPage:0 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 3:
                        //市场销售
                        [AFWEBSERVES  getMarketSalesAtPage:0 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 4:
                        //职业技能
                        [AFWEBSERVES  getSkillAtPage:0 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 5:
                        [AFWEBSERVES getNewWorkerAtPage:0 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 6:
                        //热门专题
                        [AFWEBSERVES getZhuanTiAtPage:1 perPage:4 WithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }];
                        break;
                    case 7:
                        //最后的品牌免费
                        [AFWEBSERVES getHotFreeWithSuccessBlock:^(NSDictionary *dict) {
                            dispatch_group_async(_arrayGroup, _arrayQueue, ^{
                                //更新时间戳
                                [tempDict setValue:[AFTools getHourTimeStamp] forKey:@"time"];
                                //更新缓存
                                [tempDict setValue:[dict objectForKey:@"record"] forKey:@"array"];
                            });
                        } andFailBlock:^{
                        }]; 
                        break;
                    default:
                        break;
                }
            }
        }
    }
    //20130506 弄个风骚一点的过来。。。爽一下。。。
    dispatch_group_notify(_arrayGroup, _arrayQueue, ^{
        //保存
        [self storeThePlistDictionary];
        //执行
        block(_homePageShowArray);
    });
    return _homePageShowArray;
}
- (NSArray*)homePageMemberArrayWithUpdateBlock:(getCacheDataArrayBlock)block
{
    [AFWEBSERVES getMemberIndexWithSuccessBlock:^(NSDictionary *dict) {
        [_memberShowArray[0] setObject:dict[@"exp"] forKey:@"array"];
        [_memberShowArray[1] setObject:dict[@"gold"] forKey:@"array"];
        [_memberShowArray[2] setObject:dict[@"diamond"] forKey:@"array"];
    } andFailBlock:^{
    }];
    return _memberShowArray;
}
#pragma mark - 其他
- (NSArray*)classTypeList
{
    if (![[_typeListDictionary objectForKey:@"time"] isEqualToString:[AFTools getDayTimeStamp]] && [AFTools isEnableNet]) {
        [AFWEBSERVES getTypeListWithSuccessBlock:^(NSDictionary *dict) {
            NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
            //更新时间戳
            [_typeListDictionary setValue:[AFTools getDayTimeStamp] forKey:@"time"];
            //更新缓存
            NSMutableArray* tempArray=[[NSMutableArray alloc] init];
            NSArray* array=dict[@"record"];
            for (NSDictionary* dict1  in array) {
                [tempArray addObject:[[dict1[@"type"] copy] autorelease]];
            }
            NSLog(@"_typeListDictionary=%@",tempArray);
            [_typeListDictionary setValue:tempArray forKey:@"array"];
            [tempArray release];
            //保存
            [self storeThePlistDictionary];
            [pool release];
        } andFailBlock:^{
            //如果失败了，就悄悄的不说一句话。
        }];
    }
    return [[[_typeListDictionary objectForKey:@"array"] copy] autorelease];
}
- (NSArray*)searchKeyList
{
    if (![[_searchKeyDictionary objectForKey:@"time"] isEqualToString:[AFTools getDayTimeStamp]] && [AFTools isEnableNet]) {
        [AFWEBSERVES getSearchKeyWithSuccessBlock:^(NSDictionary *dict) {
            NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
            //更新时间戳
            [_searchKeyDictionary setValue:[AFTools getDayTimeStamp] forKey:@"time"];
            //更新缓存
            NSArray* tempArray=[[dict[@"data"] subarrayWithRange:NSMakeRange(0, 8)] copy];
            NSLog(@"_searchKeyDictionary=%@",tempArray);
            [_searchKeyDictionary setValue:tempArray forKey:@"array"];
            [tempArray release];
            //保存
            [self storeThePlistDictionary];
            [pool release];
            
        } andFailBlock:^{
            //如果失败了，就悄悄的不说一句话。
        }];
    }
    return [[[_searchKeyDictionary objectForKey:@"array"] copy] autorelease];
}
- (NSDictionary*)tutorNameList
{
    return _tutorDictionary[@"record"];
}
- (NSDictionary*)luckyMenuList;
{
    if (![[_luckyMenuDictionary objectForKey:@"time"] isEqualToString:[AFTools getDayTimeStamp]] && [AFTools isEnableNet]) {
        [AFWEBSERVES getLuckyMenuWithSuccessBlock:^(NSDictionary *dict) {
            NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
            //更新时间戳
            [_luckyMenuDictionary setValue:[AFTools getDayTimeStamp] forKey:@"time"];
            //更新缓存
            [_luckyMenuDictionary setValue:dict forKey:@"array"];
            //保存
            [self storeThePlistDictionary];
            [pool release];
        } andFailBlock:^{
            //如果失败了，就悄悄的不说一句话。
        }];
    }
    return [[[_luckyMenuDictionary objectForKey:@"array"] copy] autorelease];
}
-(void)getHomeShowWithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    if (![[_homeShowDictionary objectForKey:@"time"] isEqualToString:[AFTools getDayTimeStamp]] && [AFTools isEnableNet]) {
        [AFWEBSERVES getHomeShowWithSuccessBlock:^(NSDictionary *dict) {
            //更新时间戳
            [_homeShowDictionary setValue:[AFTools getDayTimeStamp] forKey:@"time"];
            //更新缓存
            [_homeShowDictionary setValue:dict forKey:@"array"];
            //执行
            dictBlock(dict);
        } andFailBlock:^{
            //如果失败了，就悄悄的不说一句话。
        }];
    }
    else{
        dictBlock(_homeShowDictionary[@"array"]);
    }
}
#pragma mark - 详情缓存

-(void)getDetailVideoWithString:(NSString*)detailUrlString WithSuccessBlock:(getBackDictionaryBlock)dictBlock andFailBlock:(getFailBlock)failBlock
{
    NSDictionary* dict=[AFSQLITESERVES getTheDetailWithURLString:detailUrlString anduid:(([AFUSER uid]!=nil)?([AFUSER uid]):(@"0")) timestamp:[AFTools getHourTimeStamp] isNet:[AFTools isEnableNet]];
    if (dict) {
        dictBlock(dict);
        return;
    }
    //没有的话，网络请求
    [AFWEBSERVES getDetailVideoWithString:detailUrlString WithSuccessBlock:^(NSDictionary *dict) {
        if (dictBlock) {
            dictBlock(dict);
        }
        //缓存起来
        [AFSQLITESERVES putTheDetailWithDict:dict URLString:detailUrlString anduid:(([AFUSER uid]!=nil)?([AFUSER uid]):(@"0")) timestamp:[AFTools getDayTimeStamp]];
    } andFailBlock:^{
        if (failBlock) {
            failBlock();
        }
    }];
}
-(void)deleteTheDetailWithURLString:(NSString*)urlString
{
    [AFSQLITESERVES deleteTheDetailWithURLString:urlString];
}
#pragma mark - 语录
-(NSDictionary*)getAYulu
{
    NSDictionary* tempDictionary = [[AFSQLITESERVES getRandomYulu] copy];
    int _startNum = [[NDSUD valueForKey:APP_CURRENT_VERSION] intValue];
    if (_startNum <= 50) {
        [AFWEBSERVES getYuluWithSuccessBlock:^(NSDictionary *dict) {
            [AFSQLITESERVES putNetYuluToLocal:dict[@"data"]];
            //NSLog(@"YULU=%@",dict);
        } andFailBlock:^{
        }];
    }
    return [tempDictionary autorelease];
}
#pragma mark - 应用推荐
-(void)getGoodApplicationCacheWithSuccessBlock:(getCacheDataArrayBlock)block andFailBlock:(getFailBlock)failBlock
{
    if (![[_goodAppDictioary objectForKey:@"time"] isEqualToString:[AFTools getDayTimeStamp]] && [AFTools isEnableNet]) {
        [AFWEBSERVES getGoodApplicationWithSuccessBlock:^(NSDictionary *dict) {
            NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
            //更新时间戳
            [_goodAppDictioary setValue:[AFTools getDayTimeStamp] forKey:@"time"];
            //更新缓存
            NSArray* tempArray=dict[@"data"];
            NSLog(@"_goodAppDictioary=%@",tempArray);
            [_goodAppDictioary setValue:tempArray forKey:@"array"];
            //保存
            [self storeThePlistDictionary];
            block(_goodAppDictioary[@"array"]);
            [pool release];
        } andFailBlock:^{
            //如果失败了，就悄悄的不说一句话。
        }];
    }
    else{
        block(_goodAppDictioary[@"array"]);
    }
}
#pragma mark -
-(void)storeThePlistDictionary
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_allDictionary writeToFile:AFCacheDataPath atomically:YES];
        //[NSKeyedArchiver archiveRootObject:_allDictionary toFile:AFCacheDataPath];
    });
}
#pragma mark - common
-(void)dealloc
{
    [super dealloc];
}
- (id)init{
    self=[super init];
    if (self) {
        //建造一个队列
        _arrayQueue=dispatch_queue_create("AF",NULL);
        _arrayGroup=dispatch_group_create();
        _tutorDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tutor" ofType:@"plist"]];
        _homeShowDictionary = [[NSMutableDictionary alloc] init];
        
        NSLog(@"AFCacheDataPath=%@",AFCacheDataPath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:AFCacheDataPath]) {
            _allDictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:AFCacheDataPath];
            //_allDictionary=[[NSKeyedUnarchiver unarchiveObjectWithFile:AFCacheDataPath] retain];
            _homePageCycleDictionary=[[_allDictionary objectForKey:@"homePageCycleDictionary"] retain];
            _homePageShowArray=[[_allDictionary objectForKey:@"homePageShowArray"] retain];
            _typeListDictionary=[[_allDictionary objectForKey:@"typeListDictionary"] retain];
            _searchKeyDictionary=[[_allDictionary objectForKey:@"searchKeyDictionary"] retain];
            _goodAppDictioary = [[_allDictionary objectForKey:@"goodAppDictioary"] retain];
            _memberShowArray = [[_allDictionary objectForKey:@"memberShowArray"] retain];
            if (_allDictionary[@"luckyMenuDictionary"] == nil) {
                _luckyMenuDictionary = [[NSMutableDictionary alloc] init];
                [self initLuckyMenu];
            }
            else{
                _luckyMenuDictionary = _allDictionary[@"luckyMenuDictionary"];
            }
            //NSLog(@"_allDictionary type = %@\n%@\n%@",[_allDictionary class],[_homePageCycleDictionary class],[_homePageShowArray class]);
            
        }
        else{//第一次安装，新建
            _allDictionary=[[NSMutableDictionary alloc] init];
            _homePageCycleDictionary=[[NSMutableDictionary alloc] init];
            _homePageShowArray=[[NSMutableArray alloc] init];
            _typeListDictionary=[[NSMutableDictionary alloc] init];
            _searchKeyDictionary=[[NSMutableDictionary alloc] init];
            _goodAppDictioary=[[NSMutableDictionary alloc] init];
            _tutorDictionary = [[NSMutableDictionary alloc] init];
            _memberShowArray = [[NSMutableArray alloc] init];
            _luckyMenuDictionary = [[NSMutableDictionary alloc] init];
            
            //给首页赋值 这儿得区别一下了 iPad 和 iPhone
            int num = isPad?8:8;
            for (int i=0; i<num; i++) {
                NSMutableDictionary* tempDict=[[NSMutableDictionary alloc] init];
                [_homePageShowArray addObject:tempDict];
                [tempDict release];
            }
            //会员的初始化
            for (int i=0; i<3; i++) {
                NSMutableDictionary* tempDict=[[NSMutableDictionary alloc] init];
                [_memberShowArray addObject:tempDict];
                [tempDict release];
            }
            
            //给分类设默认值
            NSArray* array =[NSArray arrayWithObjects:@"创业课程",@"管理课程",@"营销课程",@"职场课程",@"工具课程",@"生活课程",nil];
            [_typeListDictionary setValue:array forKey:@"array"];
            //给搜索Key设置默认值
            NSArray* keyArray=[NSArray arrayWithObjects:@"周鸿祎",@"董明珠",@"微博营销",@"创业百问",@"王利芬",@"俞敏洪",@"职场",@"马云", nil];
            [_searchKeyDictionary setValue:keyArray forKey:@"array"];
            [self initLuckyMenu];
            //默认的导师名字
            //NSDictionary* tutorDict = @{@"B"}
            
            
            [_allDictionary setValue:_homePageCycleDictionary forKey:@"homePageCycleDictionary"];
            [_allDictionary setValue:_homePageShowArray forKey:@"homePageShowArray"];
            [_allDictionary setValue:_typeListDictionary forKey:@"typeListDictionary"];
            [_allDictionary setValue:_searchKeyDictionary forKey:@"searchKeyDictionary"];
            [_allDictionary setValue:_goodAppDictioary forKey:@"goodAppDictioary"];
            [_allDictionary setValue:_memberShowArray forKey:@"memberShowArray"];
            [_allDictionary setValue:_luckyMenuDictionary forKey:@"luckyMenuDictionary"];
            
            [self storeThePlistDictionary];
        }
    }
    return self;
    
}
-(void)initLuckyMenu
{
    [_luckyMenuDictionary setValue:[AFTools getDayTimeStamp] forKey:@"time"];
    NSDictionary* tempDict = @{
                               @"1":@{@"action": @"lottery",@"name": @"摇一摇",@"url": @""},
                               @"20":@{@"action": @"url",@"name": @"签到",@"url": @"http://v.umiwi.com/mobile/signin"},
                               @"22":@{@"action": @"url",@"name": @"续费",@"url": @"http://v.umiwi.com/ipad/vipstart/?id=22"},
                               @"23":@{@"action": @"url",@"name": @"续费",@"url": @"http://v.umiwi.com/ipad/vipstart/?id=23"},
                               };
    [_luckyMenuDictionary setValue:tempDict forKey:@"array"];
}

+ (id)sharedCacheData{
    static dispatch_once_t predCacheData;
    dispatch_once(&predCacheData, ^{
        _cacheData=[[AFCacheData alloc] init];
    });
    return _cacheData;
}
+(id)alloc
{
	NSAssert(_cacheData == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
#pragma mark - 

@end
