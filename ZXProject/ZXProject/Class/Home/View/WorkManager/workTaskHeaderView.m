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
#import "RecordPlayView.h"
#import <Masonry.h>
#import "NSString+boundSize.h"

@interface workTaskHeaderView()<WorkTaskAddImagePickViewDelegate>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapIconLeftW;


@property (nonatomic, strong) WorkTaskAddImagePickView *pickImageView;

@property (nonatomic, strong) NSArray *imageUrls;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIView *lineTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwoTop;
@property (weak, nonatomic) IBOutlet UIButton *soundBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textRightW;

@property (nonatomic, strong) RecordPlayView *playView;

@end;

@implementation workTaskHeaderView

+ (instancetype)workTaskView{
    workTaskHeaderView *view = [[NSBundle mainBundle] loadNibNamed:@"workTaskHeaderView" owner:nil options:nil].lastObject;
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.pickImageView];
    self.textView.layer.borderColor = UIColorWithFloat(239).CGColor;
    self.textView.layer.borderWidth = 1;
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text =[formatter stringFromDate:date];
    self.positionLabel.numberOfLines = 0;
}

- (void)insertVideoPlayViewWithPlayTime:(float)playTime{
    if (self.playView == nil) {
        CGRect frame = CGRectMake(0, 0, 200, 40);
        self.playView = [RecordPlayView recordPlayViewWithPlayTime:playTime andFrame:frame];
    }else{
        [self.playView removeFromSuperview];
        self.playView = nil;
        CGRect frame = CGRectMake(0, 0, 200, 40);
        self.playView = [RecordPlayView recordPlayViewWithPlayTime:playTime andFrame:frame];
    }
    [self addSubview:self.playView];
    self.playView.width = 200;
    self.playView.height = 40;
    self.playView.x = self.width - 15 - self.playView.width;
    self.playView.y = CGRectGetMaxY(self.textView.frame) + 15;
    self.lineTwoTop.constant = 70;
}

- (void)insetSoundViewWithUrl:(NSString *)url{
    if (self.playView == nil) {
        CGRect frame = CGRectMake(0, 0, 200, 40);
        self.playView = [RecordPlayView recordPlayViewWithUrl:url andFrame:frame];
    }else{
        [self.playView removeFromSuperview];
        self.playView = nil;
        CGRect frame = CGRectMake(0, 0, 200, 40);
        self.playView = [RecordPlayView recordPlayViewWithUrl:url andFrame:frame];
    }
    [self addSubview:self.playView];
    self.playView.width = 200;
    self.playView.height = 40;
    self.playView.x = self.width - 15 - self.playView.width;
    self.playView.y = CGRectGetMaxY(self.textView.frame) + 15;
    self.lineTwoTop.constant = 70;
}

- (IBAction)ClickMapAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(workTaskHeaderViewDidClickAtionWithTag:andView:)]) {
        [self.delegate workTaskHeaderViewDidClickAtionWithTag:(int)sender.tag andView:self];
    }
}

- (IBAction)ClickVideoAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(workTaskHeaderViewDidClickAtionWithTag:andView:)]) {
        [self.delegate workTaskHeaderViewDidClickAtionWithTag:(int)sender.tag andView:self];
    }
}

- (void)WorkTaskAddImagePickViewDidTapImageView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(workTaskHeaderViewDidTapImagePickView)]) {
        [self.delegate workTaskHeaderViewDidTapImagePickView];
    }
}

- (void)workTaskHeaderViewGetImage:(UIImage *)image{
    [self.pickImageView getImage:image];
}

- (NSArray *)workTaskHeaderViewGetPickImages{
    return self.pickImageView.images.mutableCopy;
}



#pragma mark - setter && getter

- (void)setModel:(WorkTaskModel *)model{
    _model = model;
    if (self.type == 1) {
        self.textView.text = model.taskcontent;
        self.imageUrls = model.photoUrls;
        self.timeLabel.text = [NSString stringWithFormat:@"%@",model.occurtime];
    }else if (self.type == 2){
        self.textView.text = model.confirmcontent;
        self.imageUrls = model.afterPhotoUrls;
        self.timeLabel.text = [NSString stringWithFormat:@"%@",model.afterTimeString];
    }
    self.textView.editable = NO;
    self.positionAdress = model.positionaddress;
}

- (void)setEventModel:(eventsMdoel *)eventModel{
    _eventModel = eventModel;
    if (self.type == 1) {
        self.textView.text = eventModel.eventdescription;
        self.imageUrls = eventModel.photoUrls;
        self.timeLabel.text = [NSString stringWithFormat:@"%@",eventModel.occourtimeString];
    }else if (self.type == 2){
        self.textView.text = eventModel.solveopinion;
        self.imageUrls = eventModel.afterPhotoUrls;
        self.timeLabel.text = [NSString stringWithFormat:@"%@",eventModel.finishtimesSting];
    }
    self.textView.editable = NO;
    self.positionAdress = eventModel.positionaddress;
}

- (void)setPositionAdress:(NSString *)positionAdress{
    _positionAdress = positionAdress;
    self.positionLabel.text = self.positionAdress;
    CGFloat width = [self.positionAdress boudSizeWithFont:self.positionLabel.font andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 88, MAXFLOAT)].width;
    if (width >= [UIScreen mainScreen].bounds.size.width - 88) {
        self.mapIconLeftW.constant = self.width - 30;
    }else{
        self.mapIconLeftW.constant = 63 + width;
    }
    
}

- (WorkTaskAddImagePickView *)pickImageView{
    if (_pickImageView == nil) {
        _pickImageView = [WorkTaskAddImagePickView workTaskAddImagePickViewWithFrame:CGRectMake(0, 0, self.width, 100)];
        _pickImageView.delegate = self;
    }
    return _pickImageView;
}

- (void)setImageUrls:(NSArray *)imageUrls{
    _imageUrls = imageUrls;
    [self.pickImageView setImagesWithUrls:imageUrls];
    self.soundBtn.hidden = YES;
    self.textRightW.constant = 15;
}


@end
