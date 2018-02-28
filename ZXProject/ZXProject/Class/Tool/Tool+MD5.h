//
//  Tool+MD5.h
//  ZXProject
//
//  Created by Me on 2018/2/12.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "Tool.h"

@interface Tool (MD5)

// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;

@end
