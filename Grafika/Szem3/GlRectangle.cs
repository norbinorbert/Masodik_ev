using Silk.NET.OpenGL;

namespace Szeminarium1_24_02_17_2
{
    internal class GlRectangle
    {
        public uint Vao { get; }
        public uint Vertices { get; }
        public uint Colors { get; }
        public uint Indices { get; }
        public uint IndexArrayLength { get; }

        private GL Gl;

        private GlRectangle(uint vao, uint vertices, uint colors, uint indeces, uint indexArrayLength, GL gl)
        {
            this.Vao = vao;
            this.Vertices = vertices;
            this.Colors = colors;
            this.Indices = indeces;
            this.IndexArrayLength = indexArrayLength;
            this.Gl = gl;
        }

        public static unsafe GlRectangle CreateRectangleWithPerpendicularNormals(GL Gl)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            float[] vertexArray = new float[] {
                -0.5f, 0f, 0f, 0f, 0f, 1f,
                -0.5f, 2f, 0f, 0f, 0f, 1f,
                0.5f, 0f, 0f, 0f, 0f, 1f,
                0.5f, 2f, 0f, 0f, 0f, 1f,
            };

            float[] colorArray = new float[]{
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
            };

            uint[] indexArray = new uint[] {
                0, 2, 1,
                2, 3, 1,
            };

            return RectangleBufferSettings(Gl, vao, vertexArray, colorArray, indexArray);
        }

        public static unsafe GlRectangle CreateRectangleWithAngledNormals(GL Gl)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            float[] vertexArray = new float[] {
                -0.5f, 0f, 0f, -(float)( Math.Sin(Math.PI / 18)), 0f, -(float)Math.Cos(Math.PI / 18),
                -0.5f, 2f, 0f, -(float)( Math.Sin(Math.PI / 18)), 0f, -(float)Math.Cos(Math.PI / 18),
                0.5f, 0f, 0f, (float)(Math.Sin(Math.PI / 18)), 0f, -(float)Math.Cos(Math.PI / 18),
                0.5f, 2f, 0f, (float)(Math.Sin(Math.PI / 18)), 0f, -(float)Math.Cos(Math.PI / 18),
            };

            float[] colorArray = new float[]{
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
            };

            uint[] indexArray = new uint[] {
                0, 2, 1,
                2, 3, 1,
            };

            return RectangleBufferSettings(Gl, vao, vertexArray, colorArray, indexArray);
        }

        private static unsafe GlRectangle RectangleBufferSettings(GL Gl, uint vao, float[] vertexArray, float[] colorArray, uint[] indexArray)
        {
            uint offsetPos = 0;
            uint offsetNormal = offsetPos + (3 * sizeof(float));
            uint vertexSize = offsetNormal + (3 * sizeof(float));

            uint vertices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, vertices);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)vertexArray.AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(0, 3, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetPos);
            Gl.EnableVertexAttribArray(0);

            Gl.EnableVertexAttribArray(2);
            Gl.VertexAttribPointer(2, 3, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetNormal);

            uint colors = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, colors);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)colorArray.AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(1, 4, VertexAttribPointerType.Float, false, 0, null);
            Gl.EnableVertexAttribArray(1);

            uint indices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ElementArrayBuffer, indices);
            Gl.BufferData(GLEnum.ElementArrayBuffer, (ReadOnlySpan<uint>)indexArray.AsSpan(), GLEnum.StaticDraw);

            // release array buffer
            Gl.BindBuffer(GLEnum.ArrayBuffer, 0);
            uint indexArrayLength = (uint)indexArray.Length;

            return new GlRectangle(vao, vertices, colors, indices, indexArrayLength, Gl);
        }

        internal void Release()
        {
            // always unbound the vertex buffer first, so no halfway results are displayed by accident
            Gl.DeleteBuffer(Vertices);
            Gl.DeleteBuffer(Colors);
            Gl.DeleteBuffer(Indices);
            Gl.DeleteVertexArray(Vao);
        }
    }
}
