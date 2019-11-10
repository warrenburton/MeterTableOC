//
//  MeterTableOC.m
//


#import "MeterTableOC.h"

float inMinDecibels = -80.0;
size_t inTableSize = 400;
float inRoot = 2.0;


@implementation MeterTableOC

-(double)dbToAmp:(double)inDb
{
	return pow(10.0, 0.05 * inDb);
}


-(void)setupWithMinDB:(float)minDB tableSize:(size_t)inTableSize root:(float)aRoot{
    
    mMinDecibels = minDB;
    mDecibelResolution = mMinDecibels / (inTableSize - 1); 
    mScaleFactor = 1.0 / mDecibelResolution;
    

    NSAssert((inMinDecibels <= 0.0),@"MeterTable inMinDecibels must be negative");
    
    mTable = [NSMutableArray arrayWithCapacity:inTableSize];
    
    double minAmp = [self dbToAmp:inMinDecibels];
    double ampRange = 1.0 - minAmp;
    double invAmpRange = 1.0 / ampRange;
    
    double rroot = 1.0 / aRoot;
    for (size_t i = 0; i < inTableSize; ++i) {
        double decibels = i * mDecibelResolution;
        double amp = [self dbToAmp:decibels];
        double adjAmp = (amp - minAmp) * invAmpRange;
        [mTable addObject:[NSNumber numberWithFloat:pow(adjAmp, rroot)]];
    }
}



-(id)initWithMinDB:(float)minDB tableSize:(size_t)aTableSize root:(float)aRoot
{
    
    self = [super init];
    if (self) {
        [self setupWithMinDB:minDB tableSize:aTableSize root:aRoot];
    }
    return self;
    
}

-(id)initWithMinDB:(float)minDB
{
    self = [super init];
    if (self) {
        [self setupWithMinDB:minDB tableSize:inTableSize root:inRoot];
    }
    return self;

}

-(id)init{
    self = [super init];
    if (self) {
        [self setupWithMinDB:inMinDecibels tableSize:inTableSize root:inRoot];
    }
    return self;
}


-(float)valueAt:(float)inDecibels
{
    if (inDecibels < mMinDecibels) return  0.0;
    if (inDecibels >= 0.0) return 1.0;
    int index = (int)(inDecibels * mScaleFactor);
    if (index < mTable.count) {
        return [[mTable objectAtIndex:index] floatValue];
    }
    return 1.0;
    
}


@end
