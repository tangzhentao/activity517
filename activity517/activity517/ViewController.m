//
//  ViewController.m
//  activity517
//
//  Created by tang on 2017/5/17.
//  Copyright © 2017年 tangzhentao. All rights reserved.
//

#import "ViewController.h"
#import "Calculater.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;

- (IBAction)calculate:(id)sender;
- (IBAction)nextGroupData:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     / x + 
     4 / 2 x 250 + 17
     
     */
    
    self.resultLabel.text = @"517";
    
    [self setDefaultValues];
}

- (void)setDefaultValues
{
    _textField1.text = @"20";
    _textField2.text = @"25";
    _textField3.text = @"18";
    _textField4.text = @"1";

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)calculate:(id)sender {
    
    NSString * n1 = _textField1.text;
    NSString * n2 = _textField2.text;
    NSString * n3 = _textField3.text;
    NSString * n4 = _textField4.text;
    int result = 517;
    NSString * tmpResult = 0;
    
    Calculater *add = [Calculater new];
    add.operationType = OperationTypeAdd;
    
    Calculater *subtract = [Calculater new];
    subtract.operationType = OperationTypeSubtract;
    
    Calculater *mutiply = [Calculater new];
    mutiply.operationType = OperationTypeMultiply;
    
    Calculater *divide = [Calculater new];
    divide.operationType = OperationTypeDivide;
    
    NSArray *operators = @[add,
                           subtract,
                           mutiply,
                           divide,
                           ];
    int count = 0;
    for (Calculater *first in operators) {
        for (Calculater *second in operators) {
            if (second.operationType == first.operationType) {
                continue;
            }
            
            for (Calculater *third in operators) {
                if (third.operationType == first.operationType || third.operationType == second.operationType) {
                    continue;
                }
                count++;
                
                NSMutableArray *items = [NSMutableArray array];

                [items addObject:n1];
                [items addObject:first];
                [items addObject:n2];
                [items addObject:second];
                [items addObject:n3];
                [items addObject:third];
                [items addObject:n4];
                
                NSString *logString = [self stringWithItems:items];
                NSLog(@"%d: %@", count, logString);
                tmpResult = [self calculateWithItems:items];
                if (tmpResult.intValue == result) {
                    
                    
                    // set
                    _label1.text = first.operationText;
                    _label2.text = second.operationText;
                    _label3.text = third.operationText;

                    return;
                }
            }
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"数据不对吧！"
                                                   delegate:nil
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles:nil,
                          nil];
    [alert show];

}

- (IBAction)nextGroupData:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"还没实现^_^！"
                                                   delegate:nil
                                          cancelButtonTitle:@"ok"
                                          otherButtonTitles:nil,
                          nil];
    [alert show];
}

- (NSString *)calculateWithItems:(NSMutableArray *)items
{
    // print
    NSString *logString = [self stringWithItems:items];
    NSLog(@"%@", logString);
    if (items.count == 1) {
        NSLog(@" ");
    }
    
    NSString * result = nil;
    
    if (items.count > 0)
    {
        
        if (items.count == 1)
        {
            // 最终计算结果
            result = items.firstObject;
        }else
        {
            // 需要继续计算
            Calculater *cal = items[1];
            if (cal.operationType == OperationTypeDivide || cal.operationType == OperationTypeMultiply)
            {
                // 如果是乘除运算、直接计算
                cal.item1 = items[0];
                cal.item2 = items[2];
                NSString *tmp = [cal calculate];
                
                // 删除已经计算的项
                [items removeObjectAtIndex:0];
                [items removeObjectAtIndex:0];
                [items removeObjectAtIndex:0];
                
                // 添加计算结果
                [items insertObject:tmp atIndex:0];
                
                result = [self calculateWithItems:items];

            } else
            {
                // 如果是加减运算、根据下一个运算符来判断是否能直接计算
                if (items.count == 3)
                {
                    // 只有一个操作符，直接运算
                    cal.item1 = items[0];
                    cal.item2 = items[2];
                    NSString *tmp = [cal calculate];
                    
                    // 删除已经计算的项
                    [items removeObjectAtIndex:0];
                    [items removeObjectAtIndex:0];
                    [items removeObjectAtIndex:0];
                    
                    // 添加计算结果
                    [items insertObject:tmp atIndex:0];
                    
                    result = [self calculateWithItems:items];
                } else if ((items.count > 3))
                {
                    Calculater *cal2 = items[3];
                    if (cal2.operationType == OperationTypeDivide || cal2.operationType == OperationTypeMultiply)
                    {
                        // 下一个操作符是乘除，计算下一个运算
                        cal2.item1 = items[2];
                        cal2.item2 = items[4];
                        NSString *tmp = [cal2 calculate];
                        
                        // 删除已经计算的项
                        [items removeObjectAtIndex:2];
                        [items removeObjectAtIndex:2];
                        [items removeObjectAtIndex:2];
                        
                        // 添加计算结果
                        [items insertObject:tmp atIndex:2];
                        result = [self calculateWithItems:items];
                    } else
                    {
                        // 下一个操作符是加加减，直接运算
                        cal.item1 = items[0];
                        cal.item2 = items[2];
                        NSString *tmp = [cal calculate];
                        
                        // 删除已经计算的项
                        [items removeObjectAtIndex:0];
                        [items removeObjectAtIndex:0];
                        [items removeObjectAtIndex:0];
                        
                        // 添加计算结果
                        [items insertObject:tmp atIndex:0];
                        
                        result = [self calculateWithItems:items];
                    }
                }
            }
        }
    }
    
    return result;
}

- (NSString *)stringWithItems:(NSArray *)items
{
    NSMutableString *logString = [NSMutableString string];
    for (id item in items) {
        if ([item isKindOfClass:[NSString class]]) {
            [logString appendString:item];
        } else if ([item isKindOfClass:[Calculater class]])
        {
            [logString appendString:[item operationText]];
        }
        
        [logString appendString:@" "];
    }
    return logString;
}
@end
