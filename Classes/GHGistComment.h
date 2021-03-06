#import <Foundation/Foundation.h>
#import "GHResource.h"
#import "GHComment.h"


@class GHGist, GHUser;

@interface GHGistComment : GHComment

@property(nonatomic,strong)GHGist *gist;

+ (id)commentWithGist:(GHGist *)theGist andDictionary:(NSDictionary *)theDict;
+ (id)commentWithGist:(GHGist *)theGist;
- (id)initWithGist:(GHGist *)theGist andDictionary:(NSDictionary *)theDict;
- (id)initWithGist:(GHGist *)theGist;

@end