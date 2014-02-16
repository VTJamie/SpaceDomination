//
//  TimeFactory.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/13/14.
//
//

#import "ShipFactory.h"

@implementation ShipFactory

- (id) initWithTimeForUnit: (double) timeForUnit unitSize: (int) unitSize
{
    self = [super init];
    if (self)
    {
        self.currentTime = 0.0;
        self.timeForUnit = timeForUnit;
        self.unitSize = unitSize;
    }
    return self;
}

- (int) getUnit: (double) timePassed
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

@end
