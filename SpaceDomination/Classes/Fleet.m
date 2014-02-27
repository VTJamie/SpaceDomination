//
//  Fleet.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Fleet.h"
#import "Planet.h"
#import "Game.h"
#import "TouchBackgroundEvent.h"
#import "CenterChangeEvent.h"
#import "PlanetTouchEvent.h"
#import "PlanetMenu.h"
#import "Sapphire.h"
#import "Mako.h"
#import "Babylon.h"
#import "BattleMenu.h"

@implementation Fleet

- (id)initWithSide: (int) team
{
    if ((self = [super init]))
    {
        self.team = team;
        self.currentLoc = [[SPPoint alloc] init];
        self.fleetSpeedMultiplier = 1.0;
        self.ships = [[NSMutableArray alloc] init];
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void) advanceTime: (double) passedTime
{
    // NSLog(@"Fleet Team: %d, %f", self.team, passedTime);
}

- (void)setup
{
    self.shipImage = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"ship"]];
    
    self.shipImage.pivotX = self.shipImage.width / 2.0;
    self.shipImage.pivotY = self.shipImage.height / 2.0;
    self.shipImage.x = 0;
    self.shipImage.y = 0;
    [self addChild:self.shipImage];
    
    //    self.x = Sparrow.stage.width / 2.0;
    //    self.y = Sparrow.stage.height / 2.0;
    
    if (self.team == 1)
    {
        [[Game instance].playarea addEventListener:@selector(flyToPlanetTouch:) atObject:self forType:EVENT_TYPE_PLANET_TOUCH];
    }
}

- (void) flyToPlanetTouch: (PlanetTouchEvent*) planetevent
{
    [self flyToPlanet:planetevent.planet];
}

- (void) flyToPlanet: (Planet*) planet
{
    if(self.currenttween)
    {
        [[Game instance].gameJuggler removeObjectsWithTarget:self];
    }
    
    double curdistance = sqrt(pow(self.x - planet.x, 2.0) + pow(self.y - planet.y, 2.0));
    self.currenttween = [SPTween tweenWithTarget:self
                                            time:curdistance / (100.0 * self.fleetSpeedMultiplier) transition:SP_TRANSITION_LINEAR];
    
    
    [self.currenttween animateProperty:@"x" targetValue:planet.x];
    [self.currenttween animateProperty:@"y" targetValue:planet.y];
    
    __block Fleet* that = self;
    __block Planet* thatplanet = planet;
    
    self.currenttween.onComplete = ^{
        if (thatplanet.team == that.team)
        {
            [Sparrow.stage addChild:[[PlanetMenu alloc] initWithPlanet:thatplanet]];
        }
        else {
            [Sparrow.stage addChild:[[BattleMenu alloc] initWithPlanet:thatplanet]];
        }
        that.currenttween = nil;
    };
    [[Game instance].gameJuggler addObject:self.currenttween];
}

- (NSArray*) sapphireShips
{
    NSMutableArray* ships = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Sapphire class]])
        {
            [ships addObject:[self.ships objectAtIndex:i]];
        }
    }
    return ships;
}
- (NSArray*) babylonShips
{
    NSMutableArray* ships = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Babylon class]])
        {
            [ships addObject:[self.ships objectAtIndex:i]];
        }
    }
    
    return ships;
    
}
- (NSArray*) makoShips
{
    NSMutableArray* ships = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Mako class]])
        {
            [ships addObject:[self.ships objectAtIndex:i]];
        }
    }
    
    return ships;
    
}


- (Sapphire*) popSapphire
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Sapphire class]])
        {
            Sapphire* ship = [self.ships objectAtIndex: i];
            [self.ships removeObjectAtIndex:i];
            return ship;
        }
    }
    return nil;
}
- (Babylon*) popBabylon
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Babylon class]])
        {
            Babylon* ship = [self.ships objectAtIndex: i];
            [self.ships removeObjectAtIndex:i];
            return ship;
        }
    }
    return nil;
}
- (Mako*) popMako
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[[self.ships objectAtIndex: i] class] isSubclassOfClass:[Mako class]])
        {
            Mako* ship = [self.ships objectAtIndex: i];
            [self.ships removeObjectAtIndex:i];
            return ship;
        }
    }
    return nil;
}


- (Ship*) getShipWithShields
{
    for (int i = 0; i < self.ships.count; i++)
    {
        if ([[self.ships objectAtIndex:i] currentShields] > 0)
        {
            return [self.ships objectAtIndex:i];
        }
    }
    return nil;
}


@end
