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

- (id)initWithPlanet: (Planet*) planet;


@end
