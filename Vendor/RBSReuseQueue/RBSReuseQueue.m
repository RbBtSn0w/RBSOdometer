//
//  RBSReuseQueue.m
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

#import <RBSReuseQueue/RBSReuseQueue.h>
#import <RBSReuseQueue/RBSReusableDelegate.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const kUndeineProtolReason = @"未实现 RBSReusableDelegate 协议";
static NSString *const kUndeineProtolInitReason = @"未实现 RBSReusableDelegate 协议中的 initWithReuseIdentifier: ";

static inline NSException * UndeineProtolException(NSString *format, ...){
    NSString *reason = nil;
    va_list args;
    va_start(args, format);
    reason = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    return [NSException exceptionWithName:NSObjectNotAvailableException reason:reason userInfo:nil];
}

@interface RBSReuseQueue ()

@property (nonatomic, strong) NSCache<NSString*, NSMutableSet<id<RBSReusableDelegate>>*> *recycleBin;
@property (nonatomic, strong) NSMutableDictionary<NSString*, NSMutableSet<id<RBSReusableDelegate>>*> *workStation;
@property (nonatomic, strong) NSMutableDictionary<NSString*, Class> *registerClasses;
@end


@implementation RBSReuseQueue


#pragma mark    -   Accessors

- (NSCache<NSString*, NSMutableSet<id<RBSReusableDelegate>>*> *) recycleBin{
    if (!_recycleBin) {
        _recycleBin = [[NSCache alloc] init];
    }
    return _recycleBin;
}

- (NSMutableDictionary<NSString*, NSMutableSet<id<RBSReusableDelegate>>*> *) workStation{
    if (!_workStation) {
        _workStation = [NSMutableDictionary dictionary];
    }
    return _workStation;
}

- (NSMutableDictionary<NSString*, Class> *)registerClasses{
    if (!_registerClasses) {
        _registerClasses = [NSMutableDictionary dictionary];
    }
    return _registerClasses;
}

#pragma mark    -   Super
- (instancetype) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark		Object lifecycle



#pragma mark    -   Private
- (NSMutableSet<id<RBSReusableDelegate>> *) mutableSetValueInRecycleBinForIdentifier:(NSString *)identifier{
    NSMutableSet<id<RBSReusableDelegate>> *recycledSet = [self.recycleBin objectForKey:identifier];
    if (!recycledSet) {
        recycledSet = [NSMutableSet set];
        [self.recycleBin setObject:recycledSet forKey:identifier cost:1];
    }
    return recycledSet;
}

- (NSMutableSet<id<RBSReusableDelegate>> *) mutableSetValueInWorkStationForIdentifier:(NSString *)identifier{
    NSMutableSet<id<RBSReusableDelegate>> *visibleSet = self.workStation[identifier];
    if (!visibleSet) {
        visibleSet = [NSMutableSet set];
        self.workStation[identifier] = visibleSet;
    }
    return visibleSet;
}

- (nullable id<RBSReusableDelegate>) protocolDoInitWithReuseIdentifier:(NSString *)identifier {
    Class aClass = self.registerClasses[identifier];
    if (aClass) {
        NSAssert([aClass conformsToProtocol:@protocol(RBSReusableDelegate)], kUndeineProtolReason);
        id <RBSReusableDelegate> protolObject = [aClass alloc];
        NSAssert([protolObject respondsToSelector:@selector(initWithReuseIdentifier:)], kUndeineProtolInitReason);
        protolObject = [protolObject initWithReuseIdentifier:identifier];
        return protolObject;
    }else {
        return nil;
    }
}


#pragma mark    -   Interface

- (void) enqueueReusableObject:(id<RBSReusableDelegate>)reusableObject{
    if ([reusableObject respondsToSelector:@selector(reuseIdentifier)] && [reusableObject respondsToSelector:@selector(setReuseIdentifier:)] ) {
        
        [[self mutableSetValueInWorkStationForIdentifier:reusableObject.reuseIdentifier] removeObject:reusableObject];
        [[self mutableSetValueInRecycleBinForIdentifier:reusableObject.reuseIdentifier] addObject:reusableObject];
    } else {
        @throw UndeineProtolException(kUndeineProtolReason);
    }
}

- (nullable id<RBSReusableDelegate>) dequeueReusableObjectWithIdentifier:(NSString *)identifier{
    
    id <RBSReusableDelegate> reusableObject = [[self mutableSetValueInRecycleBinForIdentifier:identifier] anyObject];
    if (!reusableObject) {
        reusableObject = [self protocolDoInitWithReuseIdentifier:identifier];
        if (!reusableObject) {
            return reusableObject;
        }
    }
    
    [[self mutableSetValueInRecycleBinForIdentifier:identifier] removeObject:reusableObject];
    [[self mutableSetValueInWorkStationForIdentifier:identifier] addObject:reusableObject];
    
    if ([reusableObject respondsToSelector:@selector(prepareForReuse)]) {
        [reusableObject prepareForReuse];
    }
    
    return reusableObject;
}

- (void) registerClass:(nullable Class)aClass withReuseIdentifier:(NSString *)identifier{
    if (aClass) {
        NSAssert([aClass conformsToProtocol:@protocol(RBSReusableDelegate)], kUndeineProtolReason);
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wunused-variable"
        id <RBSReusableDelegate> protolObject = [aClass alloc];
        NSAssert([protolObject respondsToSelector:@selector(initWithReuseIdentifier:)], kUndeineProtolInitReason);
        #pragma clang diagnostic pop
        [self.registerClasses setObject:aClass forKey:identifier];
    } else {
        [self.registerClasses removeObjectForKey:identifier];
    }
}


@end
NS_ASSUME_NONNULL_END
