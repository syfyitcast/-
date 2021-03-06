//
//  FButton.h
//  ZXProject
//
//  Created by Me on 2018/2/8.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
   FBLayoutTypeNone = 0,
   FBLayoutTypeTextFull,
   FBLayoutTypeImageFull,
   FBLayoutTypeDownUp,
   FBLayoutTypeLeftRight,
   FBLayoutTypeRightLeft,
   FBLayoutTypeRight,
   FBLayoutTypeLeft
}FBLayoutType;

typedef enum {
    FBSetTitleTypeCenter = 0,
   
}FBSetTitleType;

@interface FButton : UIButton

@property (nonatomic, assign) CGFloat ratio;

+ (instancetype)fbtn;
+ (instancetype)fbtnWithFBLayout:(FBLayoutType)type andPadding:(CGFloat)padding;

- (void)setBagdeCount:(int)count;

- (void)setTitleWithType:(FBSetTitleType)type;

@end
