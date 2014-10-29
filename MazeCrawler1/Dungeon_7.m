//
//  Dungeon_7.m
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "Dungeon_7.h"

@implementation Dungeon_7

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor blueColor];
    
    // Background
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_7"];
    background.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
    [self addChild:background];
    // Add shadow layer on top of everything
    SKSpriteNode *shadowLayer = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_7_Shadow"];
    shadowLayer.zPosition = 10;
    shadowLayer.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
    [self addChild:shadowLayer];

	// Initialize the Physics world
	self.physicsWorld.gravity = CGVectorMake(0,0);
	
	// Create an array to hold the collision map...
	int collisionMap[10][15] = {{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,1,0,0,0,0,4,0,0,1,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
								{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
	
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
			if (collisionMap[yGrid][xGrid] == 2*kSceneSlideDirectionDown)
			{
				CGPoint a = CGPointMake((xGrid) * kGridSquareSize, ((kMapVerticalSize / kGridSquareSize) - (yGrid + 1)) * kGridSquareSize);
				CGPoint b = CGPointMake((xGrid+1) * kGridSquareSize, ((kMapVerticalSize / kGridSquareSize) - (yGrid + 1)) * kGridSquareSize);
				
				SKPhysicsBody *newBlock = [SKPhysicsBody bodyWithEdgeFromPoint:a toPoint:b];
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
                                {0,0,0,2,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,2,0,0},
                                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
    
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

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
