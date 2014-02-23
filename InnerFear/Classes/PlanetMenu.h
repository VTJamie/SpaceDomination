//
//  PlanetMenu.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/10/14.
//
//

#import "SPSprite.h"
#import "Planet.h"

@interface PlanetMenu : SPSprite

@property (nonatomic, retain) Planet* planet;
@property (nonatomic, retain) SPTextField* sapphireCount;
@property (nonatomic, retain) SPTextField* babylonCount;
@property (nonatomic, retain) SPTextField* makoCount;


@property (nonatomic, retain) SPTextField* fleetSapphireCount;
@property (nonatomic, retain) SPTextField* fleetBabylonCount;
@property (nonatomic, retain) SPTextField* fleetMakoCount;
@property (nonatomic, retain) NSMutableDictionary* buttonInstances;


- (id)initWithPlanet: (Planet*) planet;




@end
