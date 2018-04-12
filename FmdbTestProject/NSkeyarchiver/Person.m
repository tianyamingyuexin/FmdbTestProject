//
//  TestOneModel.m
//  FmdbTestProject
//
//  Created by guangshu01 on 2018/4/9.
//  Copyright © 2018年 guangshu01. All rights reserved.
//

#import "Person.h"

@implementation Person

//解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ([super init])
    {
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}



@end
