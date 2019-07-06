//
//  ViewController.m
//  ZMSlider
//
//  Created by abc on 2019/7/5.
//  Copyright © 2019 zm. All rights reserved.
//

#import "ViewController.h"
#import "ZMSliderView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (nonatomic, strong) ZMSliderView * sliderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView {
    
    _sliderView = [[ZMSliderView alloc] initWithFrame:CGRectMake(0, 0, 187, 12)];
    [_sliderView setSliderStatus:1];
    [self.progressView addSubview:_sliderView];
    [_sliderView sliderValueBlock:^(CGFloat value) {
        NSLog(@"%f",value);
    }];
}

- (IBAction)onClickBuyButton:(UIButton *)sender {
    [_sliderView setSliderStatus:0];
}

- (IBAction)onClickSellButton:(UIButton *)sender {
    [_sliderView setSliderStatus:1];
}

@end
