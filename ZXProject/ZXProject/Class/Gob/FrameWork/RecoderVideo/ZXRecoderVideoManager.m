//
//  ZXRecoderVideoManager.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "ZXRecoderVideoManager.h"

@interface ZXRecoderVideoManager()

@property (nonatomic, strong) AVAudioSession *session;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) float videoTime;

@end

@implementation ZXRecoderVideoManager

+ (instancetype)sharedRecoderManager{
    static ZXRecoderVideoManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZXRecoderVideoManager alloc] init];
    });
    return instance;
}

+ (void)startRecordVideo{
    ZXRecoderVideoManager *manager = [ZXRecoderVideoManager sharedRecoderManager];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Record"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    manager.session = session;
    NSString *filePath = [path stringByAppendingString:@"/RRecord.wav"];
    manager.recordFileUrl = [NSURL fileURLWithPath:filePath];
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    manager.recorder = [[AVAudioRecorder alloc] initWithURL:manager.recordFileUrl settings:recordSetting error:nil];
    if (manager.recorder) {
        manager.recorder.meteringEnabled = YES;
        [[NSRunLoop currentRunLoop] addTimer:manager.timer forMode:NSRunLoopCommonModes];
        [manager.timer fire];
        [manager.recorder  prepareToRecord];
        [manager.recorder  record];
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

+ (void)stopRecordVideo{
    ZXRecoderVideoManager *manager =  [ZXRecoderVideoManager sharedRecoderManager];
    [manager.timer invalidate];
    manager.timer = nil;
    if ([manager.recorder isRecording]) {
        [manager.recorder stop];
        AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:manager.recordFileUrl options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        manager.videoTime = audioDurationSeconds;
    }
}

+ (void)playVideoWithData:(NSData *)data{
    ZXRecoderVideoManager *manager =  [ZXRecoderVideoManager sharedRecoderManager];
    if ([manager.player isPlaying])return;
    manager.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [manager.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [manager.player play];
}

- (void)retureVideoCount{
    [self.recorder updateMeters];
    float lowPassResults = pow(10, (0.05 * [self.recorder peakPowerForChannel:0]));
    if (self.delegate && [self.delegate respondsToSelector:@selector(zx_RecordVideoManagerReturnVideoCount:)]) {
        [self.delegate zx_RecordVideoManagerReturnVideoCount:lowPassResults];
    }
}

- (NSTimer *)timer{
    if (_timer == nil) {
        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(retureVideoCount) userInfo:nil repeats:YES];
    }
    return _timer;
}

@end