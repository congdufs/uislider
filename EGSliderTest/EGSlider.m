//
//  EGSlider.m
//  EGSliderTest
//
//  Created by Kowin on 2017/3/2.
//  Copyright © 2017年 Dreams. All rights reserved.
//

#import "EGSlider.h"

@interface EGSlider ()
@property (strong, nonatomic) UILabel *popUpLabel;
@end

@implementation EGSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGFloat newY = y + (height-width)/2;
    CGFloat newWidth = height;
    CGFloat newHeight = width;
    CGFloat newX = x - (height-width)/2;
    CGRect newFrame = CGRectMake(newX, newY, newWidth, newHeight);
    self = [super initWithFrame:newFrame];
    self.transform = CGAffineTransformMakeRotation(1.57079633);
    NSLog(@"x %f, y %f, width %f, height %f", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [self trackRectForBounds:self.frame];
    [self addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
    self.minimumValue = 0;
    self.maximumValue = 100;
    if (self) {
        [self setUpPopUpLabel];
    }
    return self;
}

- (void)setUpPopUpLabel
{
    self.popUpLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.popUpLabel.hidden = YES;
    self.popUpLabel.textColor = [UIColor colorWithHue:0.6 saturation:0.6 brightness:0.5 alpha:0.65];
    self.popUpLabel.font = [UIFont systemFontOfSize:13];
    self.popUpLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.popUpLabel];
}

- (void)positionAndUpdatePopUpView
{
    [self adjustPopUpViewFrame];
    self.popUpLabel.text = [NSString stringWithFormat:@"%d %%", (int)(100-self.value)];
}

- (void)adjustPopUpViewFrame
{
    CGRect thumbRect = [self thumbRect];
    CGFloat thumbX = thumbRect.origin.x;
    CGFloat thumbY = thumbRect.origin.y;
//    CGFloat thumbW = thumbRect.size.width;
//    CGFloat thumbH = thumbRect.size.height;
    CGRect popUpRect = CGRectMake(thumbX, thumbY+self.popUpLabel.bounds.size.height, 30, 50);
    self.popUpLabel.frame = popUpRect;
//    self.popUpLabel.backgroundColor = [UIColor orangeColor];
    self.popUpLabel.transform = CGAffineTransformMakeRotation(-1.57079633);
}

- (CGRect)thumbRect
{
    return [self thumbRectForBounds:self.bounds
                          trackRect:[self trackRectForBounds:self.bounds]
                              value:self.value];
}

#pragma mark - subclassed

- (void)setMinimumTrackTintColor:(UIColor *)color
{
    [super setMinimumTrackTintColor:color];
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    if (begin) {
        [self positionAndUpdatePopUpView];
        self.popUpLabel.hidden = NO;
    }
    return begin;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL continueTrack = [super continueTrackingWithTouch:touch withEvent:event];
    if (continueTrack) [self positionAndUpdatePopUpView];
    return continueTrack;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
    self.popUpLabel.hidden = YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self positionAndUpdatePopUpView];
    self.popUpLabel.hidden = YES;
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    return bounds;
}

- (void)updateValue:(UISlider *)slider {
    NSLog(@"value %d", (int)(100-slider.value));
    if (self.delegate && [self.delegate respondsToSelector:@selector(valueChangedDelegate:)]) {
        [self.delegate valueChangedDelegate:(int)(100-slider.value)];
    }
}

@end
