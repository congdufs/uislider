//
//  ViewController.m
//  EGSliderTest
//
//  Created by Kowin on 2017/3/2.
//  Copyright © 2017年 Dreams. All rights reserved.
//

#import "ViewController.h"
#import "EGSlider.h"

@interface ViewController ()<EGSliderDelegate>
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EGSlider *slider = [[EGSlider alloc] initWithFrame:CGRectMake(200, 100, 10, 300)];
    slider.delegate = self;
    slider.minimumTrackTintColor = [UIColor lightGrayColor];
    slider.maximumTrackTintColor = [UIColor blueColor];
    [self.view addSubview:slider];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(190, 500, 50, 30)];
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChangedDelegate:(int)value {
    self.label.text = [NSString stringWithFormat:@"%d %%", value];
}

@end
