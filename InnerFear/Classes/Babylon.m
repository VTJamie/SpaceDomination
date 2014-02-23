//
//  Babylon.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "Babylon.h"

@implementation Babylon

- (id) init
{
    self = [super init];
    if (self)
    {
        self.cost = 2.5;
        self.attackPower = 0.5;
        self.attackSpeed = 1.5;
        self.maxShields = 2.0;
    }
    return self;
}

@end
