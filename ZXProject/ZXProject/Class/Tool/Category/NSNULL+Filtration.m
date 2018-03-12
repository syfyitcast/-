//
//  JSONKit+NSNULL.m
//  InAppPurchase-Mac
//
//  Created by Johnson on 14-7-11.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "NSNULL+Filtration.h"


@implementation NSObject (NSNULL)

- (BOOL)isNSNULL {
    return [self isKindOfClass:[NSNull class]];
}



- (id)filterNullObject {
    if ([self isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (id item in (NSArray*)self) {
            if (![item isNSNULL]) {
                if ([item respondsToSelector:@selector(filterNullObject)]) {
                    [array addObject:[item filterNullObject]];
                }else {
                    [array addObject:item];
                }
            }
        }
        return array;
    }else if ([self isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
        
        id value = nil;
        for (NSString *key in [(NSDictionary*)self allKeys]) {
            if (![key isNSNULL]) {
                value = ((NSDictionary*)self)[key];
                
                if (![value isNSNULL]) {
                    if ([value respondsToSelector:@selector(filterNullObject)]) {
                        [dicInfo setValue:[value filterNullObject]
                                   forKey:key];
                    }else {
                        [dicInfo setValue:value
                                   forKey:key];
                    }
                }
            }
        }
        return dicInfo;
    }
    
    return self;
}


@end
