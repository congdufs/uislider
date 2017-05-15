//
//  EGSlider.h
//  EGSliderTest
//
//  Created by Kowin on 2017/3/2.
//  Copyright © 2017年 Dreams. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EGSliderDelegate <NSObject>

@required
- (void)valueChangedDelegate:(int)value;

@end
@interface EGSlider : UISlider
@property (weak, nonatomic) id<EGSliderDelegate> delegate;
@end
