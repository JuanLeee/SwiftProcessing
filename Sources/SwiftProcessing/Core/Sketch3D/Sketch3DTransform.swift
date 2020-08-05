public extension Sketch {
    
    func translationNode(_ vector: SCNVector3,_ property: String) {
        
        let lastNode = currentTransformationNode
        
        if lastNode.hasNoShapeNodes() {
            
            switch property {
                
            case "position":
                lastNode.position.add(vector)
                
            case "rotation":
                lastNode.eulerAngles.add(vector)
                
            default:
                print("Wrong translation property key word")
                
            }
                        
        } else if lastNode.hasAvailableTransitionNodes() {
            
            let nextNode = lastNode.getNextAvailableTransitionNode()
            
            switch property {
                
            case "position":
                nextNode.position = vector
                nextNode.eulerAngles = SCNVector3(0,0,0)
                
            case "rotation":
                nextNode.eulerAngles = vector
                nextNode.position = SCNVector3(0,0,0)
                
            default:
                print("Wrong translation property key word")
                
            }
            
            self.stackOfTransformationNodes.append(nextNode)
            self.currentTransformationNode = nextNode
                        
        } else {
            
            let newTransformationNode: TransitionSCNNode = TransitionSCNNode()
            
            lastNode.addChildNode(newTransformationNode)
            
            switch property {
            case "position":
                newTransformationNode.position = vector
                
            case "rotation":
                newTransformationNode.eulerAngles = vector
            default:
                print("Wrong translation property key word")
            }
            
            self.stackOfTransformationNodes.append(newTransformationNode)
            self.currentTransformationNode = newTransformationNode

            
        }

    }
    
    func translate(_ x: Float, _ y: Float, _ z: Float){
        
        let tempPosition: SCNVector3 = SCNVector3(x,y,z)
        
        self.translationNode(tempPosition, "position")
        
        drawFramePosition += simd_float4(x, y, z, 0)
    }
    
    func rotate(_ x: Float, _ y: Float, _ z: Float){
        
        let tempRotation: SCNVector3 = SCNVector3(x,y,z)
        
        self.translationNode(tempRotation, "rotation")
        
        drawFrameRotation += simd_float4(x,y,z,0)
    }
    
    func rotateX(_ r: Float){
        rotate(r, 0, 0)
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func rotateY(_ r: Float){
        rotate(0, r, 0)
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
    func rotateZ(_ r: Float){
        rotate(0, 0, r)
        drawFramePosition += simd_float4(0, 0, 0, r)
    }
    
}