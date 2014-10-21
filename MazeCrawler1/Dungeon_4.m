//
//  Dungeon_4.m
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "Dungeon_4.h"

@implementation Dungeon_4

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor blueColor];
    
    // Background
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_4"];
    background.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
    [self addChild:background];
	
	// Add shadow layer on top of everything
	SKSpriteNode *shadowLayer = [SKSpriteNode spriteNodeWithImageNamed:@"BlockDoomDungeon_4_Shadow"];
	shadowLayer.zPosition = 10;
	shadowLayer.position = CGPointMake(kMapHorizontalSize / 2, kMapVerticalSize / 2);
	[self addChild:shadowLayer];
	
	// Initialize the Physics world
	self.physicsWorld.gravity = CGVectorMake(0,0);
	
	// Create an array to hold the collision map...
	int collisionMap[10][15] = {{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
								{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1}};
	
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
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
