//
//  Dungeon_1.m
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "Dungeon_1.h"

@implementation Dungeon_1

-(void)didMoveToView:(SKView *)view
{
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
	
	// Initialize the Physics world
	self.physicsWorld.gravity = CGVectorMake(0,0); // No gravity
	
	// Create an array to hold the collision map...
	int collisionMap[10][15] = {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,1,0,0,0,0,0,0,0,1,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
	
	// Create an array of collision blocks based on collision map array
	NSMutableArray *wallBlocks = [[NSMutableArray alloc] init];
	
	for (int xGrid = 0; xGrid < (kMapHorizontalSize / kGridSquareSize); xGrid++)
	{
		for (int yGrid = 0; yGrid < (kMapVerticalSize / kGridSquareSize); yGrid++)
		{
			// If there should be a collision block... add one
			if (collisionMap[yGrid][xGrid] == 1)
			{
				CGSize blockSize = CGSizeMake(kGridSquareSize, kGridSquareSize);
				CGPoint blockPosition = CGPointMake((xGrid+1) * kGridSquareSize - kGridSquareSize / 2,
													((kMapVerticalSize / kGridSquareSize) - yGrid) * kGridSquareSize - kGridSquareSize / 2);
				SKPhysicsBody *newBlock = [SKPhysicsBody bodyWithRectangleOfSize:blockSize
																		  center:blockPosition];
				[wallBlocks addObject:newBlock];
			}
		}
	}
	
	// Create the wall node
	SKNode *walls = [SKNode node];
	walls.physicsBody = [SKPhysicsBody bodyWithBodies:wallBlocks];
	walls.physicsBody.dynamic = NO;
	[self addChild:walls];
    
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

