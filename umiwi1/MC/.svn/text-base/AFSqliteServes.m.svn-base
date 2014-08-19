//
//  MC.h
//  MC
//
//  Created by 孙超凡 on 13-2-24.
//  Copyright (c) 2013年 优米网. All rights reserved.
//

#import "AFSqliteServes.h"
static AFSqliteServes *_afSqliteServes=nil;
@implementation AFSqliteServes

-(void)createTheDatabase
{
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"umiwi.sqlite"];
    _AFDatabaseQueue =[[FMDatabaseQueue alloc] initWithPath:path];
    
    NSArray* sqlCreateArray=[NSArray arrayWithObjects:
                             //表---语录
                             @"create table if not exists yulu(yuluid integer,author TEXT,title TEXT);",
                             //表---详情
                             @"CREATE TABLE if not exists detail (mark TEXT ,bin BLOB,uid TEXT,timestamp TEXT);",
                             
                             //索引---语录
                             @"CREATE UNIQUE INDEX IF NOT EXISTS yulu_index ON yulu(yuluid);",
                             //索引---详情
                             @"CREATE UNIQUE INDEX IF NOT EXISTS detail_index ON detail(mark);",
                             
                             //触发器---详情
                             @"CREATE TRIGGER IF NOT EXISTS detail_trigger \
                             BEFORE INSERT ON detail \
                             BEGIN \
                             DELETE FROM detail WHERE detail.timestamp != new.timestamp;\
                             END",
                             
                             //语录内部先插一个数据 默认
                             @"REPLACE into yulu(yuluid,author,title)values('-1','马云','没有人是完美的，社会不可能完美，因为社会是由一个个不完美的人组成的，你的职责就是比别人多勤奋一点、多努力一点、多有一点理想。');",
                             nil];
    for (NSString* str in sqlCreateArray) {
        [_AFDatabaseQueue inDatabase:^(FMDatabase *db) {
            if ([db executeUpdate:str]) {
                NSLog(@"Create OK!");
            };
        }];
    }
}
#pragma mark - 详情缓存
-(void)putTheDetailWithDict:(NSDictionary*)dict URLString:(NSString*)urlString anduid:(NSString*)uid timestamp:(NSString*)timestamp
{
    [_AFDatabaseQueue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:@"REPLACE INTO detail(bin,mark,uid,timestamp) VALUES (?,?,?,?);",[NSKeyedArchiver archivedDataWithRootObject:dict],[urlString md5String],uid,timestamp]) {
            NSLog(@"insert OK");
        }
    }];
}
-(NSDictionary*)getTheDetailWithURLString:(NSString*)urlString anduid:(NSString*)uid timestamp:(NSString*)timestamp isNet:(BOOL)isNet
{
    NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
    __block NSData* tempData = nil;
    [_AFDatabaseQueue inDatabase:^(FMDatabase *db) {
        NSString* sqlString;
        if (isNet) {
            sqlString=[NSString stringWithFormat:@"SELECT * FROM detail WHERE mark = '%@' AND uid = '%@' AND timestamp = '%@' ;",[urlString md5String],uid,timestamp];
        }
        else{
            sqlString=[NSString stringWithFormat:@"SELECT * FROM detail WHERE mark = '%@' AND uid = '%@';",[urlString md5String],uid];
        }
        NSLog(@"sqlString=%@",sqlString);
        FMResultSet *rs = [db executeQuery:sqlString];
        while ([rs next]) {
            tempData = [rs dataForColumn:@"bin"];
        }
    }];
    NSDictionary* resultDict = nil;
    //NSLog(@"tempData=%@",tempData);
    if (tempData != nil) {
        resultDict =[[NSKeyedUnarchiver unarchiveObjectWithData:tempData] copy];
    }
    [pool release];
    //NSLog(@"resultDict=%@",resultDict);
    return [resultDict autorelease];
}
-(void)deleteTheDetailWithURLString:(NSString*)urlString
{
    [_AFDatabaseQueue inDatabase:^(FMDatabase *db) {
        NSString* sqlString=[NSString stringWithFormat:@"DELETE FROM detail WHERE mark = '%@' ;",[urlString md5String]];
        NSLog(@"sqlString=%@",sqlString);
        if ([db executeUpdate:sqlString]) {
            NSLog(@"delete OK");
        }
    }];
}
#pragma mark - 语录的操作
-(NSDictionary*)getRandomYulu
{
    __block NSMutableDictionary* tempDict=[[NSMutableDictionary alloc] init];
    [_AFDatabaseQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from yulu order by RANDOM() limit 1 ;"];
        while ([rs next]) {
            [tempDict setValue:[rs stringForColumn:@"author"] forKey:@"author"];
            [tempDict setValue:[rs stringForColumn:@"title"] forKey:@"title"];
        }
    }];
    NSDictionary* resultDict=[tempDict copy];
    //NSLog(@"tempDict=%@",tempDict);
    [tempDict release];
    //NSLog(@"resultDict=%@",resultDict);
    return [resultDict autorelease];
}
-(void)putNetYuluToLocal:(NSArray*)array
{
    for (NSDictionary* dict in array) {
        [_AFDatabaseQueue inDatabase:^(FMDatabase *db) {
            NSString* sqlString=[NSString stringWithFormat:@"REPLACE INTO yulu(yuluid,author,title) VALUES ('%@','%@','%@');",[dict objectForKey:@"sayinglistid"],[dict objectForKey:@"author"],[dict objectForKey:@"title"]];
            //NSLog(@"sqlString=%@",sqlString);
            if ([db executeUpdate:sqlString]) {
                NSLog(@"replace OK");
            }
        }];
    }
}
#pragma mark - common
- (id)init{
    self=[super init];
    if (self) {
        [self createTheDatabase];
    }
    return self;
    
}
+ (id)sharedSqliteServes{
    static dispatch_once_t predSqliteOperate;
    dispatch_once(&predSqliteOperate, ^{
        _afSqliteServes=[[AFSqliteServes alloc] init];
    });
    return _afSqliteServes;
}

+(id)alloc
{
	NSAssert(_afSqliteServes == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}
-(void)dealloc
{
    [super dealloc];
    [_AFDatabaseQueue close];
    [_AFDatabaseQueue release];
}









@end
