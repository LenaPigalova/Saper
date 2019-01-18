//
//  InitGame.m
//  Saper
//
//  Created by Admin on 25.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "InitGame.h"

@interface InitGame ()

@end

@implementation InitGame

-(instancetype)initWithHightWaightAndBombs:(NSInteger)widt :(NSInteger)height :(NSInteger)bomb
{
    self = [super init];
    if(self)
    {
        self.bombs = bomb;
        self.heightField = height;
        self.widthField = widt;
    }
    return self;
}

@end
