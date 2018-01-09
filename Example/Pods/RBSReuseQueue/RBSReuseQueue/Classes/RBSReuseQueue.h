//
//  RBSReuseQueue.h
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
@protocol RBSReusableDelegate;

@interface RBSReuseQueue : NSObject


/**
 将 reusableObject 从重用队列中移除
 
 @param reusableObject reusableObject 必须是实现了QNBReusableDelegate 协议
 */
- (void) enqueueReusableObject:(id<RBSReusableDelegate>)reusableObject;


/**
 依靠identifier，从重用队列中去找寻，如果为找到，就会依赖QNBReusableDelegate 协议，来创建对应的object 并放回。
 
 @warning 需要注意，如果未实现协议 QNBReusableDelegate 中的 initWithReuseIdentifier, 重用队列的cache 不存在的时候，返回值为 nil
 
 @param identifier identifier description
 @return 放回可重用的object
 */
- (nullable id<RBSReusableDelegate>) dequeueReusableObjectWithIdentifier:(NSString *)identifier;


/**
 类似Cell通过自行注册的方式
 
 @warning 需要注意，如果未实现协议 QNBReusableDelegate 中的 initWithReuseIdentifier, 此函数无任何作用
 
 @param aClass 需要注册的Class 可为nil，如果为nil，则会根据对应的id从cache 中移除。 class 必须实现 QNBReusableDelegate 协议
 @param identifier identifier description
 */
- (void) registerClass:(nullable Class)aClass withReuseIdentifier:(NSString *)identifier;

@end
NS_ASSUME_NONNULL_END
