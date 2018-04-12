//
//  FmdbTool.h
//  FmdbTestProject
//
//  Created by guangshu01 on 2018/2/10.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@class PersonInfoModel;
@interface FmdbTool : NSObject
@property (nonatomic, strong) FMDatabase *db;


+ (instancetype)shareManager;

//查找
- (PersonInfoModel *)selectInfoWithUserName:(NSString *)username;

//增加
- (void)saveInfoWithPersonalModel:(PersonInfoModel *)model;

//删除
- (void)deleteInfoWithUserName:(NSString *)username;

//改
- (void)updateInfoWithPersonModel:(PersonInfoModel *)model;
@end
