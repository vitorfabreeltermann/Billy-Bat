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

#declare paper = texture {
  pigment { granite
    color_map {
     [0 color rgb <1,0.98,0.95>]
     [0.2 color rgb <1,0.98,0.95>]
     [0.21 color rgb <1,0.96,0.83>]
     [0.3 color rgb <1,0.96,0.83>]
     [0.4 0.5 color rgb <1,0.98,0.95> color rgb <1,0.98,0.95>]
     [0.51 0.6 color rgb <.77,0.54,0.33> color rgb <.77,0.54,0.33>]
     [0.61 0.9 color rgb <1,0.96,0.83> color rgb <1,0.96,0.83>]
     [0.91 color rgb <.77,0.54,0.33>]
     [1 color rgb <.77,0.54,0.33>]
    }
  scale 0.5
  }
}
texture { pigment { color rgbt <1,0.96,0.83,0.1>}
  normal { leopard 1 turbulence 1.7 scale 0.01 }
}

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
    translate x*-17
    translate y*7
    translate z*-40
    
}       
  
//céu
sky_sphere {
    pigment {
        bozo
        color_map {
            [0.0 rgb <0.005, 0.0, 0.015>]
            [0.4 rgb <0.002, 0.0, 0.01>]
            [0.6 rgb <0.0, 0.0, 0.01>]
            [1.0 rgb 0.0]
        }
        scale 0.05
    }
}

//prédio da frente
union{
    box {
        <-0.9, 0, 99.9>, 
        <99.9, 100,-0.3>  
        
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
    
    box {
       <-1, 11, 100>,  
       <100,11.55,-0.4>  
       
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
    
    //rodapé                       
    box {
       <-1, 0, 100>,  
       <100,0.55,-0.4>  
       
       texture {pigment{color rgb<0.08, 0.08, 0.08> }
             normal {
                wrinkles 0.8
                scale 0.3
             }          
       }
        
    }
    
    rotate y*40
    translate x*-10
    translate z*8
}
//***************
//prédios do fundo 
//*************** 
//prédio vermelho do fundo da esquerda
union{

    difference{
        box {
            <40, 0, 100>,  
            <76, 100, -0.35>  
        }
        //*************** 
        //buracos janelas
        #for (CntrX, 0, 3, 1)
            #for (CntrY, 0, 7, 1)
                box {
                    <44+(CntrX * 8), 83-(CntrY * 11), 5>,
                    <48+(CntrX * 8), 90-(CntrY * 11), -1>
                }
            #end
        #end
        
        //***************
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
    
    //***************
    #for (CntrX, 0, 3, 1)
        #for (CntrY, 0, 7, 1)
            //vidros janelas
            #if (!((CntrX = 2 & CntrY = 1) | (CntrX = 1 & CntrY = 2) | (CntrX = 3 & CntrY = 2) | (CntrX = 1 & CntrY = 5)
                    | (CntrX = 2 & CntrY = 5) | (CntrX = 3 & CntrY = 5) | (CntrX = 1 & CntrY = 6) | (CntrX = 2 & CntrY = 6)
                    | (CntrX = 3 & CntrY = 6) | (CntrX = 0 & CntrY = 7) | (CntrX = 2 & CntrY = 7)))
                light_source { <46+(CntrX * 8), 87.5-(CntrY * 11), 0> color rgb <10, 10, -1>
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
    //***************
    //sombra no topo
    light_source{
        <60, 120, -50> color rgb <-0.2, -0.05, -0.05>
        fade_distance 63
        fade_power 40
    }
    //***************
    rotate y*-50
    translate z*300
    translate x*-240
}

//***************
//prédio roxo do fundo
union{
    difference{
        box {
            <0, 0, -0.35>,  
            <36, 280, 50>   
        }
        box {
            <27, 240, -1>
            <37, 281, 51>
        }
        //*************** 
        //buracos janelas
        #for (CntrX, 0, 3, 1)
            #for (CntrY, 0, 6, 1)
                box {
                    <4+(CntrX * 8), 263-(CntrY * 11), 5>,
                    <8+(CntrX * 8), 270-(CntrY * 11), -1>
                }
            #end
        #end
        
        //***************
        texture {
            pigment { color rgb<0.075, 0.015, 0.075>}
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
    
    //***************
    #for (CntrX, 0, 3, 1)
        #for (CntrY, 0, 6, 1)
            //vidros janelas
            #if (!((CntrX = 3 & CntrY = 0) | (CntrX = 0 & CntrY = 1) | (CntrX = 3 & CntrY = 1) | (CntrX = 1 & CntrY = 2)
                    | (CntrX = 3 & CntrY = 2) | (CntrX = 1 & CntrY = 3) | (CntrX = 2 & CntrY = 4) | (CntrX = 3 & CntrY = 4)
                    | (CntrX = 2 & CntrY = 5) | (CntrX = 3 & CntrY = 5) | (CntrX = 0 & CntrY = 6) | (CntrX = 2 & CntrY = 6)
                    | (CntrX = 3 & CntrY = 6)))
                light_source { <6+(CntrX * 8), 267.5-(CntrY * 11), 0> color rgb <10, 10, -1>
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
                #if (!((CntrX = 3 & CntrY = 0) | (CntrX = 3 & CntrY = 1) | (CntrX = 3 & CntrY = 2)))
                    box{
                        <4+(CntrX * 8), 263-(CntrY * 11), 0>,
                        <8+(CntrX * 8), 270-(CntrY * 11), -0.35>
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
    #end
    //***************
    //sombra no topo
    light_source{
        <15, 300, -50> color rgb <-0.3, -0.08, -0.18>
        fade_distance 63
        fade_power 40
    }
    //***************
    rotate y*-29
    translate z*700
    translate x*-400
}

//***************
//prédio azul do fundo da direita
union{
    //***************
    difference{
        union{
            //parte inferior
            box {
                <0, 0, 0>,  
                <44, 136, 44>   
            }
            //parte superior
            box {
                <32, 136, 32>
                <12, 165, 12>
            }
            //pirâmide do topo
            object {
                union {
                    object{polygon { 5, <12,165,12>, <32,165,12>, <32,165,32>, <12,165,32>, <12,165,12> }}
                    object{polygon { 4, <12,165,12>, <32,165,12>, <22,180,22>, <12,165,12> }} 
                    object{polygon { 4, <32,165,12>, <32,165,32>, <22,180,22>, <32,165,12> }} 
                    object{polygon { 4, <32,165,32>, <12,165,32>, <22,180,22>, <32,165,32> }} 
                    object{polygon { 4, <12,165,32>, <12,165,12>, <22,180,22>, <12,165,32> }}
                }
            }
        }
        //*************** 
        //buracos janelas parte inferior
        #for (CntrX, 0, 4, 1)
            #for (CntrY, 0, 10, 1)
                box {
                    <5, 119-(CntrY * 11), 4+(CntrX * 8)>,
                    <-1, 126-(CntrY * 11), 8+(CntrX * 8)>
                }
                box {
                    <4+(CntrX * 8), 119-(CntrY * 11), 5>,
                    <8+(CntrX * 8), 126-(CntrY * 11), -1>
                }
            #end
        #end
        //buracos janelas parte superior
        #for (CntrX, 0, 1, 1)
            #for (CntrY, 0, 1, 1)
                box {
                    <17, 153-(CntrY * 11), 16+(CntrX * 8)>,
                    <11, 160-(CntrY * 11), 20+(CntrX * 8)>
                }
                box {
                    <16+(CntrX * 8), 153-(CntrY * 11), 17>,
                    <20+(CntrX * 8), 160-(CntrY * 11), 11>
                }
            #end
        #end
    
        //***************
        texture {
            pigment { color rgb<0.015, 0.015, 0.075>}
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
    //*************** 
    //vidros das janelas
    //parte inferior
    #for (CntrX, 0, 4, 1)
        #for (CntrY, 0, 10, 1)
            //parede esquerda
            #if (!((CntrY = 1 & CntrX = 3) | (CntrY = 3 & CntrX = 0) | (CntrY = 3 & CntrX = 2) | (CntrY = 4 & CntrX = 2)))
                light_source { <0.35, 122.5-(CntrY * 11), 6+(CntrX * 8)> color rgb <10, 10, -1>
                    fade_distance 10
                    fade_power 50
                    jitter
                    looks_like{
                        box{
                            <0.5, -4.5, -2>,
                            <0.35, 4.5, 2>
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
                    <0.5, 119-(CntrY * 11), 4+(CntrX * 8)>,
                    <0.35, 126-(CntrY * 11), 8+(CntrX * 8)>
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
            //parede direita
            #if (!((CntrY = 1 & CntrX = 1) | (CntrY = 2 & CntrX = 2)))
                light_source { <6+(CntrX * 8), 122.5-(CntrY * 11), 0.35> color rgb <10, 10, -1>
                    fade_distance 10
                    fade_power 50
                    jitter
                    looks_like{
                        box{
                            <-2, -4.5, 0.5>,
                            <2, 4.5, 0.35>
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
                    <4+(CntrX * 8), 119-(CntrY * 11), 0.5>,
                    <8+(CntrX * 8), 126-(CntrY * 11), 0.35>
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
    //parte superior
    #for (CntrX, 0, 1, 1)
        #for (CntrY, 0, 1, 1)
            //parede esquerda
            #if (!(CntrX = 1 & CntrY = 1))
                light_source { <12.35, 156.5-(CntrY * 11), 18+(CntrX * 8)> color rgb <10, 10, -1>
                    fade_distance 10
                    fade_power 50
                    jitter
                    looks_like{
                        box{
                            <12.5, -4.5, -2>,
                            <12.35, 4.5, 2>
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
                    <12.5, 153-(CntrY * 11), 16+(CntrX * 8)>,
                    <12.35, 160-(CntrY * 11), 20+(CntrX * 8)>
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
            //parede direita
            #if (true)
                light_source { <18+(CntrX * 8), 156.5-(CntrY * 11), 12.35> color rgb <10, 10, -1>
                    fade_distance 10
                    fade_power 50
                    jitter
                    looks_like{
                        box{
                            <-2, -4.5, 12.5>,
                            <2, 4.5, 12.35>
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
                    <16+(CntrX * 8), 152-(CntrY * 11), 12.5>,
                    <20+(CntrX * 8), 160-(CntrY * 11), 12.35>
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
    //***************
    //sombra no topo
    light_source{
        <-25, 190, -5> color rgb <-0.3, -0.18, -0.28>
        fade_distance 63
        fade_power 40
    }
    //***************
    rotate y*-70
    translate z*400
    translate x*-185
}

//***************
//bolas de luz
light_source
{ <-35, 15, 70> color rgb 2*<1, 1, 0.5>
    fade_distance 10
    fade_power 40
    looks_like
    {   
        sphere
        { <0,0,0>,5.5
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

light_source
{ <-32, 4, 65> color rgb 2*<1, 1, 0.5>
    fade_distance 10
    fade_power 40
    looks_like
    {   
        sphere
        { <0,0,0>,3
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

light_source
{ <-40, 10, 70> color rgb 2*<1, 1, 0.5>
    fade_distance 10
    fade_power 40
    looks_like
    {   
        sphere
        { <0,0,0>,3
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

light_source
{ <-35.5, 5.5, 50> color rgb 2*<1, 1, 0.5>
    fade_distance 10
    fade_power 40
    looks_like
    {   
        sphere
        { <0,0,0>,1
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


light_source
{ <-38, 7, 50> color rgb 2*<1, 1, 0.5>
    fade_distance 10
    fade_power 40
    looks_like
    {   
        sphere
        { <0,0,0>,2
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
       
 //papel esquerdo
 object {
     union {
           object{polygon 
           { 18, <-0.6,  0,-8>  , <-0.6,0.5,-8> , <-0.65,0.55,-8>  ,   <-0.7,  1, -8>,    
                <-0.2,  1.05,-8> , <0,  1,-8>    ,   <0.4,  1,-8>   ,   <0.3,  0.9,-8>,     
                <0.25, 0.85,-8> , <0.23,0.83,-8>,   <0,0.8,-8>     ,   <-0.2,0.7,-8>,
                <-0.25,0.65,-8> , <-0.3,0.6,-8> ,   <-0.3,0.4,-8>  ,   <-0.4,0.3,-8>,
                <-0.5,0.2,-8>   , <-0.6, 0, -8>
                }
           } 
           texture {paper}
      }       
      rotate y*35.8
      translate z*10.45
      translate y*6
      translate x*-1
    }
    //papel direito
    object {
     union {
           object{polygon 
           { 19, <0,  0,-8>      , <0.3, 1.6, -8> , <3, 1.6, -8>    , <3, 0.2, -8>,
                 <2.6, 0.6, -8>  , <2.4, 0.1, -8> , <2.2, 0.2, -8>  , <2, 0.5, -8>, 
                 <1.8, 0.8, -8>  , <1.6, 0.6, -8> , <1.4, 0.4, -8>  , <1.2, 0.5, -8>,
                 <0.9, 0.4, -8>  , <0.7, 0.5, -8> , <0.6, 0.6, -8>  , <0.5, 0.5, -8>,
                 <0.5, 0.3, -8>  , <0.3, 0.3, -8> , 
                 <0, 0, -8>
                }
           } 
           texture {paper}
      }       
      rotate y*40
      translate z*5
      translate y*4.5
      translate x*5.5
    }
union {
//cabeça
union{
    object{
        difference{
            cylinder{<0, 1, 0>, <0, 3, 0>, 1}
            cylinder{<0, 6, -1>, <0, 6, 1>, 1 scale<1, 0.5, 1>}
            cylinder{<0, 1, -1>, <0, 1, 0.5>, 0.5 scale<1, 1.5, 1> rotate z*-10}
            cylinder{<0, 1, -1>, <0, 1, 0.5>, 0.5 scale<1, 1.5, 1> rotate z*10}
        }
        texture {
            pigment {
                bozo
                turbulence 0.25
                color_map {
                    [0 rgb <0.05, 0.03, 0.14>]
                    [1 rgb <0.02, 0.02,  0.07 >]
                }
                scale 0.04
            }
            finish{ ambient 0.25 }
        }
    }
    object{
       intersection{
            cylinder{<0, 1, 0>, <0, 3, 0>, 1}
            union{
                cylinder{<0, 1, -1>, <0, 1, 0.5>, 0.5 scale<1, 1.5, 1> rotate z*-10}
                cylinder{<0, 1, -1>, <0, 1, 0.5>, 0.5 scale<1, 1.5, 1> rotate z*10}
            }
       }
       texture {
            pigment {
                bozo
                turbulence 0.25
                color_map {
                    [0 rgb <0.9, 0.6, 0.3>]
                    [1 rgb <0.9, 0.7,  0.4>]
                }
                scale 0.04
            }
            finish{ ambient 0.25 }
        }
    }
    object{
        union{
            sphere{<0.4, 1.3, -0.83>, 0.1}
            sphere{<-0.4, 1.3, -0.83>, 0.1}
        }   
    }
    object{
        sphere{<0, 1.5, 0>, 1 scale<1.3, 0.5, 1.3>}
        texture {
            pigment {
                bozo
                turbulence 0.25
                color_map {
                    [0 rgb <1, 1, 0.9>]
                    [1 rgb <0.9, 0.8,  0.7>]
                }
                scale 0.04
            }
            finish{ ambient 0.25 }
        }
    }
    object{
        sphere{<0, 1.1, -1>, 0.1}
        pigment{color rgb<0.9, 0.7, 0.8>}
    }
    scale <0.5, 0.5, 0.5>
    rotate x*6
    rotate y*5
    translate z*-10
    translate y*4 
    translate x*-0.9
    
}
//cabeça
union{
    object{
        difference{
            cylinder{<0, 1, 0>, <0, 2, 0>, 1}
        }
        texture {
            pigment {
                color rgb <0.026, 0.016, 0.02> 
            }
            finish{ ambient 0.25 }
        }
    }
    object{
        difference{
            cylinder{<0, 1, 0>, <0, 2, 0>, 1}
        }
        texture {
            pigment {
                color rgb <0.026, 0.016, 0.02> 
            }
            finish{ ambient 0.25 }
        }
    }
    
    object{
        difference{
            cylinder{<0, 1, 0>, <0, 2, 0>, 1}
        }
        texture {
            pigment {
                color rgb <0.026, 0.016, 0.02> 
            }
            finish{ ambient 0.25 }
        }
    }
    
    object{
        difference{
            cylinder{<0, 1, 0>, <0, 2, 0>, 1}
        }
        texture {
            pigment {
                color rgb <0.026, 0.016, 0.02> 
            }
            finish{ ambient 0.25 }
        }
    }
    
    object{
        sphere{<0, 1.5, 0>, 1 scale<1.9, 0.5, 1.3>}
        texture {
            pigment { color rgb <0.026, 0.016, 0.02>
            }
            finish{ ambient 0.25 }
        }
    }
    scale <0.5, 0.5, 0.5>
    rotate x*6
    rotate y*5
    rotate z*45
    translate z*-10
    translate y*4.8 
    translate x*-0.8
    
}                   
//sapato direito
union{
    union{
        difference{
            union{
                cylinder{<0, 1, 0>, <0, 1, 3>, 1 translate x*1}
                sphere{<1, 1, 0>, 1}
                intersection{
                    cylinder{<0, 1, 1>, <0, 1, 4>, 1 translate x*1}
                    cylinder{<0, 1, 3>, <0, 2, 3>, 1 translate x*1}
                }
            }
            box{<0, 0, -2>, <2, 1, 5>}
        }
        cylinder{<0, 0.5, 0>, <0, 1, 0>, 1 translate x*1}
        cylinder{<0, 0.5, 3>, <0, 1, 3>, 1 translate x*1}
        box{<0, 0.5, 0>, <2, 1, 3>}
        
        pigment{
            crackle
         scale .04
         poly_wave .045
         pigment_map {
              [0 rgb 0]
              [1 rgb .07]
         }
        }
        finish{
            diffuse 1
            specular .75
            roughness .035
            ambient 0
            reflection { .0075 .015
                fresnel 1
                metallic 0
            }
        }
    }
    union{
        cylinder{<0, 0, 0>, <0, 0.5, 0>, 1 translate x*1}
        cylinder{<0, 0, 3>, <0, 0.5, 3>, 1 translate x*1}
        box{<0, 0, 0>, <2, 0.5, 3>}
        
        pigment{
            crackle
         scale .04
         poly_wave .045
         pigment_map {
              [0 rgb <1, 1, 0.9>]
              [1 rgb <0.5, 0.5, 0.3>]
         }
        }
        finish{
            diffuse 1
            specular .75
            roughness .035
            ambient 0
        }
    }
                          
    scale <0.4, 0.25, 0.3>
    rotate y*-30
    translate z*-7.5
    translate x*-1
    
}     

//sapato esquerdo
union{
    union{
        difference{
            union{
                cylinder{<0, 1, 0>, <0, 1, 3>, 1 translate x*1}
                sphere{<1, 1, 0>, 1}
                intersection{
                    cylinder{<0, 1, 1>, <0, 1, 4>, 1 translate x*1}
                    cylinder{<0, 1, 3>, <0, 2, 3>, 1 translate x*1}
                }
            }
            box{<0, 0, -2>, <2, 1, 5>}
        }
        cylinder{<0, 0.5, 0>, <0, 1, 0>, 1 translate x*1}
        cylinder{<0, 0.5, 3>, <0, 1, 3>, 1 translate x*1}
        box{<0, 0.5, 0>, <2, 1, 3>}
        
        pigment{
            crackle
         scale .04
         poly_wave .045
         pigment_map {
              [0 rgb 0]
              [1 rgb .07]
         }
        }
        finish{
            diffuse 1
            specular .75
            roughness .035
            ambient 0
            reflection { .0075 .015
                fresnel 1
                metallic 0
            }
        }
    }
    union{
        cylinder{<0, 0, 0>, <0, 0.5, 0>, 1 translate x*1}
        cylinder{<0, 0, 3>, <0, 0.5, 3>, 1 translate x*1}
        box{<0, 0, 0>, <2, 0.5, 3>}
        
        pigment{
            crackle
         scale .04
         poly_wave .045
         pigment_map {
              [0 rgb <1, 1, 0.9>]
              [1 rgb <0.5, 0.5, 0.3>]
         }
        }
        finish{
            diffuse 1
            specular .75
            roughness .035
            ambient 0
        }
    }
    
    scale <0.4, 0.25, 0.3>
    rotate y*30
    rotate x*-23
    translate z*-5.5
    translate x*-3
    translate y*0.15
    
}   
//calças  
union{
    cylinder { 
    <-3,0,-4>,<-3,2,-4>, 0.4
    rotate x*-30 
    translate y*2.7
    translate z*-1.4
    translate x*0.88
    } 
    
cylinder { 
    <0,0,-9>,<0,2,-9>, 0.4
        translate x*-1.07  
        translate z*2.2
        translate y*0.3
    } 
    texture { 
        pigment { 
            color rgb <0.026, 0.016, 0.02>
            }  
        }
}    
}
