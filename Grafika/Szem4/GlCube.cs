using Silk.NET.OpenGL;

namespace Szem4
{
    internal class GlCube: GlObject
    {

        private GlCube(uint vao, uint vertices, uint colors, uint indeces, uint indexArrayLength, GL gl)
            : base(vao, vertices, colors, indeces, indexArrayLength, gl)
        { }

        public static unsafe GlCube CreateCubeWithFaceColors(GL Gl, float[] face1Color, float[] face2Color, float[] face3Color, float[] face4Color, float[] face5Color, float[] face6Color)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            // counter clockwise is front facing
            float[] vertexArray = new float[] {
                // top face
                -0.5f, 0.5f, 0.5f, 0f, 1f, 0f,
                0.5f, 0.5f, 0.5f, 0f, 1f, 0f,
                0.5f, 0.5f, -0.5f, 0f, 1f, 0f,
                -0.5f, 0.5f, -0.5f, 0f, 1f, 0f,

                // front face
                -0.5f, 0.5f, 0.5f, 0f, 0f, 1f,
                -0.5f, -0.5f, 0.5f, 0f, 0f, 1f,
                0.5f, -0.5f, 0.5f, 0f, 0f, 1f,
                0.5f, 0.5f, 0.5f, 0f, 0f, 1f,

                // left face
                -0.5f, 0.5f, 0.5f, -1f, 0f, 0f,
                -0.5f, 0.5f, -0.5f, -1f, 0f, 0f,
                -0.5f, -0.5f, -0.5f, -1f, 0f, 0f,
                -0.5f, -0.5f, 0.5f, -1f, 0f, 0f,

                // bottom face
                -0.5f, -0.5f, 0.5f, 0f, -1f, 0f,
                0.5f, -0.5f, 0.5f,0f, -1f, 0f,
                0.5f, -0.5f, -0.5f,0f, -1f, 0f,
                -0.5f, -0.5f, -0.5f,0f, -1f, 0f,

                // back face
                0.5f, 0.5f, -0.5f, 0f, 0f, -1f,
                -0.5f, 0.5f, -0.5f,0f, 0f, -1f,
                -0.5f, -0.5f, -0.5f,0f, 0f, -1f,
                0.5f, -0.5f, -0.5f,0f, 0f, -1f,

                // right face
                0.5f, 0.5f, 0.5f, 1f, 0f, 0f,
                0.5f, 0.5f, -0.5f,1f, 0f, 0f,
                0.5f, -0.5f, -0.5f,1f, 0f, 0f,
                0.5f, -0.5f, 0.5f,1f, 0f, 0f
            };

            List<float> colorsList = new List<float>();
            colorsList.AddRange(face1Color);
            colorsList.AddRange(face1Color);
            colorsList.AddRange(face1Color);
            colorsList.AddRange(face1Color);

            colorsList.AddRange(face2Color);
            colorsList.AddRange(face2Color);
            colorsList.AddRange(face2Color);
            colorsList.AddRange(face2Color);

            colorsList.AddRange(face3Color);
            colorsList.AddRange(face3Color);
            colorsList.AddRange(face3Color);
            colorsList.AddRange(face3Color);

            colorsList.AddRange(face4Color);
            colorsList.AddRange(face4Color);
            colorsList.AddRange(face4Color);
            colorsList.AddRange(face4Color);

            colorsList.AddRange(face5Color);
            colorsList.AddRange(face5Color);
            colorsList.AddRange(face5Color);
            colorsList.AddRange(face5Color);

            colorsList.AddRange(face6Color);
            colorsList.AddRange(face6Color);
            colorsList.AddRange(face6Color);
            colorsList.AddRange(face6Color);


            float[] colorArray = colorsList.ToArray();

            uint[] indexArray = new uint[] {
                0, 1, 2,
                0, 2, 3,

                4, 5, 6,
                4, 6, 7,

                8, 9, 10,
                10, 11, 8,

                12, 14, 13,
                12, 15, 14,

                17, 16, 19,
                17, 19, 18,

                20, 22, 21,
                20, 23, 22
            };

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

            return new GlCube(vao, vertices, colors, indices, indexArrayLength, Gl);
        }

        public static unsafe GlCube CreateSquare(GL Gl, float[] faceColor)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            // counter clockwise is front facing
            float[] vertexArray = new float[] {
                // top face
                -100f, 0f, 100f, 0f, 1f, 0f,
                100f, 0f, 100f, 0f, 1f, 0f,
                100f, 0f, -100f, 0f, 1f, 0f,
                -100f, 0f, -100f, 0f, 1f, 0f,
            };

            List<float> colorsList = new List<float>();
            colorsList.AddRange(faceColor);
            colorsList.AddRange(faceColor);
            colorsList.AddRange(faceColor);
            colorsList.AddRange(faceColor);

            float[] colorArray = colorsList.ToArray();

            uint[] indexArray = new uint[] {
                0, 1, 2,
                0, 2, 3,
            };

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

            return new GlCube(vao, vertices, colors, indices, indexArrayLength, Gl);
        }
    }
}
