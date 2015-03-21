// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko, Yaroslav Bulda
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <QuartzCore/QuartzCore.h>
#import "UIView+CKFrame.h"


@implementation UIView (CKFrame)

// -------------------------------------------------------------------------------

- (CGPoint) frameOrigin {
    return self.frame.origin;
}

// -------------------------------------------------------------------------------

- (void) setFrameOrigin:(CGPoint) newOrigin {
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

// -------------------------------------------------------------------------------

- (CGSize) frameSize {
    return self.frame.size;
}

// -------------------------------------------------------------------------------

- (void) setFrameSize:(CGSize) newSize {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newSize.width, newSize.height);
}

// -------------------------------------------------------------------------------

- (CGFloat) frameX {
    return self.frame.origin.x;
}

// -------------------------------------------------------------------------------

- (void) setFrameX:(CGFloat) newX {
    self.frame = CGRectMake(newX, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

// -------------------------------------------------------------------------------

- (CGFloat)frameY {
    return self.frame.origin.y;
}

// -------------------------------------------------------------------------------

- (void) setFrameY:(CGFloat) newY {
    self.frame = CGRectMake(self.frame.origin.x, newY,
                            self.frame.size.width, self.frame.size.height);
}

// -------------------------------------------------------------------------------

- (CGFloat) frameRight {
    return self.frame.origin.x + self.frame.size.width;
}

// -------------------------------------------------------------------------------

- (void) setFrameRight:(CGFloat) newRight {
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y,
                            self.frame.size.width, self.frame.size.height);
}

// -------------------------------------------------------------------------------

- (CGFloat) frameBottom {
    return self.frame.origin.y + self.frame.size.height;
}

// -------------------------------------------------------------------------------

- (void) setFrameBottom:(CGFloat) newBottom {
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height,
                            self.frame.size.width, self.frame.size.height);
}

// -------------------------------------------------------------------------------

- (CGFloat) frameWidth {
    return self.frame.size.width;
}

// -------------------------------------------------------------------------------

- (void) setFrameWidth:(CGFloat) newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            newWidth, self.frame.size.height);
}

// -------------------------------------------------------------------------------

- (CGFloat) frameHeight {
    return self.frame.size.height;
}

// -------------------------------------------------------------------------------

- (void) setFrameHeight:(CGFloat) newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                            self.frame.size.width, newHeight);
}

// -------------------------------------------------------------------------------

@end
