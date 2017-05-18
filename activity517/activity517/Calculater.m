//
//  Calculater.m
//  activity517
//
//  Created by tang on 2017/5/17.
//  Copyright © 2017年 tangzhentao. All rights reserved.
//

#import "Calculater.h"

@implementation Calculater

-(NSString *)calculate
{
    int result = 0;
    switch (_operationType) {
        case OperationTypeAdd:
            result = _item1.intValue + _item2.intValue;
            break;
            
        case OperationTypeSubtract:
            result = _item1.intValue - _item2.intValue;
            break;
            
        case OperationTypeMultiply:
            result = _item1.intValue * _item2.intValue;
            break;
            
        case OperationTypeDivide:
            result = _item1.intValue / (float)_item2.intValue;
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%f", (float)result];
}

-(NSString *)operationText
{
    NSString * text = nil;
    switch (_operationType) {
        case OperationTypeAdd:
            text = @"+";
            break;
            
        case OperationTypeSubtract:
            text = @"-";
            break;
            
        case OperationTypeMultiply:
            text = @"x";
            break;
            
        case OperationTypeDivide:
            text = @"/";
            break;
            
        default:
            break;
    }
    
    return text;
}

@end
