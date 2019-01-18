//
//  InitGame.h
//  Saper
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitGame : NSObject

@property(nonatomic)NSInteger widthField;
@property(nonatomic)NSInteger heightField;
@property(nonatomic)NSInteger bombs;

-(instancetype)initWithHightWaightAndBombs:(NSInteger)widt :(NSInteger)height :(NSInteger)bomb;

@end
