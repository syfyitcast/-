//
//  HomeCollectionItem.h
//  ZXProject
//
//  Created by Me on 2018/2/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCollectionItem : NSObject

@property (nonatomic, copy) NSString *controllerName;

+ (instancetype)collectionItemWithController:(NSString *)controller;

@end
