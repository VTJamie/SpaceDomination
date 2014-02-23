//
//  BattleMenu.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "SPSprite.h"
#import "Planet.h"
#import "BattleEngine.h"

@interface BattleMenu : SPSprite

@property (nonatomic, retain) SPTextField* sapphireCount;
@property (nonatomic, retain) SPTextField* babylonCount;
@property (nonatomic, retain) SPTextField* makoCount;


@property (nonatomic, retain) SPTextField* fleetSapphireCount;
@property (nonatomic, retain) SPTextField* fleetBabylonCount;
@property (nonatomic, retain) SPTextField* fleetMakoCount;

@property (nonatomic, retain) BattleEngine* battleEngine;


- (id)initWithPlanet: (Planet*) planet;

@end
