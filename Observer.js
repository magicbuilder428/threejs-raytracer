
/* global THREE */
class Observer extends THREE.Camera {
  constructor() {
    super()
    // sets initial values
    this.time = 0
    
    this.velocity = new THREE.Vector3()
    
    // for orbit
    this.theta = 0
    this.angularVelocity = 0
    this.maxAngularVelocity = 0
    

    this.position.set(0,0,1)
  
    this.moving = false
  }
  
  update(delta){
    // time dilation
    this.delta = delta
  
    
    this.theta += this.angularVelocity*this.delta
    let cos = Math.cos(this.theta)
    let sin = Math.sin(this.theta)
    
    this.position.set(this.r*sin, 0, this.r*cos)
    this.velocity.set(cos*this.angularVelocity, 0, -sin*this.angularVelocity) 
    
    if (this.moving){
      // accel
      if (this.angularVelocity < this.maxAngularVelocity)
        this.angularVelocity += this.delta/this.r        
      else
        this.angularVelocity = this.maxAngularVelocity
      
    } else { 
      // deccel
      
      if (this.angularVelocity > 0.0)
        this.angularVelocity -= this.delta/this.r
      else 
        this.angularVeloicty = 0
      
    }

    this.time += this.delta
  }
  
  // sets position, r vector, direction
  set distance(r){
    this.r = r
    
    // w
    this.maxAngularVelocity = 1/Math.sqrt(2.0*(r-1.0))/r
    // p
    this.position.normalize().multiplyScalar(r)
  }
}