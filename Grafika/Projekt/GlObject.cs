using Silk.NET.OpenGL;
using StbImageSharp;

namespace Projekt
{
    internal class GlObject(uint vao, uint vertices, uint colors, uint indices, uint indexArrayLength,
                            GL gl, uint texture = 0, Hitbox? hitbox = default)
    {
        public uint Vao { get; } = vao;
        public uint Vertices { get; } = vertices;
        public uint Colors { get; } = colors;
        public uint Indices { get; } = indices;
        public uint IndexArrayLength { get; } = indexArrayLength;

        public uint? Texture { get; } = texture;
        public Hitbox? Hitbox { get; set; } = hitbox;

        private readonly GL Gl = gl;

        internal void ReleaseGlObject()
        {
            Gl.DeleteBuffer(Vertices);
            Gl.DeleteBuffer(Colors);
            Gl.DeleteBuffer(Indices);
            Gl.DeleteVertexArray(Vao);
        }

        internal static ImageResult ReadTextureImage(string textureResource)
        {
            ImageResult result;
            using (Stream skyeboxStream
                = typeof(GlCube).Assembly.GetManifestResourceStream("Projekt.Resources." + textureResource))
                result = ImageResult.FromStream(skyeboxStream, ColorComponents.RedGreenBlueAlpha);

            return result;
        }
    }
}
