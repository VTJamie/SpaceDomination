//
//  Sapphire.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "Sapphire.h"

@implementation Sapphire

- (id) init
{
    self = [super init];
    if (self)
    {
        self.cost = 4.0;
        self.attackSpeed = 2.0;
        self.attackPower = 0.5;
        self.maxShields = 2.0;
        self.accuracy = 1.0;
        
        self.shieldRegenerateBoost = 0.01;
        self.accuracyBoost = 0.01;
    }
    return self;
}

@end
