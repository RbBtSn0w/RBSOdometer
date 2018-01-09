//
//  RBSReusableDelegate.h
//
// Copyright (c) 2017 RbBtSn0w
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RBSReusableDelegate <NSObject>

@property (nonatomic, copy) NSString *reuseIdentifier;

@optional

/**
 建议实现这个协议，如果没有实现这个协议，在ReuseQueue 中 registerClass 这样的函数的注册就没有意义，且
 函数 dequeueReusableObjectWithIdentifier 可能返回 nil。
 
 @param reuseIdentifier reuseIdentifier description
 @return 实例化函数
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void) prepareForReuse;

@end
NS_ASSUME_NONNULL_END
