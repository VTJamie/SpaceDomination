//
//  BattleEngine.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import <Foundation/Foundation.h>
#import "Planet.h"
#import "Fleet.h"

#define EVENT_BATTLE_WON @"battleWon"
#define EVENT_BATTLE_LOST @"battleLost"

@interface BattleEngine : SPSprite

- (id)initWithPlanet: (Planet*) planet Fleet: (Fleet*) fleet;
- (void) setup;

@property (nonatomic, retain) Planet* planet;
@property (nonatomic, retain) Fleet* fleet;


@end
