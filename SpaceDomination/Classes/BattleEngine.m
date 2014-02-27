//
//  BattleEngine.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "BattleEngine.h"
#import "Fleet.h"

@implementation BattleEngine

- (id)initWithPlanet: (Planet*) planet Fleet: (Fleet*) fleet
{
    self = [super init];
    if (self)
    {
        self.planet = planet;
        self.fleet = fleet;
        self.planet.underattack = YES;
    }
    return self;
}

- (void) setup
{
    for (int i = 0; i < self.planet.ships.count; i++)
    {
        Ship* curship = [self.planet.ships objectAtIndex:i];
        curship.currentShields = curship.maxShields;
    }
    
    for (int i = 0; i < self.fleet.ships.count; i++)
    {
        Ship* curship = [self.fleet.ships objectAtIndex:i];
        curship.currentShields = curship.maxShields;
    }

    [[Game instance] addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    if (self.fleet.ships.count == 0)
    {
        NSLog(@"BATTLE WAS LOST!");
        self.planet.underattack = NO;
        
        [[Game instance] removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_BATTLE_LOST] ];
    }
    else if (self.planet.ships.count == 0) {
        NSLog(@"BATTLE WAS WON!");
        self.planet.underattack = NO;
        [[Game instance] removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self.planet changeTeam:self.fleet.team];
        [self dispatchEvent:[[SPEvent alloc] initWithType:EVENT_BATTLE_WON] ];

    }
    else
    {
        [self handleAttacks: event.passedTime];
    }
}

- (void) handleAttacks: (double) timepassed
{
    
    [self adjustShipEnhancements:self.planet.ships timepassed:timepassed];
    [self adjustShipEnhancements:self.fleet.ships timepassed:timepassed];
    
    for (int i = 0; i < self.planet.ships.count; i++)
    {
        Ship* target = [self.fleet getShipWithShields];
        BOOL attacked = [[self.planet.ships objectAtIndex:i] advanceFight: target timepassed:timepassed];
        if (attacked)
        {
            //   NSLog(@"PLANET SHIP ATTACKED!");
        }
    }
    
    for (int i = 0; i < self.fleet.ships.count; i++)
    {
        Ship* target =[self.planet getShipWithShields];
        BOOL attacked = [[self.fleet.ships objectAtIndex:i] advanceFight:target timepassed:timepassed];
        if (attacked)
        {
            //            NSLog(@"PLAYER SHIP ATTACKED!");
        }
    }
    
    for (int i = 0; i < self.planet.ships.count; i++)
    {
        if ([[self.planet.ships objectAtIndex:i] currentShields] <= 0)
        {
            //    NSLog(@"PLANET SHIP DESTROYED");
            [self.planet.ships removeObjectAtIndex:i];
            i--;
        }
    }
    
    for (int i = 0; i < self.fleet.ships.count; i++)
    {
        if ([[self.fleet.ships objectAtIndex:i] currentShields] <= 0)
        {
            //   NSLog(@"PLAYER SHIP DESTROYED");
            [self.fleet.ships removeObjectAtIndex:i];
            i--;
        }
    }
}

- (void) adjustShipEnhancements: (NSArray*) shiparray timepassed: (double) timepassed
{
    double accuracyBoost = 1.0;
    double attackPowerBoost = 1.0;
    double attackSpeedBoost = 1.0;
    double maxShieldsBoost = 0.0;
    
    
    for (Ship* ship in shiparray)
    {
        accuracyBoost *= ship.accuracyBoost + 1.0;
        attackPowerBoost *= ship.attackPowerBoost + 1.0;
        attackSpeedBoost *= ship.attackSpeedBoost + 1.0;
        maxShieldsBoost += ship.shieldRegenerateBoost;
    }
    
    for (Ship* ship in shiparray)
    {
        ship.accuracyEnhancement = accuracyBoost;
        ship.attackPowerEnhancement = attackPowerBoost;
        ship.attackSpeedEnhancement = attackSpeedBoost;
        ship.shieldRegenerateEnhancement = maxShieldsBoost;
        
        [ship advanceShieldRegeneration: timepassed];
    }
}

@end
