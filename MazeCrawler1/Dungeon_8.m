//
//  Dungeon_8.m
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "Dungeon_8.h"

@implementation Dungeon_8

-(void)didMoveToView:(SKView *)view
{
    /* Setup your scene here */
	SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_8"];
	background.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
	[self addChild:background];
	// Add shadow layer on top of everything
	SKSpriteNode *shadowLayer = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_8_Shadow"];
	shadowLayer.zPosition = 10;
	shadowLayer.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
	[self addChild:shadowLayer];
	
	// Initialize the Physics world
	self.physicsWorld.gravity = CGVectorMake(0,0);
	
	// Create an array to hold the collision map...
	int collisionMap[10][15] = {{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{0,0,0,1,0,0,0,0,0,0,0,1,0,0,0},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,1,1,1,1,1,1,0,1,1,1,1,1,1,1}};
	
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
    
    // Create an array to hold the emitter map
    int particleMap[10][15] = { {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
    
    // Lava Emitters
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"LavaBubbles" ofType:@"sks"];
    
    for (int xGrid = 0; xGrid < (kMapHorizontalSize / kGridSquareSize); xGrid++)
    {
        for (int yGrid = 0; yGrid < (kMapVerticalSize / kGridSquareSize); yGrid++)
        {
            // If there should be a collision block... add one
            if (particleMap[yGrid][xGrid] == 1)
            {
                CGSize blockSize = CGSizeMake(kGridSquareSize, kGridSquareSize);
                CGPoint blockPosition = CGPointMake((xGrid+1) * kGridSquareSize - kGridSquareSize / 2,
                                                    ((kMapVerticalSize / kGridSquareSize) - yGrid) * kGridSquareSize - kGridSquareSize / 2);
                SKEmitterNode *spark = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
                spark.name = @"Lava";
                spark.zPosition = 12.0;
                spark.position = blockPosition;
                [self addChild:spark];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
