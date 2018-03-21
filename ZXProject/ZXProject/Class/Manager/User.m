//
//  User.m
//  ZXProject
//
//  Created by Me on 2018/3/5.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};

+ (instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (NSArray *)project_ids{
    if (_project_ids == nil) {
        if (_projectids.length != 0) {
            _project_ids = [_projectids componentsSeparatedByString:@"|"];
            if (_project_ids == nil) {
                _project_ids = @[_projectids];
            }
        }
    }
    return _project_ids;
}

@end
