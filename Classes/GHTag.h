#import <Foundation/Foundation.h>
#import "GHResource.h"


@class GHRepository, GHCommit;

@interface GHTag : GHResource

@property(nonatomic,strong)GHRepository *repository;
@property(nonatomic,strong)GHCommit *commit;
@property(nonatomic,strong)NSString *sha;
@property(nonatomic,strong)NSString *tag;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *taggerName;
@property(nonatomic,strong)NSString *taggerEmail;
@property(nonatomic,strong)NSDate *taggerDate;

+ (id)tagWithRepo:(GHRepository *)theRepo andSha:(NSString *)theSha;
- (id)initWithRepo:(GHRepository *)theRepo andSha:(NSString *)theSha;

@end