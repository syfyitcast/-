//
//  DeviceCollectionView.h
//  ZXProject
//
//  Created by 刘清 on 2018/4/20.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeviceCollectionViewDelegate<NSObject>

@optional

- (void)deviceCollectionViewDidClickBtnTag:(UIButton *)btn;

@end

@interface DeviceCollectionView : UIView

@property (nonatomic, weak) id<DeviceCollectionViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *deviceCodeFiled;
@property (weak, nonatomic) IBOutlet UITextField *deviceNameFiled;
@property (weak, nonatomic) IBOutlet UITextField *RFIDfiled;

+ (instancetype)deviceCollectionView;

- (void)setPositionAdress:(NSString *)positionAdress;

- (void)setDeviceDict:(NSDictionary *)deviceDict;

- (void)getPickImage:(UIImage *)image;

- (NSArray *)getImages;

@end
