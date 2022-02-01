//
//  GameScene.swift
//  project_20
//
//  Created by Bhavin Kapadia on 2022-01-30.
//

import SpriteKit

class GameScene: SKScene {
    var gameTimer:Timer?
    var fireWorks = [SKNode]()
    
    let leftEdge = -22
    let bottomEdge = -22
    let rightEdge = 1024 + 22
    
    var score = 0 {
        didSet {
            //code here
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
       
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
    }
    
    
    func createFiework(xMovement: CGFloat, x:Int, y:Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let fireWork = SKSpriteNode(imageNamed: "rocket")
        fireWork.colorBlendFactor = 1
        fireWork.name = "firework"
        node.addChild(fireWork)
        
        switch Int.random(in: 0...2) {
        case 0:
            fireWork.color = .cyan
        case 1:
            fireWork.color = .green
        default:
            fireWork.color = .red
        }
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        node.run(move)
        
        
        if let emitter = SKEmitterNode(fileNamed: "fuse") {
            emitter.position = CGPoint(x: 0, y: -22)
            node.addChild(emitter)
        }
        
        fireWorks.append(node)
        addChild(node)
        
        
    }
    
    
    @objc func launchFireworks() {
        let movemntAmount: CGFloat = 1800
        
        switch Int.random(in: 0...3) {
        case 0:
            // fire five straight up
            createFiework(xMovement: 0, x: 512, y: bottomEdge)
            createFiework(xMovement: 0, x: 512 - 200, y: bottomEdge)
            createFiework(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFiework(xMovement: 0, x: 512 + 100, y: bottomEdge)
            createFiework(xMovement: 0, x: 512 + 200, y: bottomEdge)

        case 1:
            // fire five in a fan
            createFiework(xMovement: 0, x: 512, y: bottomEdge)
            createFiework(xMovement: -200, x: 512 - 200, y: bottomEdge)
            createFiework(xMovement: -100, x: 512 - 100, y: bottomEdge)
            createFiework(xMovement: 100, x: 512 + 100, y: bottomEdge)
            createFiework(xMovement: 200, x: 512 + 200, y: bottomEdge)

            

        case 2:
            //fire from left to right
            createFiework(xMovement: movemntAmount, x: leftEdge, y: bottomEdge + 400)
            createFiework(xMovement: movemntAmount, x: leftEdge, y: bottomEdge + 300)
            createFiework(xMovement: movemntAmount, x: leftEdge, y: bottomEdge + 200)
            createFiework(xMovement: movemntAmount, x: leftEdge, y: bottomEdge + 100)
            createFiework(xMovement: movemntAmount, x: leftEdge, y: bottomEdge)

        
        case 3:
            // fire five from right to left
            createFiework(xMovement: -movemntAmount, x: rightEdge, y: bottomEdge + 400)
            createFiework(xMovement: -movemntAmount, x: rightEdge, y: bottomEdge + 300)
            createFiework(xMovement: -movemntAmount, x: rightEdge, y: bottomEdge + 200)
            createFiework(xMovement: -movemntAmount, x: rightEdge, y: bottomEdge + 100)
            createFiework(xMovement: -movemntAmount, x: rightEdge, y: bottomEdge)
        default:
            break
        }
    }
    
    
    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let nodesAtPoint = nodes(at: location)
        
        for case let node as SKSpriteNode in nodesAtPoint {
            guard node.name == "firework" else { continue }
            
            for parent in fireWorks {
                guard let firework = parent.children.first as? SKSpriteNode else { continue }
                if firework.name == "selected" && firework.color != node.color {
                    firework.name == "firework"
                    firework.colorBlendFactor = 1
                }
            }
            
            node.name = "selected"
            node.colorBlendFactor = 0
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        checkTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        checkTouches(touches)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for (index, firework) in fireWorks.enumerated().reversed() {
            if firework.position.y > 900 {
                fireWorks.remove(at: index)
                firework.removeFromParent()
            }
        }
    }
    
    func explode(firework: SKNode) {
        if let emitter = SKEmitterNode(fileNamed: "explode") {
            emitter.position = firework.position
            addChild(emitter)
        }
        
        firework.removeFromParent()
    }
    
    func explodeFireworks() {
        var numExploded = 0
        
        for (index, fireworkContainer) in fireWorks.enumerated().reversed() {
            guard let firework = fireworkContainer.children.first as? SKSpriteNode else { continue }
            if firework.name == "selected" {
                explode(firework: fireworkContainer)
                fireWorks.remove(at: index)
                numExploded += 1
            }
            
            switch numExploded {
            case 0:
                break
            case 1:
                score += 200
            case 2:
                score += 300
            case 3:
                score += 1500
            case 4:
                score += 2500
            default:
                score += 4000
            }
        }
    }
}
