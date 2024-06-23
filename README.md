## three-js-blackhole

<p align="center">
   <img src="https://i.imgur.com/I6eMiFS.jpg" width="720px"/>
   <br> Screenshot
</p>

My attempt at grokking realtime blackhole ray tracer with an accretion disk around. 
I tried to reproduce [[1]](http://rantonels.github.io/starless/) and [[2]](https://github.com/oseiskar/black-hole).  

I was fascinated by the idea of ray tracing blackhole with now popularized accretion disk around it, So I hopped in.  

```sh
// dev server
pnpm vite dev
```

### Features

- Drag to look around
- Adjustable quality vs performance
- Adjustable bloom effect
- Save to an image
- Physics
  - Lorentz transform
  - Doppler shift
  - Relativistic beaming
  - Accretion disk
  - Background star color from blackbody spectrum (random and trivial velocity for red shift)
  
### TODO

- Add foggy effect

--------------------

## How it was built

There are two parts to implementing this type of project: physics and graphics.

- First, you need to grasp the basics of computer graphics: ray tracing.
  - Find an example that draws a sphere using a shader and learn from it.
  - It helps to think in a perspective of light when playing with ray tracing.
- Try to implement a camera movement inside the shader.
- Now, you want to apply varying degrees of physical phenomena with shader.
- In this case, they are about light and blackhole. There are lots of resources out there to understand them. But remember that you might not understand everything. If you could you'd have a different major.
- Find formulas, try them to better understand.
- Slowly move towards the correct implementation of the formulas

--------------------
