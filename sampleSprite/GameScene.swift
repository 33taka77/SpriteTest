//
//  GameScene.swift
//  sampleSprite
//
//  Created by Aizawa Takashi on 2015/05/18.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var colume:CGFloat = 2
    var spaceInItems:CGFloat = 0
    var spaceAround:CGFloat = 0
    let widthAjust:CGFloat = 25
    let heightAjust:CGFloat = 30
    
    private var imageManager:ImageManager!
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        imageManager = AssetManager.sharedInstance
        imageManager.setupData()
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        let numOfImage = imageManager.getImageCount(0)
        let drawWidthofImage:CGFloat = (self.view!.frame.width - spaceAround*2 - spaceInItems*(colume-1))/colume
        var positionArray:[CGPoint] = []
        for var j = 0; j < Int(colume); j++ {
            let position:CGPoint = CGPointMake(CGFloat(j)*drawWidthofImage+spaceAround, 0+spaceAround)
            positionArray.append(position)
        }

        /*
        for var i = 0; i < numOfImage; i++ {
            let index = NSIndexPath(forRow: i, inSection: 0)
            let imageObject:ImageObject = imageManager.getImageObjectIndexAt(index)!
            let size:CGSize = imageObject.getSize()
            let drawHeightOfImage = drawWidthofImage * size.height/size.width
            imageObject.getThumbnail({ (image) -> Void in
                let imageData:UIImage = image as UIImage
                let size:CGSize = imageData.size
                let scale:CGFloat = drawWidthofImage / size.width
                let imageTexture = SKTexture(image: imageData)
                let sprite = SKSpriteNode(texture: imageTexture)
                sprite.xScale = scale
                sprite.yScale = scale
                let n = i % Int(self.colume)
                let point:CGPoint = positionArray[n] as CGPoint
                let newX = point.x + drawWidthofImage/2
                let newY = point.y + drawHeightOfImage/2
                let newPoint:CGPoint = CGPoint(x: newX, y: newY)
                let spritePosition = self.convertPointFromView( newPoint )
                sprite.position = spritePosition
                //sprite.anchorPoint = CGPoint(x: 0, y: 0)
                let pos:CGPoint = positionArray[n] as CGPoint
                let height = pos.y + self.spaceInItems + drawHeightOfImage
                positionArray[n] = CGPointMake(pos.x, height)
                self.addChild(sprite)

            })
            
        }
        */
        var nextPosition:CGPoint = CGPoint(x: 0, y: 0)
        for var i = 0; i < numOfImage; i++ {
            let index = NSIndexPath(forRow: 1, inSection: 0)
            let imageObject:ImageObject = imageManager.getImageObjectIndexAt(index)!
            imageObject.getThumbnail({ (image) -> Void in
                //let imageData:UIImage = image as UIImage
                let imageData:UIImage = UIImage(named: "IMG_0469.jpg")!
                let imageTexture = SKTexture(image: imageData)
                let sprite = SKSpriteNode(texture: imageTexture)
                let widthOfImage:CGFloat = (self.view!.frame.width - self.spaceAround*2 - self.spaceInItems*(self.colume-1))/self.colume
                let size:CGSize = imageData.size
                let scale:CGFloat = widthOfImage / size.width
                sprite.xScale = scale
                sprite.yScale = scale
                let spriteSize:CGSize = sprite.size
                let heightOfImage = size.height*scale
                //let position:CGPoint = CGPoint(x: nextPosition.x+widthOfImage/2, y: nextPosition.y+heightOfImage/2)
                let position:CGPoint = nextPosition//CGPoint(x: 0, y: 0)
                sprite.anchorPoint = CGPoint(x: 0, y: 1)
                let spritePosition = self.convertPointFromView( position )
                sprite.position = spritePosition
                if i % Int(self.colume) == 0 && i != 0 {
                    nextPosition = CGPoint( x: 0, y: position.y+spriteSize.height-self.heightAjust )
                }else{
                    nextPosition = CGPoint( x: position.x + spriteSize.width-self.widthAjust, y: position.y )
                }
                self.addChild(sprite)
            })
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
