//
//  Ship.m
//  SpaceDomination
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
        self.attackTimeTracker = 0.0;
        self.shieldRegenerateTracker = 0.0;
        
        self.attackPowerBoost = 0.0;
        self.attackSpeedBoost = 0.0;
        self.shieldRegenerateBoost = 0.0;
        self.accuracyBoost = 0.0;
    }
    return self;
}

- (void) advanceShieldRegeneration: (double) timepassed
{
    self.shieldRegenerateTracker += timepassed;
    if (self.shieldRegenerateTracker >= 1.0)
    {
        self.currentShields += self.shieldRegenerateEnhancement;
        self.shieldRegenerateTracker -= 1.0;
    }
}

- (BOOL) advanceFight: (Ship*) target timepassed: (double) timepassed
{
    self.attackTimeTracker += timepassed;
    
    double accuracyRandom = (arc4random() % 100) / 100;
    if (accuracyRandom <= self.accuracy * self.accuracyEnhancement)
    {
        if (self.attackTimeTracker >= self.attackSpeed / self.attackSpeedEnhancement) {
            self.attackTimeTracker -= (self.attackSpeed / self.attackSpeedEnhancement);
            target.currentShields -= self.attackPower * self.attackPowerEnhancement;
            return YES;
        }
    }
    return NO;
}

@end
