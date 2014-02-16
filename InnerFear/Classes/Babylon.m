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
        self.attackPower = 1.0;
        self.attackSpeed = 1.0;
        self.maxShields = 1.0;
        self.cost = 1.0;
    }
    return self;
}

@end
