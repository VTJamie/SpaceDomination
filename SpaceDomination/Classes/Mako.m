//
//  Mako.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "Mako.h"

@implementation Mako

- (id) init
{
    self = [super init];
    if (self)
    {
        self.cost = 1.0;
        self.attackSpeed = 0.5;
        self.attackPower = 0.5;
        self.maxShields = 0.5;
             
        self.accuracy = 1.0;
    }
    return self;
}

@end
