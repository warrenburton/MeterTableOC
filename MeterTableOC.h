//
//  MeterTableOC.h
//  genome
//
//  Created by Warren Burton on 06/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterTableOC : NSObject {
    float	mMinDecibels;
	float	mDecibelResolution;
	float	mScaleFactor;
	NSMutableArray	*mTable;
}

-(id)initWithMinDB:(float)minDB;

-(float)valueAt:(float)inDecibels;


@end
