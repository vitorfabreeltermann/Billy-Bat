#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "glass.inc"
#include "stones.inc"    
#include "skies.inc"     
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

//luz geral
light_source { <-300, 300, -300> color rgb <0.3, 0.3, 0.3> shadowless}

// chão
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.035;  
#declare RasterHalfLineZ = 0.035; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<0.07,0.07,0.07,0>*0.6]
                          [0+HLine color rgbt<0.07,0.07,0.07,0>*0.6]
                          [0+HLine color rgbt<0.07,0.07,0.07,1>]
                          [1-HLine color rgbt<0.07,0.07,0.07,1>]
                          [1-HLine color rgbt<0.07,0.07,0.07,0>*0.6]
                          [1.000   color rgbt<0.07,0.07,0.07,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture {
                  pigment{color rgb <0,0.09,0.07>}
                  finish {ambient 0.45 diffuse 0.85
                    specular 0.1
                    roughness 0.5
                    reflection 0.01}}
                  normal {wrinkles 0.2
                    scale 0.1}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
        
        rotate y*60
}



 
camera{
    location <0, 3, -20>
    look_at <0, 3, 0>
}    


//holofote
union{
    difference{
        cylinder {
           <0, 3, 0>,     // Center of one end
           <0, 3, 10>,     // Center of other end
           2.51            // Radius
        }
        cylinder {
            <0, 3, 1>,     // Center of one end
            <0, 3, 11>,     // Center of other end
            2.5            // Radius
        }
        texture {
            Metal
            finish {
                phong 5 phong_size 300
                reflection 1
            }
        }
    }
    
    cylinder {
        <0, 3, 10>,     // Center of one end
        <0, 3, 11>,     // Center of other end
        2.51           // Radius
        interior {
            caustics 2.0
            ior 3.5
        }
        texture {
            T_Glass4
            pigment {color White filter 0.85}
            finish {
                phong 2 phong_size 100
                reflection 0.30
            }
        }
    }
    
    sphere{
        <0, 3, 2>,2
        interior {
             caustics 2.0
             ior 3.5
        }
        texture {
            T_Glass4
            pigment {color White filter 0.85}
            finish {
                phong 2 phong_size 100
                reflection 0.30
            }
        } 
    }
    
    //luz
    light_source { <0, 3, 2> color rgb <4.4, 4.4, 2.2>
        fade_distance 5
        fade_power 0.5
    }
    rotate y*20 
    rotate x*17
    translate x*-15
    translate y*7
    translate z*-40
    
}       
  
//céu
sky_sphere {
    pigment {
        crackle form <1,1,0>
        color_map {
            [.4 rgb 10]
            [.5 rgb <0, 0, 0.005>]
        }
        scale .002
    }
}
//prédio da frente
union{
                            
    box {
       <-1, 0, 100>,  // Near lower left corner
       <100,0.55,-0.4>   // Far upper right corner
       
       texture {pigment{color rgb<0.08, 0.08, 0.08> }
             normal {
                wrinkles 0.8
                scale 0.3
             }          
       }
        
    }
        
    box {
        <-0.95, 0, 99.95>,  // Near lower left corner
        <99.95, 100,-0.35>   // Far upper right corner
        
        texture {
            pigment { brick color rgb<0.02, 0.02, 0.02>, rgb<0.085, 0.03, 0.025>
                brick_size <3, 1, 2> mortar 0.05
            }
            finish {
                diffuse 1
            }
            normal {
                wrinkles 0.5
                scale 0.3
            }
            scale 0.5
        }
    }
    rotate y*40
    translate x*-6
    translate z*5
}

//prédio de trás da direita
union{

    difference{
        box {
            <40, 0, 100>,  // Near lower left corner
            <76, 100, -0.35>   // Far upper right corner
        }
         
        //buracos janelas
        #for (CntrX, 0, 3, 1)
            #for (CntrY, 0, 7, 1)
                box {
                    <44+(CntrX * 8), 83-(CntrY * 11), 5>,
                    <48+(CntrX * 8), 90-(CntrY * 11), -1>
                }
            #end
        #end
        
        
        texture {
            pigment { color rgb<0.055, 0.01, 0.015>}
            finish {
                diffuse 1
            }
            normal {
                wrinkles 0.5
                scale 0.3
            }
            scale 0.5
        }
    }
    
    //*********************************************
    #for (CntrX, 0, 3, 1)
        #for (CntrY, 0, 7, 1)
            //vidros janelas
            #if (!((CntrX = 2 & CntrY = 1) | (CntrX = 1 & CntrY = 2) | (CntrX = 3 & CntrY = 2) | (CntrX = 1 & CntrY = 5)
                    | (CntrX = 2 & CntrY = 5) | (CntrX = 3 & CntrY = 5) | (CntrX = 1 & CntrY = 6) | (CntrX = 2 & CntrY = 6)
                    | (CntrX = 3 & CntrY = 6) | (CntrX = 0 & CntrY = 7) | (CntrX = 2 & CntrY = 7)))
                light_source { <46+(CntrX * 8), 87.5-(CntrY * 11), 0> color rgb <1, 1, -10>
                    fade_distance 10
                    fade_power 50
                    jitter
                    looks_like{
                        box{
                            <-2, -4.5, 0>,
                            <2, 4.5, -0.35>
                            interior {
                                caustics 6.0
                                ior 3
                            }
                            texture {
                                T_Glass4
                                pigment {color rgb <1, 1, 1> filter 0.9}
                                finish {
                                    phong 1 phong_size 3
                                    reflection 0.01
                                }
                            }
                        }
                    }
                }
            #else
                box{
                    <44+(CntrX * 8), 83-(CntrY * 11), 0>,
                    <48+(CntrX * 8), 90-(CntrY * 11), -0.35>
                    interior {
                        caustics 6.0
                        ior 3
                    }
                    texture {
                        T_Glass4
                        pigment {color rgb <1, 1, 1> filter 0.95}
                        finish {
                            phong 1 phong_size 3
                            reflection 0.01
                        }
                    }
                } 
            #end    
        #end
    #end

    rotate y*-50
    translate z*300
    translate x*-240
}

//prédio de tras roxo
union{

    difference{
        box {
            <50, 85, 25>,  // Near lower left corner
            <55, 130, -0.35>   // Far upper right corner
        }
      
        }
        
        texture {
            pigment { color rgb <0.54,0.16,0.88>}               // Corzinha do prédio
            finish {
                diffuse 1
            }
            normal {
                wrinkles 0.5
                scale 0.3
            }
            scale 0.5
        } 
    rotate y*+82
    translate z*340
    translate x*-180
}

//prédio de tras roxo TOPO
union{

    difference{
        box {
            <18, 140, 20>,  // Near lower left corner
            <30, 160, -0.35>   // Far upper right corner
        }
      
        }
        
        texture {
            pigment { color rgb <0.54,0.16,0.88>}               // Corzinha do prédio
            finish {
                diffuse 1
            }
            normal {
                wrinkles 0.5
                scale 0.3
            }
            scale 0.5
        } 
    rotate y*+82
    translate z*340
    translate x*-190
}    

//bolas de luz
light_source
{ <-30,5, 70> color rgb <1, 1, 0.5>
    fade_distance 10
    fade_power 40
    looks_like
    {   
        sphere
        { <0,0,0>,5
            pigment { rgb <1, 1, 1> filter 0.5}
            hollow
            interior { 
                media {
                    scattering { 1, 0.07 extinction 0.01 }
                    samples 30,100
                }
            }
        }
        
    }
}
