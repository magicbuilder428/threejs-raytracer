#define PI 3.141592653589793238462643383279
#define ROT_Y(a) mat3(0, cos(a), sin(a), 1, 0, 0, 0, sin(a), -cos(a))
#define DEG_TO_RAD (PI/180.0)
#define STEP 0.02
#define NITER 50
#define SPEED 1


uniform float time;
uniform vec2 resolution;

uniform sampler2D bg_texture;
mat3 BG_COORDS = ROT_Y(45.0 * DEG_TO_RAD);

const float FOV_ANGLE_DEG = 90.0;
float FOV_MULT = 1.0 / tan(DEG_TO_RAD * FOV_ANGLE_DEG*0.5);

// helper functions
vec4 blendColors(vec4 cb, vec4 ca){
 return ca+cb*(cb.w*(1.0-ca.w)); 
}

vec2 squareFrame(vec2 screenSize){
  
  vec2 position = 2.0 * (gl_FragCoord.xy / screenSize.xy) - 1.0;
  position.x *= screenSize.x / screenSize.y;
  return position;
}

vec2 sphereMap(vec3 p){
  return vec2(atan(p.x,p.y)/PI*0.5+0.5, asin(p.z)/PI+0.5);
}



void main()	{
  vec3 cameraPosition = vec3(0.0, 0.0, 10.0);
  vec3 cameraDirection = vec3(0.0, 0.0, -1.0);
  vec3 cameraUp = vec3(0.0, 1.0, 0.0);
  float fov = 90.0;
  float fovx = PI * fov / 360.0;
  
  // camera variables 
  float fovy = fovx * resolution.y/resolution.x;
  float ulen = tan(fovx);
  float vlen = tan(fovy);
  
  
  vec2 uv = squareFrame(resolution);
  // generate ray
  vec3 nright = normalize(cross(cameraUp, cameraDirection));
  vec3 pixelPos = cameraPosition + cameraDirection +
                 nright*uv.x*ulen + cameraUp*uv.y*vlen;
  vec3 rayDirection = normalize(pixelPos - cameraPosition);

  // initial color
  vec4 color = vec4(0.2,0.0,0.3,0.4);

  /*
  // geodesic by leapfrog integration
  vec3 point = cameraPosition;
  vec3 velocity = rayDirection;
  vec3 c = cross(point,velocity);
  float h2 = normalize(dot(c,c));
  
  vec3 oldPoint = point;
  for (int i=0; i<NITER;i++){ 
    oldPoint = point;
    
    point += velocity * STEP;
    vec3 accel = -1.5 * h2 * point / pow(dot(point,point),2.5);
    velocity += accel * STEP;    
  }
  
  pointsqr = sqrnorm(point)
  oldpointsqr
  */
  
  gl_FragColor = color;
  //color intesection
  
}