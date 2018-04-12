//
//  FmdbTool.m
//  FmdbTestProject
//
//  Created by guangshu01 on 2018/2/10.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "FmdbTool.h"
#import "FMDB.h"
#import "PersonInfoModel.h"
static FmdbTool  *__help = nil;
@implementation FmdbTool
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __help = [[FmdbTool alloc] init];
        [__help createDataBase];
        [__help createTableView];
    });
    
    return __help;
}
- (void)createDataBase
{
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/conversionInfo.sqlite"];
        _db = [[FMDatabase alloc] initWithPath:path];
        [_db open];
        [_db close];
}
-(void)createTableView
{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS ConversionInfo(conversionInfo_id INTEGER PRIMARY KEY AUTOINCREMENT,userName TEXT,headImage TEXT,nickname TEXT,haveMoney INTEGER)";
    if ([self.db open])
    {
        if ([_db executeUpdate:sql])
        {
            NSLog(@"创建表成功");
        }
        else
        {
            NSLog(@"创建表失败");
        }
         [self.db close];
    }
    else
    {
        NSLog(@"打开数据库失败");
    }
   
}
- (PersonInfoModel *)selectInfoWithUserName:(NSString *)username
{
    [_db open];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ConversionInfo where userName='%@'",username];
    FMResultSet *set =  [_db executeQuery:sql];
    PersonInfoModel *model = [[PersonInfoModel alloc] init];
    while ([set next])
    {
//        int studentID = [set intForColumn:@"student_id"];
        
        NSString *name = [set stringForColumn:@"userName"];
        NSString *headImage = [set stringForColumn:@"headImage"];
        NSString *nickname = [set stringForColumn:@"nickname"];
        int haveMoney = [set intForColumn:@"haveMoney"];
       
        model.userName = name;
        model.headImage = headImage;
        model.nickname = nickname;
        model.haveMoney = haveMoney;
     

//        NSDictionary *dictionary =  [set resultDictionary];
//        NSLog(@"%d,%@,%d,%@",studentID,name,age,dictionary);
    }
    
   
    [set close];
    [_db close];
    
     return model;
}

- (void)saveInfoWithPersonalModel:(PersonInfoModel *)model
{
     [_db open];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO ConversionInfo(userName, headImage, nickname,haveMoney) VALUES('%@','%@','%@',%ld)",model.userName,model.headImage,model.nickname,(long)model.haveMoney];
//     NSString *sql = @"insert into app (_id,updated,cover,title) values (?,?,?,?)"
    BOOL result = [_db executeUpdate:sql];
//    BOOL result = [_db executeUpdate:@"%@",sql];
    if (result)
    {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败");
    }
    
    [_db close];
    
}
- (void)deleteInfoWithUserName:(NSString *)username
{
    [_db open];
   NSString *sql = [NSString stringWithFormat:@"DELETE FROM ConversionInfo where userName='%@'",username];
   BOOL result = [_db executeUpdate:sql];
    if (result)
    {
        NSLog(@"删除成功");
    }
    else
    {
        NSLog(@"删除失败");
    }
    [_db close];
}
- (void)updateInfoWithPersonModel:(PersonInfoModel *)model
{
    [_db open];
    NSString *sql = [NSString stringWithFormat:@"update ConversionInfo set headImage='%@',nickname='%@',haveMoney=%ld where userName='%@'",model.headImage,model.nickname,(long)model.haveMoney,model.userName];
    BOOL result = [_db executeUpdate:sql];
    if (result)
    {
        NSLog(@"修改成功");
    }
    else
    {
        NSLog(@"修改失败");
    }
    [_db close];
}
@end
