using Silk.NET.Maths;

namespace Szem2
{
    internal class Cube
    {
        public int X { get; set; }
        public int Y { get; set; }
        public int Z { get; set; }

        public int OrigX { get; private set; }
        public int OrigY { get; private set; }
        public int OrigZ { get; private set; }

        public uint Vao { get; set; }
        public uint Vertices { get; set; }
        public uint Colors { get; set; }
        public uint Indices { get; set; }

        public Cube(int x, int y, int z, uint vao, uint vertices, uint colors, uint indices)
        {
            X = x;
            OrigX = x;

            Y = y;
            OrigY = y;

            Z = z;
            OrigZ = z;

            Vao = vao;
            Vertices = vertices;
            Colors = colors;
            Indices = indices;
            Transformation = Matrix4X4<float>.Identity;
        }

        public Matrix4X4<float> Transformation { get; set; }
    }
}
