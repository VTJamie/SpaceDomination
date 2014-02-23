//
//  BattleMenu.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "BattleMenu.h"
#import "Planet.h"
#import "PlanetMenu.h"

@implementation BattleMenu

- (id)initWithPlanet: (Planet*) planet
{
    if ((self = [super init]))
    {
        self.planet = planet;
        self.planet.underattack = YES;
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    // release any resources here
    
}

- (void)setup
{
        double rightcolumnwidth = 150.0;
    
    SPImage *background = [[SPImage alloc] initWithContentsOfFile:@"spacedock.png"];
    background.pivotX = 0;
    background.pivotY = 0;
    background.x = 0;
    background.y = 0;
    background.scaleX = Sparrow.stage.width / background.width ;
    background.scaleY = Sparrow.stage.height / background.height;
    //NSLog(@"%f, %f", background.width, background.height);
    [self addChild:background];
    
    SPQuad* bgmask = [[SPQuad alloc] initWithWidth:background.width height:background.height color:0x000000];
    bgmask.alpha = 0.75;
    [self addChild:bgmask];
    
    for (int i = 0; i < self.planet.ships.count; i++)
    {
        Ship* curship = [self.planet.ships objectAtIndex:i];
        curship.currentShields = curship.maxShields;
    }
    
    for (int i = 0; i < [Game instance].player.ships.count; i++)
    {
        Ship* curship = [[Game instance].player.ships objectAtIndex:i];
        curship.currentShields = curship.maxShields;
    }
    
    self.sapphireCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"0: Sapphire" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.sapphireCount.x = Sparrow.stage.width - rightcolumnwidth;
    self.sapphireCount.y = 50;
    self.sapphireCount.hAlign = SPHAlignRight;  // horizontal alignment
    [self addChild:self.sapphireCount];
    
    self.babylonCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"0: Babylon" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.babylonCount.x = Sparrow.stage.width - rightcolumnwidth;
    self.babylonCount.y = 100;
    self.babylonCount.hAlign = SPHAlignRight;  // horizontal alignment
    [self addChild:self.babylonCount];
    
    
    self.makoCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"0: Mako" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.makoCount.x = Sparrow.stage.width - rightcolumnwidth;
    self.makoCount.y = 150;
    self.makoCount.hAlign = SPHAlignRight;  // horizontal alignment
    [self addChild:self.makoCount];
    
    self.fleetSapphireCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"Sapphire: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetSapphireCount.x = 0;
    self.fleetSapphireCount.y = 50;
    self.fleetSapphireCount.hAlign = SPHAlignLeft;  // horizontal alignment
    [self addChild:self.fleetSapphireCount];
    
    self.fleetBabylonCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"Babylon: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetBabylonCount.x = 0;
    self.fleetBabylonCount.y = 100;
    self.fleetBabylonCount.hAlign = SPHAlignLeft;  // horizontal alignment
    [self addChild:self.fleetBabylonCount];
    
    self.fleetMakoCount = [[SPTextField alloc] initWithWidth:rightcolumnwidth height:50 text:@"Mako: 0" fontName:@"Helvetica Bold" fontSize:18.0f color:0xff0000];
    self.fleetMakoCount.x = 0;
    self.fleetMakoCount.y = 150;
    self.fleetMakoCount.hAlign = SPHAlignLeft;  // horizontal alignment
    [self addChild:self.fleetMakoCount];
    
    [self addEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    Fleet* player = [Game instance].player;
    if (player.ships.count == 0)
    {
        NSLog(@"PLAYER HAS LOST!");
        self.planet.underattack = NO;
        [self removeFromParent];
        [self removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    }
    else if (self.planet.ships.count == 0) {
        NSLog(@"PLAYER HAS WON!");
        self.planet.underattack = NO;
        [self removeFromParent];
        [self removeEventListener:@selector(onEnterFrame:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [self.planet changeTeam:player.team];
        [Sparrow.stage addChild:[[PlanetMenu alloc] initWithPlanet:self.planet]];
    }
    else
    {
        [self handleAttacks: event.passedTime];
    }
}

- (void) handleAttacks: (double) timepassed
{
    
    [self adjustShipEnhancements:self.planet.ships timepassed:timepassed];
    [self adjustShipEnhancements:[Game instance].player.ships timepassed:timepassed];
    
    for (int i = 0; i < self.planet.ships.count; i++)
    {
        Ship* target = [[Game instance].player getShipWithShields];
        BOOL attacked = [[self.planet.ships objectAtIndex:i] advanceFight: target timepassed:timepassed];
        if (attacked)
        {
         //   NSLog(@"PLANET SHIP ATTACKED!");
        }
    }
    
    for (int i = 0; i < [Game instance].player.ships.count; i++)
    {
        Ship* target =[self.planet getShipWithShields];
        BOOL attacked = [[[Game instance].player.ships objectAtIndex:i] advanceFight:target timepassed:timepassed];
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
    
    for (int i = 0; i < [Game instance].player.ships.count; i++)
    {
        if ([[[Game instance].player.ships objectAtIndex:i] currentShields] <= 0)
        {
         //   NSLog(@"PLAYER SHIP DESTROYED");
            [[Game instance].player.ships removeObjectAtIndex:i];
            i--;
        }
    }
    
    [self updateTexts];
}

- (void) updateTexts
{
    NSArray* makoships = [self.planet makoShips];
    NSArray* sapphireships = [self.planet sapphireShips];
    NSArray* babylonships = [self.planet babylonShips];
    
    NSArray* fleetMakoships = [[Game instance].player makoShips];
    NSArray* fleetSapphireships = [[Game instance].player sapphireShips];
    NSArray* fleetBabylonships = [[Game instance].player babylonShips];
    
    self.sapphireCount.text = [NSString stringWithFormat:@"%d: Sapphire", sapphireships.count];
    self.makoCount.text = [NSString stringWithFormat:@"%d: Mako", makoships.count];
    self.babylonCount.text = [NSString stringWithFormat:@"%d: Babylon", babylonships.count];
    
    self.fleetSapphireCount.text = [NSString stringWithFormat:@"Sapphire: %d", fleetSapphireships.count];
    self.fleetMakoCount.text = [NSString stringWithFormat:@"Mako: %d", fleetMakoships.count];
    self.fleetBabylonCount.text = [NSString stringWithFormat:@"Babylon: %d", fleetBabylonships.count];
}

- (void) adjustShipEnhancements: (NSArray*) shiparray timepassed: (double) timepassed
{
    double accuracyBoost = 1.0;
    double attackPowerBoost = 1.0;
    double attackSpeedBoost = 1.0;
    double maxShieldsBoost = 0.0;
    
   
    for (Ship* ship in shiparray)
    {
        accuracyBoost += ship.accuracyBoost;
        attackPowerBoost += ship.attackPowerBoost;
        attackSpeedBoost += ship.attackSpeedBoost;
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
