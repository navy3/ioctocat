#import "GHGistComment.h"
#import "GHGist.h"
#import "iOctocat.h"


@implementation GHGistComment

+ (id)commentWithGist:(GHGist *)theGist andDictionary:(NSDictionary *)theDict {
	return [[self.class alloc] initWithGist:theGist andDictionary:theDict];
}

+ (id)commentWithGist:(GHGist *)theGist {
	return [[self.class alloc] initWithGist:theGist];
}

- (id)initWithGist:(GHGist *)theGist andDictionary:(NSDictionary *)theDict {
	self = [self initWithGist:theGist];
	if (self) {
		NSString *createdAt = [theDict valueForKey:@"created_at"];
		NSString *updatedAt = [theDict valueForKey:@"updated_at"];
		NSDictionary *userDict = [theDict valueForKey:@"user"];
		[self setUserWithValues:userDict];
		self.body = [theDict valueForKey:@"body"];
		self.created = [iOctocat parseDate:createdAt];
		self.updated = [iOctocat parseDate:updatedAt];
	}
	return self;
}

- (id)initWithGist:(GHGist *)theGist {
	self = [super init];
	if (self) {
		self.gist = theGist;
	}
	return self;
}

#pragma mark Saving

- (void)saveData {
	NSDictionary *values = [NSDictionary dictionaryWithObject:self.body forKey:@"body"];
	NSString *path = [NSString stringWithFormat:kGistCommentsFormat, self.gist.gistId];
	[self saveValues:values withPath:path andMethod:@"POST" useResult:nil];
}

@end