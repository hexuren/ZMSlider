//
//  ZMSliderView.h
//  ZMSliderView
//
//  Created by abc on 2019/7/5.
//  Copyright © 2019 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMSliderView : UIView

- (void)setSliderStatus:(NSInteger)type;//0为买。1为卖

- (void)setSliderValue:(double)value;

- (void)sliderValueBlock:(void(^)(CGFloat value))block;//返回值为0-100;

@property (nonatomic, assign, readonly) CGFloat sliderValue;

@end

NS_ASSUME_NONNULL_END
