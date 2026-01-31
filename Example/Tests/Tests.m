//
//  RBSOdometerTests.m
//  RBSOdometerTests
//
//  Created by RbBtSn0w on 01/08/2018.
//  Copyright (c) 2018 RbBtSn0w. All rights reserved.
//

@import XCTest;
@import RBSOdometer;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInitialization
{
    RBSOdometerView *view = [[RBSOdometerView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    XCTAssertNotNil(view);
}

@end
