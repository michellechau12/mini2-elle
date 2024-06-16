//
//  GameScene.swift
//  Mini2_Test
//
//  Created by Michelle Chau on 11/06/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        if let tileMap = childNode(withName: "Maze") as? SKTileMapNode {
            giveMapPhysicsBody(map: tileMap)
        }
        setupPlayer()
    }
    
    //Add physic body to map
    func giveMapPhysicsBody(map: SKTileMapNode) {
        let tileMap = map // the tile map to be given physics body
        
        let tileSize = tileMap.tileSize // the size of each tile map
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width // half width of tile map
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height // half height of tile map
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    
                    let isEdgeTile = tileDefinition.userData?["AddBody"] as? Int
                    if isEdgeTile == 1 {
                        let tileArray = tileDefinition.textures //get the tile textures in array
                        let tileTexture = tileArray[0] //get the first texture
                        let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width/2)
                        let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height/2)
                        let tileNode = SKNode()
                        
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (tileTexture.size().width), height: tileTexture.size().height))
                        tileNode.physicsBody?.affectedByGravity = false
                        tileNode.physicsBody?.allowsRotation = false
                        tileNode.physicsBody?.restitution = 0
                        tileNode.physicsBody?.isDynamic = false
                        tileNode.physicsBody?.friction = 20.0
                        tileNode.physicsBody?.mass = 30.0
                        tileNode.physicsBody?.contactTestBitMask = 0
                        //                        tileNode.physicsBody?.fieldBitMask = 0
                        //                        tileNode.physicsBody?.collisionBitMask = 0
                        
                        tileMap.addChild(tileNode)
                    }
                    
                }
            }
        }
    }
    
    // Setup player
    func setupPlayer() {
        let playerCatNode = SKSpriteNode(imageNamed: "player_cat")
        
        playerCatNode.size = CGSize(width: 50, height: 50)
        playerCatNode.position = CGPoint(x: -160, y: size.height-550)
        playerCatNode.zPosition = 1
        
        playerCatNode.physicsBody = SKPhysicsBody(rectangleOf: playerCatNode.size)
        playerCatNode.physicsBody?.isDynamic = true
        
        addChild(playerCatNode)
    }
    
}

