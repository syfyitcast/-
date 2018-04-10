//
//  ZXRecoderVideoManager.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface ZXRecoderVideoManager : NSObject

+ (instancetype)sharedRecoderManager;

+ (void)startRecordVideo;

+ (void)stopRecordVideo;

+ (void)playVideoWithData:(NSData *)data;



@end
