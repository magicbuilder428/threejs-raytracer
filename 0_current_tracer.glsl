#define PI 3.141592653589793238462643383279
#define ROT_Y(a) mat3(1, 0, 0, 0, cos(a), sin(a), 0, -sin(a), cos(a))
#define DEG_TO_RAD (PI/180.0)

#define STEP 0.1
#define NITER 100
#define SPEED 1


uniform float time;
uniform vec2 resolution;

uniform vec3 cam_pos;
uniform vec3 cam_dir;
uniform vec3 cam_up;
float fov;

uniform sampler2D bg_texture;
mat3 BG_COORDS = ROT_Y(45.0 * DEG_TO_RAD);

// helper functions
vec3 getPixelPos(vec3 cam_pos, vec3 cam_dir, vec3 cam_up, float fov){
  
  
}

vec2 squareFrame(vec2 screen_size){
  vec2 position = 2.0 * (gl_FragCoord.xy / screen_size.xy) - 1.0;
  return position;
}

vec2 sphereMap(vec3 p){
  return vec2(atan(p.x,p.y)/PI*0.5+0.5, asin(p.z)/PI+0.5);
}



void main()	{
  vec3 cameraPosition = vec3(0.0, 0.0, 7.0);
  vec3 cameraDirection = normalize(vec3(0.0, 0.0, -1.0));
  vec3 cameraUp = vec3(0.0, 1.0, 0.0);
  float hfov = fov / 2. * DEG_TO_RAD;
  float ulen = tan(hfov);
  float vfov = hfov* resolution.y/resolution.x;
  float vlen = tan(vfov);
  
  
  vec2 uv = squareFrame(resolution);
  // generate ray
  vec3 nright = normalize(cross(cameraUp, cameraDirection));
  vec3 pixelPos = cameraPosition + cameraDirection +
                 nright*uv.x*ulen + cameraUp*uv.y*vlen;
  vec3 rayDirection = normalize(pixelPos - cameraPosition);

  // initial color
  vec4 color = vec4(0.0,0.0,0.0,1.0);

  

  // geodesic by leapfrog integration
  vec3 point = cameraPosition;
  vec3 velocity = rayDirection;
  vec3 c = cross(point,velocity);
  float h2 = normalize(dot(c,c));
  
  vec3 oldPoint; 
  float pointsqr;
  for (int i=0; i<NITER;i++){ 
    oldPoint = point; // for finding intersection
    point += velocity * STEP;
    vec3 accel = -1.5 * h2 * point / pow(dot(point,point),2.5);
    velocity += accel * STEP;    
    
     pointsqr = dot(point,point);
    if (pointsqr < 1.) break; // ray is lost at rs
  }
  
  vec2 tex_coord = sphereMap(normalize(point-oldPoint) * BG_COORDS);
  color += texture2D(bg_texture, tex_coord);
  
  
 
  float oldpointsqr = dot(oldPoint,oldPoint);
  
  bool horizonMask = pointsqr < 1. && oldpointsqr > 1.; // intersecting eventhorizon
  // does it enter event horizon?
  if (horizonMask) {
    float lambda = 1. - ((1.-oldpointsqr)/((pointsqr - oldpointsqr)));
    //vec3 colPoint = lambda * point + (1-lambda)*oldPoint; // for drawing grid
    
    color = vec4(0.,0.,0.,1.0);
  
  }
  

  gl_FragColor = color;
  //color intesection
  
}