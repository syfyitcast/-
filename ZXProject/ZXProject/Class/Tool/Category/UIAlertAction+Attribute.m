//
//  UIAlertAction+Attribute.m
//  ZXProject
//
//  Created by 刘清 on 2018/3/15.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "UIAlertAction+Attribute.h"

@implementation UIAlertAction (Attribute)

- (void)setTitleColor:(UIColor *)color{
    if ([self valueForKey:@"titleTextColor"]) {
        [self setValue:color forKey:@"titleTextColor"];
    }
}

@end
