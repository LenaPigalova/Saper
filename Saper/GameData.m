//
//  GameData.m
//  Saper
//
//  Created by Admin on 22.04.17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "GameData.h"
#import "ButtonData.h"



@interface GameData()

@end


@implementation GameData
-(instancetype)initWithIGame:(InitGame *)iGame
{
    self = [super init];
    if(self)
    {
        self.iGame = iGame;
        self.arrayButtonState = [[NSMutableArray alloc]initWithCapacity:(iGame.widthField * iGame.heightField)];
    }
    return self;
}

-(void)openAllVoidField:(NSInteger)i
{
    
    ButtonData *butData;
    if(i - sqrt([self.arrayButtonState count])>=0)
    {
        butData = self.arrayButtonState[(int)(i-sqrt([self.arrayButtonState count]))];
        if(!butData.isTouched && !butData.isFlag)
        {
            
            butData.touched = true;
            if([butData.buttonState isEqualToString:@""])
            {
                [self openAllVoidField:i-sqrt([self.arrayButtonState count])];
            }
        }
    }
    if(i-1>=0 && (i % 8))
    {
        butData = self.arrayButtonState[i-1];
        if(!butData.isTouched && !butData.isFlag)
        {
            butData.touched = true;
            if([butData.buttonState isEqualToString:@""])
            {
                [self openAllVoidField:i-1];
            }
            
        }
        
    }
    if(1+i<[self.arrayButtonState count] && ((i+1) % 8))
    {
        butData = self.arrayButtonState[i+1];
        if(!butData.touched && !butData.isFlag)
        {
            
            butData.touched = true;
            if ([butData.buttonState isEqualToString:@""]) {
                [self openAllVoidField:i+1];
            }
            
        }
        
    }
    if(i + sqrt([self.arrayButtonState count])<[self.arrayButtonState count])
    {
        butData = self.arrayButtonState[(int)(i+sqrt([self.arrayButtonState count]))];
        if(!butData.touched && !butData.isFlag)
        {
            butData.touched = true;
            if ([butData.buttonState isEqualToString:@""]) {
                [self openAllVoidField:i+sqrt([self.arrayButtonState count])];
            }
        }
    }
    
    
    if((i - 1 - sqrt([self.arrayButtonState count]))>=0 && (i % 8))
    {
        butData = self.arrayButtonState[(int)(i - 1 -sqrt([self.arrayButtonState count]))];
        if(![butData.buttonState isEqualToString:@"M"] && !butData.isFlag)
        {
            butData.touched = true;
        }
        
    }
    if((i - 1 + sqrt([self.arrayButtonState count]))< [self.arrayButtonState count] && (i % 8))
    {
        butData = self.arrayButtonState[(int)(i - 1 + sqrt([self.arrayButtonState count]))];
        if(![butData.buttonState isEqualToString:@"M"] && !butData.isFlag)
        {
            butData.touched = true;
        }
        
    }
    
    if((i + 1 - sqrt([self.arrayButtonState count]))>=0 && ((i + 1) % 8))
    {
        butData = self.arrayButtonState[(int)(i + 1 - sqrt([self.arrayButtonState count]))];
        if(![butData.buttonState isEqualToString:@"M"] && !butData.isFlag)
        {
            butData.touched = true;
        }
        
    }
    if((i + 1 + sqrt([self.arrayButtonState count]))<[self.arrayButtonState count] && ((i + 1) % 8))
    {
        butData = self.arrayButtonState[(int)(i + 1 + sqrt([self.arrayButtonState count]))];
        if(![butData.buttonState isEqualToString:@"M"] && !butData.isFlag)
        {
            butData.touched = true;
        }
        
    }
    return;
}

-(void)randomInitArrayButtonState
{
    for(int  i = 0; i<self.iGame.widthField * self.iGame.heightField; i++)
    {
        ButtonData *butData = [[ButtonData alloc]init];
        butData.buttonState = @"";
        butData.touched = false;
        butData.flag = false;
        [self.arrayButtonState addObject:butData];
    }
    for(int i=0; i<self.iGame.bombs; i++)
    {
        //int x = [self.arrayButtonState count];
        unsigned index = arc4random() % [self.arrayButtonState count];
        if(self.arrayButtonState[index])
        {
            ButtonData *butData = self.arrayButtonState[index];
            if ([butData.buttonState isEqualToString:@"M"]) {
                i--;
                continue;
            }
            butData.touched = false;
            butData.buttonState = @"M";
        }
    }
    for(int i = 0; i<[self.arrayButtonState count]; i++)
    {
        int count = 0;
        if(!self.arrayButtonState[i])
        {
            continue;
        }
        ButtonData *butData;
        
        for(int x = -1; x< 2; x++)
        {
            for(int j = -1; j<2; j++)
            {
                if(!(i % 8) && j == -1)
                    continue;
                if(!((i+1)%8) && j == 1)
                {
                    continue;
                }
                int k = i + x*sqrt([self.arrayButtonState count]) + j;
                if(k>=0 && k<[self.arrayButtonState count])
                {
                    butData = self.arrayButtonState[k];
                    if([butData.buttonState isEqualToString: @"M"])
                    {
                        count++;
                    }
                    
                }
            }
            
        }
        butData = self.arrayButtonState[i];
        if(![butData.buttonState isEqualToString:@"M"] && count>0)
        {
            butData.buttonState = [NSString stringWithFormat:@"%d", count];
        }
    }
}


@end
