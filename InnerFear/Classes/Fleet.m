//
//  Fleet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Fleet.h"
#import "Planet.h"

@implementation Fleet

- (id)initWithSide: (int) team
{
    if ((self = [super init]))
    {
        self.team = team;
        self.planets = [[NSMutableArray alloc] init];
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)setup
{
    for (int i = 0; i < 5; i++)
    {
        Planet* curplanet =[[Planet alloc] initWithTeam:self.team];
        [self.planets addObject:curplanet];
        [self addChild:curplanet];
    }
}

@end
