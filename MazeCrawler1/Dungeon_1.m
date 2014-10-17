//
//  Dungeon_1.m
//  MazeCrawler1
//
//  Created by Benjamin Bachman on 10/12/14.
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "Dungeon_1.h"

@implementation Dungeon_1

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor blackColor];
    
    // Background
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_1"];
    background.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
    [self addChild:background];
    // Add shadow layer on top of everything
    SKSpriteNode *shadowLayer = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_1_Shadow"];
    shadowLayer.zPosition = 10;
    shadowLayer.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
    [self addChild:shadowLayer];
    
    
    // Emitters
    /*
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"Square_Flames" ofType:@"sks"];
    
    for (int i = 0; i <= 4; i++)
    {
        SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
        spark.name = @"Fire";
        spark.zPosition = 1.0;
        int ypos, xpos;
        if (i < 2)
        {
            ypos = 32*7 - 16;
            xpos = 32*(8 + i) - 16;
        }
        else
        {
            ypos = 32*6 - 16;
            xpos = 32*(8 + i) - 16;
        }
        
        spark.position = CGPointMake(xpos, ypos);
        [self addChild:spark];
    }
     */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

