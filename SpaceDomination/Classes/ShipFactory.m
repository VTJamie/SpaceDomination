//
//  TimeFactory.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/13/14.
//
//

#import "ShipFactory.h"
#import "Sapphire.h"
#import "Mako.h"
#import "Babylon.h"

@implementation ShipFactory

- (id) initWithTimeForUnit: (double) timeForUnit unitSize: (double) unitSize
{
    self = [super init];
    if (self)
    {
        self.currentTime = 0.0;
        self.accumulatedUnits = 0.0;
        self.timeForUnit = timeForUnit;
        self.unitSize = unitSize;
        self.shiporder = [[NSMutableArray alloc] init];
        [self.shiporder addObject:[Mako class]];
        [self.shiporder addObject:[Mako class]];
        [self.shiporder addObject:[Mako class]];
        [self.shiporder addObject:[Mako class]];
        [self.shiporder addObject:[Mako class]];
        [self.shiporder addObject:[Sapphire class]];
        [self.shiporder addObject:[Babylon class]];
        
    }
    return self;
}

- (double) getUnit: (double) timePassed
{
    int numberofunits;
    self.currentTime += timePassed;
    
    if (self.currentTime >= self.timeForUnit)
    {
        numberofunits = self.currentTime / self.timeForUnit;
        self.currentTime = self.currentTime - self.timeForUnit * numberofunits;
        return numberofunits * self.unitSize;
    }
    else {
        return 0;
    }
    
}

- (NSArray*) getBuildUnits: (double) timePassed
{
    NSMutableArray* builtships = [[NSMutableArray alloc] init];
    self.accumulatedUnits += [self getUnit:timePassed];
    Ship* newship = [[[self.shiporder objectAtIndex:0] alloc] init];
    while (self.accumulatedUnits > newship.cost) {
        Class tempclass = [self.shiporder objectAtIndex:0];
        [self.shiporder removeObjectAtIndex:0];
        [self.shiporder addObject:tempclass];
        [builtships addObject:newship];
        newship = [[[self.shiporder objectAtIndex:0] alloc] init];
        self.accumulatedUnits -= newship.cost;
    }
    return builtships;
}

@end
