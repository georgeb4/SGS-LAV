﻿/*
*  Grayscale.shader
*  HoloLensARToolKit
*
*  This file is a part of HoloLensARToolKit.
*
*  HoloLensARToolKit is free software: you can redistribute it and/or modify
*  it under the terms of the GNU Lesser General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  HoloLensARToolKit is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU Lesser General Public License for more details.
*
*  You should have received a copy of the GNU Lesser General Public License
*  along with HoloLensARToolKit.  If not, see <http://www.gnu.org/licenses/>.
*
*  Copyright 2020 Long Qian
*
*  Author: Long Qian
*  Contact: lqian8@jhu.edu
*
*/

/*
* Modified by cookieofcode (cookieofcode@gmail.com)
* 
* - Update to support Single Pass Instanced Rendering
*/


Shader "Unlit/GreyScale_MRTK" {
    Properties {
        _MainTex ("Texture", 2D) = "black" { }
    }
    SubShader {
        Pass {

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            sampler2D _MainTex;

            struct v2f {
                float4  pos : SV_POSITION;
                float2  uv : TEXCOORD0;

                UNITY_VERTEX_OUTPUT_STEREO
            };

            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.pos = UnityObjectToClipPos (v.vertex);
                o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                float texcol = tex2D(_MainTex, i.uv).a;
                return fixed4(texcol, texcol, texcol, 1.0f);
            }

            ENDCG

        }
    }
    Fallback "VertexLit"
} 
