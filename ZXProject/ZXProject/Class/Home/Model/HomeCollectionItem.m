//
//  HomeCollectionItem.m
//  ZXProject
//
//  Created by Me on 2018/2/21.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "HomeCollectionItem.h"



@implementation HomeCollectionItem

+ (instancetype)collectionItemWithController:(NSString *)controller{
    HomeCollectionItem *item = [[HomeCollectionItem alloc] init];
    item.controllerName = controller;
    return item;
}

@end
