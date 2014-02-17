//
//  BattleMenu.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "SPSprite.h"
#import "Planet.h"

@interface BattleMenu : SPSprite

- (id)initWithPlanet: (Planet*) planet;

@property (nonatomic, retain) Planet* planet;

@end
