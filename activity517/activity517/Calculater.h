//
//  Calculater.h
//  activity517
//
//  Created by tang on 2017/5/17.
//  Copyright © 2017年 tangzhentao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, OperationType)
{
    OperationTypeAdd = 1,
    OperationTypeSubtract = 2,
    OperationTypeMultiply = 3,
    OperationTypeDivide = 4,

};

@interface Calculater : NSObject

@property (assign, nonatomic) OperationType operationType;
@property (strong, nonatomic) NSString * item1;
@property (strong, nonatomic) NSString * item2;

- (NSString *)operationText;
- (NSString *)calculate;


@end
