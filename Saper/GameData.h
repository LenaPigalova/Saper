//
//  GameData.h
//  Saper
//
//  Created by Admin on 22.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitGame.h"

@interface GameData : NSObject

-(instancetype)initWithIGame:(InitGame *)iGame;
@property(nonatomic, strong)NSMutableArray *arrayButtonState;
-(void)randomInitArrayButtonState;
-(void)openAllVoidField:(NSInteger)i;
@property(nonatomic, strong)InitGame *iGame;

@end
