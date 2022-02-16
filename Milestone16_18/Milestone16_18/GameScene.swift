//
//  GameScene.swift
//  Project17
//
//  Created by Bhavin Kapadia on 2022-01-03.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameOver: SKLabelNode!
    var timerCountdown: SKLabelNode!
    var explostion: SKEmitterNode!
    var gameTimer: Timer?
    var isGameOver = false

    var wallShelf1 = SKSpriteNode(imageNamed: "wallShelf")
    var wallShelf2 = SKSpriteNode(imageNamed: "wallShelf")
    var wallShelf3 = SKSpriteNode(imageNamed: "wallShelf")
    var wallShelf4 = SKSpriteNode(imageNamed: "wallShelf")
    var reloadAmmo = SKSpriteNode(imageNamed: "reloadAmmo")
    var scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    var backgroundWall = SKSpriteNode(imageNamed: "backgroundWall")
    var possibleTarget = ["goodTarget", "badTarget"]
    var bulletTotal = 6
    var bulletAdded: Int = 0
    var sprites = [SKSpriteNode]()
    var bulletFiredCount: Int = 0
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        score = 0

        backgroundWall.position = CGPoint.init(x: frame.size.width/1.1, y: frame.size.height/1.1)
        backgroundWall.zPosition = -1
        backgroundWall.isUserInteractionEnabled = false
        addChild(backgroundWall)
        
        wallShelf1.position = CGPoint(x: frame.size.width/2, y: frame.size.height/1.3)
        wallShelf1.size = CGSize(width: 800, height: 100)
        wallShelf1.isUserInteractionEnabled = false
        addChild(wallShelf1)
        
        wallShelf2.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        wallShelf2.size = CGSize(width: 800, height: 100)
        wallShelf2.isUserInteractionEnabled = false
        addChild(wallShelf2)
        
        wallShelf3.position = CGPoint(x: frame.size.width/2, y: frame.size.height/4.3)
        wallShelf3.size = CGSize(width: 800, height: 100)
        wallShelf3.isUserInteractionEnabled = false
        addChild(wallShelf3)
        
        
        wallShelf4.position = CGPoint(x: frame.size.width/1.3, y: frame.size.height/20)
        wallShelf4.size = CGSize(width: 400, height: 50)
        wallShelf4.isUserInteractionEnabled = false
        addChild(wallShelf4)
        
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        reloadAmmo.size = CGSize(width: 50, height: 50)
        reloadAmmo.position = CGPoint(x: frame.size.width/1.6, y: frame.size.height/9)
        reloadAmmo.zPosition = 1
        reloadAmmo.name = "reloadAmmo"
        reloadAmmo.isUserInteractionEnabled = false
        reloadAmmo.isHidden = true
        addChild(reloadAmmo)
        print("\(reloadAmmo.texture!.description)")
        
        
        let sprites = addBulletsAmmoToRackSprite(count: 6)
           for sprite in sprites {
               addChild(sprite)
           }
        
        let wait = SKAction.wait(forDuration: 2, withRange: 2)
        let spawn = SKAction.run {
            self.createTargetRow(start:1100, height:Int(self.frame.size.height/1.13), end: -1200, scale: 1.00)
            self.createTargetRow(start:-10, height:Int(self.frame.size.height/1.62), end: 1200, scale: -1.00)
            self.createTargetRow(start:1100, height:Int(self.frame.size.height/3), end: -1500, scale: 1.00)
        }
        
        let sequence = SKAction.sequence([wait, spawn])
        self.run(SKAction.repeatForever(sequence))
    }
    
    private func addBulletsAmmoToRackSprite(count: Int) -> [SKSpriteNode] {
        reloadAmmo.isHidden = true
        for i in 0..<count {
            let sprite = SKSpriteNode(imageNamed: "ammoBullet")
            sprite.size = CGSize(width: 30, height: 80)
            sprite.isUserInteractionEnabled = false
            sprite.name = "bulletAmmo"
            sprite.isHidden = false
            sprite.position = CGPoint(x: (frame.size.width/1.5) + (50*(CGFloat(i))), y: frame.size.height/8)
            sprites.append(sprite)
        }
        return sprites
    }
    
    private func hideFiredBulletSprite(count: Int) -> [SKSpriteNode] {
        print("hideFiredBulletSprite")
        
        let sprite = childNode(withName: "bulletAmmo")
        for _ in 0..<count {
            sprite?.removeFromParent()
        }
        return sprites
    }
    

    @objc func createTargetRow(start x: Int, height y: Int, end: CGFloat, scale: CGFloat) {
        guard let target = possibleTarget.randomElement() else { return }
        let sprite = SKSpriteNode(imageNamed: target)
        sprite.xScale = scale;
        sprite.zPosition = 1
        sprite.position = CGPoint(x: x, y: y)
        sprite.size = CGSize(width: 100, height: 100)
        sprite.isUserInteractionEnabled = false
        sprite.name = target.description
        addChild(sprite)
        
        let spriteMoveTargets = SKAction.moveBy(x: end, y: 0, duration: 12)
        sprite.run(spriteMoveTargets)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if (node.position.x < -50 || node.position.x > 1200) {
                    node.removeFromParent()
               }
           }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let shotFire = SKEmitterNode(fileNamed: "explosion")!
            let location = touch.location(in: self)
            shotFire.position = location
            bulletFiredCount += 1
            if bulletFiredCount < 6 {
                addChild(shotFire)
                print("bullet count \(bulletFiredCount)")
                reloadAmmo.isHidden = true
            } else {
                print("reload ammos!!")
                reloadAmmo.isHidden = false
            }
        }
        
        
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.location(in: self)
            let nodeAtPoint = self.atPoint(location).name

               if (nodeAtPoint != nil && bulletFiredCount < 7 ) {
                    if nodeAtPoint == "goodTarget" {
                        print("GOOD")
                        self.atPoint(location).removeFromParent()
                        score += 1
                    }
                    if nodeAtPoint == "badTarget" {
                        print("BAD")
                        self.atPoint(location).removeFromParent()
                        score -= 1
                        
                    }
               }
            if nodeAtPoint == "reloadAmmo" {
                bulletFiredCount = 0
                addBulletsAmmoSprite(count: 6)
               print("RELOAD")
            }
        }
        hideFiredBulletSprite(count: bulletFiredCount)
    }
    
    func addBulletsAmmoSprite(count: Int) {
        let sprites = addBulletsAmmoToRackSprite(count: 0)
           for sprite in sprites {
               addChild(sprite)
           }
    }
}
