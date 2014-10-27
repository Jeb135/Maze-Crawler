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
								{1,9,9,9,9,9,9,9,9,9,9,9,9,9,0},
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
    NSMutableArray *deathBlocks = [[NSMutableArray alloc] init];
	
	for (int xGrid = 0; xGrid < (kMapHorizontalSize / kGridSquareSize); xGrid++)
	{
		for (int yGrid = 0; yGrid < (kMapVerticalSize / kGridSquareSize); yGrid++)
		{
            // Positon and size
            CGSize blockSize = CGSizeMake(kGridSquareSize, kGridSquareSize);
            CGPoint blockPosition = CGPointMake((xGrid+1) * kGridSquareSize - kGridSquareSize / 2,
                                                ((kMapVerticalSize / kGridSquareSize) - yGrid) * kGridSquareSize - kGridSquareSize / 2);
			// If there should be a collision block... add one
			if (collisionMap[yGrid][xGrid] == kObstacleBlock)
			{
				SKPhysicsBody *newBlock = [SKPhysicsBody bodyWithRectangleOfSize:blockSize
																		  center:blockPosition];
                newBlock.dynamic = NO;
				[wallBlocks addObject:newBlock];
			}
            // If the collision block will kill the player imeadiately
            if (collisionMap[yGrid][xGrid] == kDeathBlock)
            {
                SKPhysicsBody *newBlock = [SKPhysicsBody bodyWithRectangleOfSize:blockSize
                                                                          center:blockPosition];
                newBlock.dynamic = NO;
                [deathBlocks addObject:newBlock];
            }
		}
	}
	
	// Create the wall node
	SKNode *walls = [SKNode node];
	walls.physicsBody = [SKPhysicsBody bodyWithBodies:wallBlocks];
	walls.physicsBody.dynamic = NO;
	[self addChild:walls];
    
    // Create the blocks that will kill the player
    //SKNode *deathBlocks = [SKNode node];
    //deathBlocks.physicsBody = [SKPhysicsBody bodyWithBodies:deathBlocks];
    //deathBlocks.physicsBody.dynamic = NO;
    //[self addChild:deathBlocks];
    
    // Create an array to hold the emitter map
    int particleMap[10][15] = { {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                                {2,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                                {0,0,0,0,1,1,1,1,1,1,1,0,0,1,1},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,1,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
                                {0,1,1,1,1,1,1,0,1,1,1,1,1,1,1},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1}};
    
    // Lava Emitters
    NSString *lavaBubblesPath = [[NSBundle mainBundle] pathForResource:@"LavaBubbles" ofType:@"sks"];
    NSString *flameTrapPath = [[NSBundle mainBundle] pathForResource:@"FlameTrap" ofType:@"sks"];
    
    for (int xGrid = 0; xGrid < (kMapHorizontalSize / kGridSquareSize); xGrid++)
    {
        for (int yGrid = 0; yGrid < (kMapVerticalSize / kGridSquareSize); yGrid++)
        {
            // Position
            CGSize blockSize = CGSizeMake(kGridSquareSize, kGridSquareSize);
            CGPoint blockPosition = CGPointMake((xGrid+1) * kGridSquareSize - kGridSquareSize / 2,
                                                ((kMapVerticalSize / kGridSquareSize) - yGrid) * kGridSquareSize - kGridSquareSize / 2);
            // If there should be a collision block... add one
            if (particleMap[yGrid][xGrid] == 1)
            {
                SKEmitterNode *lava = [NSKeyedUnarchiver unarchiveObjectWithFile:lavaBubblesPath];
                lava.name = @"Lava";
                lava.zPosition = 12.0;
                lava.position = blockPosition;
                [self addChild:lava];
            }
            
            if (particleMap[yGrid][xGrid] == 2)
            {
                SKEmitterNode *trap = [NSKeyedUnarchiver unarchiveObjectWithFile:flameTrapPath];
                trap.name = @"FlameTrap";
                trap.zPosition = 12.0;
                trap.position = blockPosition;
                [self addChild:trap];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    // Adjust the lava state
    /*
    [self enumerateChildNodesWithName:@"Lava" usingBlock:^(SKNode *node, BOOL *stop) {
        if (rand() % 100 == 1)
        {
            if (![node isPaused])
            {
                [node setPaused:![node isPaused]];
            }
        }
    }];
     */
}

@end

