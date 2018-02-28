//
//  HomeRightItems.h
//  ZXProject
//
//  Created by Me on 2018/2/25.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeRightItems : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

+ (NSArray *)homeRightItemsWithSource_arr:(NSArray *)source_arr;

@end
