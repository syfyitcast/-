//
//  workTaskHeaderView.m
//  ZXProject
//
//  Created by 刘清 on 2018/4/10.
//  Copyright © 2018年 com.nexpaq. All rights reserved.
//

#import "workTaskHeaderView.h"
#import "WorkTaskAddImagePickView.h"
#import "GobHeaderFile.h"

@interface workTaskHeaderView()

@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, copy) NSString *positionAdress;

@property (nonatomic, strong) WorkTaskAddImagePickView *pickImageView;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end;

@implementation workTaskHeaderView

+ (instancetype)workTaskViewWithImageUrls:(NSArray *)imageUrls andPositionAdress:(NSString *)positionAdress{
    workTaskHeaderView *view = [[NSBundle mainBundle] loadNibNamed:@"workTaskHeaderView" owner:nil options:nil].lastObject;
    view.positionAdress = positionAdress;
    view.imageUrls = imageUrls;
    return view;
}

- (void)awakeFromNib{
    [self addSubview:self.pickImageView];
    self.textView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.textView.layer.borderWidth = 1;
    
}

- (WorkTaskAddImagePickView *)pickImageView{
    if (_pickImageView == nil) {
        _pickImageView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:CGRectMake(0, 0, self.width, 100)];
    }
    return _pickImageView;
}

@end
