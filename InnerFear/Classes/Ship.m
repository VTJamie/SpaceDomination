//
//  Ship.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "Ship.h"

@implementation Ship

- (id) init
{
    self = [super init];
    if (self)
    {
        self.attackPower = 1.0;
        self.attackSpeed = 3.0;
        self.maxShields = 1.0;
        self.accuracy = 1.0;
        self.cost = 1.0;
        self.timeelapsed = 0.0;
    }
    return self;
}

- (BOOL) advanceFight: (Ship*) target timepassed: (double) timepassed
{
    self.timeelapsed += timepassed;
    
    if (self.timeelapsed >= self.attackSpeed - self.attackSpeedEnhancement) {
        self.timeelapsed -= (self.attackSpeed - self.attackPowerEnhancement);
        target.currentShields -= self.attackPower + self.attackPowerEnhancement;
        return YES;
    }
    return NO;
}

@end
