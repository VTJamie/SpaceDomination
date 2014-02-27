//
//  BattleMenu.m
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/16/14.
//
//

#import "BattleMenu.h"
#import "Planet.h"
#import "PlanetMenu.h"
#import "BattleEngine.h"

@implementation BattleMenu

- (id)initWithPlanet: (Planet*) planet
{
    if ((self = [super init]))
    {
        self.battleEngine = [[BattleEngine alloc] initWithPlanet:planet Fleet: [Game instance].playarea.player];
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
    [self.battleEngine addEventListener:@selector(onBattleWon:) atObject:self forType:EVENT_BATTLE_WON];
    [self.battleEngine addEventListener:@selector(onBattleLost:) atObject:self forType:EVENT_BATTLE_LOST];
    
    [self.battleEngine setup];
}

- (void) onBattleWon: (SPEvent*) event {
    [self removeFromParent];
    if ([Game instance].playarea && ![Game instance].playarea.gameover)
    {
        [Sparrow.stage addChild:[[PlanetMenu alloc] initWithPlanet:self.battleEngine.planet]];
    }
}

- (void) onBattleLost: (SPEvent*) event {
    [self removeFromParent];
}

- (void)onEnterFrame:(SPEnterFrameEvent *)event
{
    if ([Game instance].playarea && ![Game instance].playarea.gameover)
    {
        [self updateTexts];
    }
    else {
        [self removeFromParent];
    }
}

- (void) updateTexts
{
    NSArray* makoships = [self.battleEngine.planet makoShips];
    NSArray* sapphireships = [self.battleEngine.planet sapphireShips];
    NSArray* babylonships = [self.battleEngine.planet babylonShips];
    
    NSArray* fleetMakoships = [[Game instance].playarea.player makoShips];
    NSArray* fleetSapphireships = [[Game instance].playarea.player sapphireShips];
    NSArray* fleetBabylonships = [[Game instance].playarea.player babylonShips];
    
    self.sapphireCount.text = [NSString stringWithFormat:@"%d: Sapphire", sapphireships.count];
    self.makoCount.text = [NSString stringWithFormat:@"%d: Mako", makoships.count];
    self.babylonCount.text = [NSString stringWithFormat:@"%d: Babylon", babylonships.count];
    
    self.fleetSapphireCount.text = [NSString stringWithFormat:@"Sapphire: %d", fleetSapphireships.count];
    self.fleetMakoCount.text = [NSString stringWithFormat:@"Mako: %d", fleetMakoships.count];
    self.fleetBabylonCount.text = [NSString stringWithFormat:@"Babylon: %d", fleetBabylonships.count];
}



@end
