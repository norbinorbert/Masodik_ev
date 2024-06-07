#version 330 core
        
uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos;

uniform sampler2D uTexture;

out vec4 FragColor;

in vec4 outCol;
in vec3 outNormal;
in vec3 outWorldPosition;
in vec2 outTex;

void main()
{
    float shininess = 200;

    float ambientStrength = 0.5;
    vec3 ambient = ambientStrength * lightColor;

    float diffuseStrength = 0.3;
    vec3 norm = normalize(outNormal);
    vec3 lightDir = normalize(lightPos - outWorldPosition);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor * diffuseStrength;

    float specularStrength = 0.5;
    vec3 viewDir = normalize(viewPos - outWorldPosition);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), shininess) / max(dot(norm,viewDir), -dot(norm,lightDir));
    vec3 specular = specularStrength * spec * lightColor;  

    vec3 result = (ambient + diffuse + specular) * outCol.xyz;

    // textrure color
    vec4 textColor = texture(uTexture, outTex);

    FragColor = vec4(result, outCol.w) + vec4(textColor);
}