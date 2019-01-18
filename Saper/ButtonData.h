//
//  ButtonData.h
//  Saper
//
//  Created by Admin on 21.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonData : NSObject

@property(nonatomic, strong)NSString *buttonState;
@property(nonatomic, getter = isTouched)BOOL touched;
@property(nonatomic, getter = isFlag)BOOL flag;

@end
