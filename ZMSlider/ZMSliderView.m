//
//  ZMSliderView.m
//  ZMSliderView
//
//  Created by abc on 2019/7/5.
//  Copyright © 2019 zm. All rights reserved.
//

#import "ZMSliderView.h"

#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue,1.0)

#define FitScreenSize(size) ([self smartSizeCalculate:size])
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height



@interface ZMSliderView ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat progressValue;

@property (nonatomic, strong) UIProgressView * bottomProgress;
@property (nonatomic, strong) UISlider * topSlider;

@property (nonatomic, strong) UIImageView * percent0;
@property (nonatomic, strong) UIImageView * percent25;
@property (nonatomic, strong) UIImageView * percent50;
@property (nonatomic, strong) UIImageView * percent75;
@property (nonatomic, strong) UIImageView * percent100;

@property (nonatomic, assign) NSInteger type;//0:买、1:卖

@property (nonatomic, strong) UITapGestureRecognizer * tapGesture;

@property (nonatomic, strong) void (^valueBlock)(CGFloat index);
@property (nonatomic, assign) CGFloat sliderValue;

@end

@implementation ZMSliderView

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        [self makeContraints];
    }
    return self;
}

- (void)setSliderStatus:(NSInteger)type
{
    self.type = type;
    if (type==0) {
        [_topSlider setThumbImage:[UIImage imageNamed:@"ccircle-ic"] forState:UIControlStateNormal];
        [_topSlider setThumbImage:[UIImage imageNamed:@"ccircle-ic"] forState:UIControlStateHighlighted];
        _bottomProgress.progressTintColor = UIColorFromHex(0x00be66);
    } else {
        [_topSlider setThumbImage:[UIImage imageNamed:@"ccircle-ic"] forState:UIControlStateNormal];
        [_topSlider setThumbImage:[UIImage imageNamed:@"ccircle-ic"] forState:UIControlStateHighlighted];
        _bottomProgress.progressTintColor = UIColorFromHex(0xEA573C);
    }
    [self setSliderValue:self.topSlider.value];
}

- (void)setSliderValue:(double)value
{
    [self.topSlider setValue:value animated:YES];
    _sliderValue = value;
    [self.bottomProgress setProgress:value/100 animated:NO];
    NSString * imageStr = @"";
    if (self.type==0) {//买为绿色
        imageStr = @"order-bcircle-ic";
    } else {
        imageStr = @"aorder-bcircle-ic";
    }
    
    if (value>=100) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:imageStr]];
        [self.percent75 setImage:[UIImage imageNamed:imageStr]];
        [self.percent100 setImage:[UIImage imageNamed:imageStr]];
    } else if (value>=75) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:imageStr]];
        [self.percent75 setImage:[UIImage imageNamed:imageStr]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    } else if (value>=50) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:imageStr]];
        [self.percent75 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    } else if (value>=25) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent75 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    } else {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent50 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent75 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    }
}

- (void)sliderValueBlock:(void (^)(CGFloat))block
{
    _valueBlock = block;
}

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:_topSlider];
    CGFloat value = (_topSlider.maximumValue - _topSlider.minimumValue) * (touchPoint.x / _topSlider.frame.size.width );
    [_topSlider setValue:value animated:YES];
    [self topSliderValueChanged:_topSlider];
}

- (void)initSubviews
{
    _percent0 = ({
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(-self.frame.size.height/2, -self.frame.size.height/2, self.frame.size.height, self.frame.size.height)];
        [v setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        
        v;
    });
    _percent25 = ({
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/4-self.frame.size.height/2, -self.frame.size.height/2, self.frame.size.height, self.frame.size.height)];
        [v setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        
        v;
    });
    _percent50 = ({
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-self.frame.size.height/2, -self.frame.size.height/2, self.frame.size.height, self.frame.size.height)];
        [v setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        
        v;
    });
    _percent75 = ({
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.75-self.frame.size.height/2, -self.frame.size.height/2, self.frame.size.height, self.frame.size.height)];
        [v setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        
        v;
    });
    _percent100 = ({
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-self.frame.size.height/2, -self.frame.size.height/2, self.frame.size.height, self.frame.size.height)];
        [v setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        
        v;
    });
    _bottomProgress = ({
        UIProgressView * s = [UIProgressView new];
        s.trackTintColor = UIColorFromHex(0xc7c7c7);
        [s.layer setCornerRadius:FitScreenSize(4)];
        [s.layer setMasksToBounds:YES];
        
        s;
    });
    _topSlider = ({
        UISlider * s = [UISlider new];
        s.minimumValue = 0;
        s.maximumValue = 100;
        s.minimumTrackTintColor = [UIColor clearColor];
        s.maximumTrackTintColor = [UIColor clearColor];
        s.continuous = YES;
        [s addTarget:self action:@selector(topSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [s addTarget:self action:@selector(topSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
        [s addTarget:self action:@selector(topSliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [s addTarget:self action:@selector(topSliderTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        
        s;
    });
    [self addSubview:self.bottomProgress];
    [self addSubview:self.percent0];
    [self addSubview:self.percent25];
    [self addSubview:self.percent50];
    [self addSubview:self.percent75];
    [self addSubview:self.percent100];
    [self addSubview:self.topSlider];
}

- (void)makeContraints
{
    [self.bottomProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(FitScreenSize(2), 0, FitScreenSize(2), 0));
    }];
    [self.percent0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(FitScreenSize(12));
    }];
    [self.percent25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.percent0.mas_right).offset(FitScreenSize(32));
        make.width.height.mas_equalTo(FitScreenSize(12));
    }];
    [self.percent50 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.height.mas_equalTo(FitScreenSize(12));
    }];
    [self.percent75 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.percent50.mas_right).offset(FitScreenSize(32));
        make.width.height.mas_equalTo(FitScreenSize(12));
    }];
    [self.percent100 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(FitScreenSize(12));
    }];
    [self.topSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(FitScreenSize(-5), FitScreenSize(-6), FitScreenSize(-5), FitScreenSize(-6)));
    }];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    _tapGesture.delegate = self;
    [_topSlider addGestureRecognizer:_tapGesture];
}

- (void)topSliderTouchDown:(UISlider *)slider {
    _tapGesture.enabled = NO;
}

- (void)topSliderTouchUp:(UISlider *)slider {
    _tapGesture.enabled = YES;
}

- (void)topSliderValueChanged:(UISlider *)slider {
    [self.bottomProgress setProgress:slider.value/100 animated:NO];
    NSString * imageStr = @"";
    if (self.type==0) {//买为绿色
        imageStr = @"order-bcircle-ic";
    } else {
        imageStr = @"aorder-bcircle-ic";
    }
    
    if (slider.value>=100) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:imageStr]];
        [self.percent75 setImage:[UIImage imageNamed:imageStr]];
        [self.percent100 setImage:[UIImage imageNamed:imageStr]];
    } else if (slider.value>=75) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:imageStr]];
        [self.percent75 setImage:[UIImage imageNamed:imageStr]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    } else if (slider.value>=50) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:imageStr]];
        [self.percent75 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    } else if (slider.value>=25) {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:imageStr]];
        [self.percent50 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent75 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    } else {
        [self.percent0 setImage:[UIImage imageNamed:imageStr]];
        [self.percent25 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent50 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent75 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
        [self.percent100 setImage:[UIImage imageNamed:@"aorder-acircle-ic"]];
    }
    if (self.valueBlock) {
        self.sliderValue = slider.value;
        self.valueBlock(slider.value);
    }
}



//适配屏幕(size输入pt)
- (float)smartSizeCalculate:(float)size{
    float iphone6width=375;
    float scale=SCREEN_WIDTH/iphone6width;
    return scale*size;
}


@end
