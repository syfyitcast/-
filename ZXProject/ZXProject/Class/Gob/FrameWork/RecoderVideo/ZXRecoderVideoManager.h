//
//  ZXRecoderVideoManager.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol ZXRecordVideoManagerDelegate<NSObject>

@optional

- (void)zx_RecordVideoManagerReturnVideoCount:(float)count;

@end

@interface ZXRecoderVideoManager : NSObject

@property (nonatomic, weak) id <ZXRecordVideoManagerDelegate>delegate;
@property (nonatomic, strong) NSURL *recordFileUrl;
@property (nonatomic, assign) float videoTime;

@property (nonatomic, copy) void(^playerDidFinshedBlock)();

+ (instancetype)sharedRecoderManager;

+ (void)startRecordVideo;

+ (void)stopRecordVideo;

+ (void)playVideoWithData:(NSData *)data;

+ (void)deleteFile;

+ (void)stopPlay;



@end
