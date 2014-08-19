//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFGlobalData.h"
#define AFGlobalDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/AFGlobalData.plist"]
static AFGlobalData *_globalData=nil;
@implementation AFGlobalData
-(void)addText:(NSString*)t
{
    _logoTextView.text = [NSString stringWithFormat:@"%@%@",_logoTextView.text,t];
}
//存储用户的配置
-(void)storeThePlistDictionary
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_allDictionary writeToFile:AFGlobalDataPath atomically:YES];
        //[NSKeyedArchiver archiveRootObject:_allDictionary toFile:AFCacheDataPath];
    });
}
-(void)addSearchRecord:(NSString*)record
{
    for (NSString* str in _searchRecordArray) {
        if ([str isEqualToString:record]) {
            return;
        }
    }
    [_searchRecordArray addObject:record];
    [self storeThePlistDictionary];
}
-(void)clearSearchRecord
{
    [_searchRecordArray removeAllObjects];
    [self storeThePlistDictionary];
}
-(void)addPlayRecord:(NSDictionary*)dict withendTime:(float)endTime
{
    NSMutableDictionary* tempDict;
    for (int i=0;i<_playRecordArray.count;i++) {
        NSDictionary* d = _playRecordArray[i];
        if ([d[@"url"] isEqualToString:dict[@"url"]]) {
            tempDict = [NSMutableDictionary dictionaryWithDictionary:[[d copy] autorelease]];
            [tempDict setValue:[NSString stringWithFormat:@"%f",endTime] forKey:@"time"];
            [_playRecordArray replaceObjectAtIndex:i withObject:tempDict];
            return ;
        }
    }
    tempDict=[[NSMutableDictionary alloc] init];
    [tempDict setValue:dict[@"title"] forKey:@"title"];
    [tempDict setValue:[NSString stringWithFormat:@"%f",endTime] forKey:@"time"];
    [tempDict setValue:dict[@"url"] forKey:@"url"];
    [_playRecordArray insertObject:tempDict atIndex:0];
    //NSLog(@"_playRecordArray.count=%d",_playRecordArray.count);
    [tempDict release];
}
-(float)getTimeFromRecord:(NSString*)url
{
    for (NSDictionary* dict in _playRecordArray) {
        if ([dict[@"url"] isEqualToString:url]) {
            return MAX([dict[@"time"] floatValue]-3, 0);
        }
    }
    return 0;
}
-(void)setEnableDownAt3G:(BOOL)enableDownAt3G
{
    _enableDownAt3G = enableDownAt3G;
    [_allDictionary setValue:[NSString stringWithFormat:@"%d",_enableDownAt3G] forKey:@"enableDownAt3G"];
    [self storeThePlistDictionary];
}
#pragma mark - common
-(void)dealloc
{
    [super dealloc];
}
- (id)init{
    self=[super init];
    if (self) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:AFGlobalDataPath]) {
            _allDictionary=[[NSMutableDictionary alloc] initWithContentsOfFile:AFGlobalDataPath];
            _searchRecordArray = [[_allDictionary objectForKey:@"searchRecordArray"] retain];
            _playRecordArray = [[_allDictionary objectForKey:@"playRecordArray"] retain];
            _enableDownAt3G = [[_allDictionary objectForKey:@"enableDownAt3G"] boolValue];
        }
        else{
            _allDictionary=[[NSMutableDictionary alloc] init];
            _searchRecordArray = [[NSMutableArray alloc] init];
            _playRecordArray = [[NSMutableArray alloc] init];
            _enableDownAt3G = NO;
            
            [_allDictionary setValue:_searchRecordArray forKey:@"searchRecordArray"];
            [_allDictionary setValue:_playRecordArray forKey:@"playRecordArray"];
            [_allDictionary setValue:[NSString stringWithFormat:@"%d",_enableDownAt3G] forKey:@"enableDownAt3G"];
            
            [self storeThePlistDictionary];
        }
    }
    return self;
    
}
+ (id)sharedGlobalData{
    static dispatch_once_t predGlobalData;
    dispatch_once(&predGlobalData, ^{
        _globalData=[[AFGlobalData alloc] init];
    });
    return _globalData;
}
+(id)alloc
{
	NSAssert(_globalData == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
#pragma mark - 

@end
