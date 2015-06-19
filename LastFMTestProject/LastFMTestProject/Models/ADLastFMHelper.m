
#import "ADLastFMHelper.h"

@implementation ADLastFMHelper

#pragma mark - utility

// image array: array of dictionaries containing #text and size attributes
// imageThumbURL: will be set with proper URL for thumb
// imageURL: will be set with proper URL for image
void ADSetImageURLsForThumbAndImage(NSArray *imageArray, NSString **imageThumbURL, NSString **imageURL){
  NSMutableDictionary *newAlbumDict = [NSMutableDictionary dictionaryWithCapacity:[imageArray count]];
  for (NSDictionary *imgDict in imageArray){
    [newAlbumDict setObject:[imgDict objectForKey:@"#text"] forKey:[imgDict objectForKey:@"size"]];
  }
  NSString *largestImageURL = nil;
  NSString *currentImageURL = nil;
  largestImageURL = [newAlbumDict objectForKey:@"small"];
  currentImageURL = [newAlbumDict objectForKey:@"medium"];
  if (currentImageURL != nil)
     largestImageURL = currentImageURL;
  currentImageURL = [newAlbumDict objectForKey:@"large"];
  if (currentImageURL != nil)
    largestImageURL = currentImageURL;
  *imageThumbURL = largestImageURL; // set imageThumbURL with large image (or medium or small)
  currentImageURL = [newAlbumDict objectForKey:@"extralarge"];
  if (currentImageURL != nil)
    largestImageURL = currentImageURL;
  /*currentImageURL = [newAlbumDict objectForKey:@"mega"];
  if (currentImageURL != nil)
    largestImageURL = currentImageURL;*/
  *imageURL = largestImageURL; // set imageURL with mega image (or extralarge or large etc.)
}

@end
