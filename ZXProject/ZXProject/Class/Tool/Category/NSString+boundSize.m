//
//  NSString+boundSize.m
//  Nexpaq NewUI Project
//
//  Created by Jordan Zhou on 16/9/20.
//  Copyright © 2016年 kevin.liu. All rights reserved.
//

#import "NSString+boundSize.h"


@implementation NSString (boundSize)

- (CGSize)boundSizeWithFont:(UIFont *)font{
    
    NSDictionary *att = @{
                          NSFontAttributeName : font
                          };

  return  [self boundingRectWithSize:CGSizeMake(375, 0) options: NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;

}

- (CGSize)boudSizeWithFont:(UIFont *)font andMaxSize:(CGSize)size{

    NSDictionary *att = @{
                          NSFontAttributeName : font
                          };
    
    return [self boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
}

@end
