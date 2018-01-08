//
//  RBSOdometerView.h
//  RBSOdometer
//
//  Created by Snow.y.wu on 1/3/18.
//  Copyright © 2018 rbbtsn0w. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface RBSOdometerView : UIView

@property (assign, nonatomic, readonly) NSUInteger number;
@property (strong, nonatomic, nullable) NSNumberFormatter *formatter;

@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CFTimeInterval duration;
@property (assign, nonatomic) CFTimeInterval durationOffset;
@property (assign, nonatomic) NSUInteger density;

- (void)setupNumber:(NSUInteger)number;

@end
NS_ASSUME_NONNULL_END
