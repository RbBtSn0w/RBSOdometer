//
//  RBSViewController.m
//  RBSOdometer
//
//  Created by RbBtSn0w on 01/08/2018.
//  Copyright (c) 2018 RbBtSn0w. All rights reserved.
//

#import "RBSViewController.h"
#import <RBSOdometer/RBSOdometerView.h>

@interface RBSViewController ()
@property (nonatomic, strong) RBSOdometerView *odometerView;
@end

@implementation RBSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setGroupingSeparator:@","];
    [numberFormatter setGroupingSize:3];
    [numberFormatter setUsesGroupingSeparator:YES];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    
    
    self.odometerView = [[RBSOdometerView alloc] initWithFrame:CGRectZero];
    self.odometerView.font = [UIFont systemFontOfSize:26];
    self.odometerView.backgroundColor = [UIColor redColor];
    self.odometerView.textColor = [UIColor greenColor];
    self.odometerView.formatter = numberFormatter;
    [self.view addSubview:self.odometerView];
    
    self.odometerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.odometerView
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.odometerView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    [self.view addConstraints:@[centerX,centerY]];
    
    
    [self.odometerView setupNumber:123];
    
    [self dispatchRandomNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dispatchRandomNumber {
    __weak typeof(self) weakSelf = self;
    NSTimeInterval gapInterval = 3;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(gapInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        long long lastCount = weakSelf.odometerView.number;
        long long count = lastCount + [weakSelf _tstRandomNumberBetween:lastCount to:lastCount+123];
        [weakSelf.odometerView setupNumber:count];
        
        [weakSelf dispatchRandomNumber];
    });
}

- (long)_tstRandomNumberBetween:(long)from to:(long)to {
    return from + arc4random() % (to-from+1);
}
@end
