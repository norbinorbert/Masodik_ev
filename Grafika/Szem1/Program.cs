using Silk.NET.Maths;
using Silk.NET.OpenGL;
using Silk.NET.Windowing;
using System.Drawing;
using static Silk.NET.Core.Native.WinString;

namespace Szem1
{
    internal static class Program
    {
        private static IWindow window;
        private static GL Gl;

        private static uint program;

        private static readonly string VertexShaderSource = @"
        #version 330 core
        layout (location = 0) in vec3 vPos;
		layout (location = 1) in vec4 vCol;

		out vec4 outCol;
        
        void main()
        {
			outCol = vCol;
            gl_Position = vec4(vPos.x, vPos.y, vPos.z, 1.0);
        }";

        private static readonly string FragmentShaderSource = @"
        #version 330 core
        out vec4 FragColor;
		
		in vec4 outCol;

        void main()
        {
            FragColor = outCol;
        }";

        static void Main(string[] args)
        {
            WindowOptions windowOptions = WindowOptions.Default;
            windowOptions.Title = "Szem1";
            windowOptions.Size = new Vector2D<int>(500, 500);

            window = Window.Create(windowOptions);

            window.Load += Window_Load;
            window.Update += Window_Update;
            window.Render += Window_Render;

            window.Run();
        }

        private static void Window_Load()
        {
            //Console.WriteLine("Load");

            Gl = window.CreateOpenGL();
            Gl.ClearColor(Color.White);

            uint vshader = Gl.CreateShader(ShaderType.VertexShader);
            uint fshader = Gl.CreateShader(ShaderType.FragmentShader);

            Gl.ShaderSource(vshader, VertexShaderSource);
            Gl.CompileShader(vshader);
            Gl.GetShader(vshader, ShaderParameterName.CompileStatus, out int vStatus);
            if (vStatus != (int)GLEnum.True)
                throw new Exception($"Vertex shader failed to compile: {Gl.GetShaderInfoLog(vshader)}");

            Gl.ShaderSource(fshader, FragmentShaderSource);
            Gl.CompileShader(fshader);

            program = Gl.CreateProgram();
            Gl.AttachShader(program, vshader);
            Gl.AttachShader(program, fshader);
            Gl.LinkProgram(program);

            Gl.GetProgram(program, GLEnum.LinkStatus, out var status);
            if (status == 0)
            {
                Console.WriteLine($"Error linking shader {Gl.GetProgramInfoLog(program)}");
            }

            Gl.DetachShader(program, vshader);
            Gl.DetachShader(program, fshader);
            Gl.DeleteShader(vshader);
            Gl.DeleteShader(fshader);

        }

        private static void Window_Update(double deltaTime)
        {
            //Console.WriteLine($"Update after {deltaTime} [s].");
            // multithreaded
            // make sure it is threadsafe
            // NO GL calls
        }

        private static unsafe void DrawLines()
        {
            uint vertexArray = Gl.GenVertexArray();
            uint vertexBuffer = Gl.GenBuffer();

            Gl.BindVertexArray(vertexArray);
            Gl.BindBuffer(GLEnum.ArrayBuffer, vertexBuffer);

            float[] vertices = { 
                -0.5f, -0.45f, -0.6f, 0.3f,
                -0.25f, -0.63f, -0.3f, 0.15f,
                -0.71f, -0.15f, 0, -0.55f,
                -0.75f, 0.1f, 0, -0.25f,

                0.5f, -0.45f, 0.6f, 0.3f,
                0.25f, -0.63f, 0.3f, 0.15f,
                0, -0.25f, 0.77f, 0.16f,
                0, -0.55f, 0.72f, -0.13f,

                0.25f, 0.6f, -0.6f, 0.3f,
                0.5f, 0.5f, -0.3f, 0.15f,
                -0.25f, 0.6f, 0.6f, 0.3f,
                -0.5f, 0.5f, 0.3f, 0.15f,
            };

            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)vertices.AsSpan(), GLEnum.StaticDraw);

            Gl.VertexAttribPointer(0, 2, VertexAttribPointerType.Float, false, 0, null);
            Gl.EnableVertexAttribArray(0);

            Gl.BindVertexArray(vertexArray);
            Gl.DrawArrays(PrimitiveType.Lines, 0, (uint)vertices.Length/2);
        }

        private static unsafe void Window_Render(double deltaTime)
        {
            //Console.WriteLine($"Render after {deltaTime} [s].");
            // GL here
            Gl.Clear(ClearBufferMask.ColorBufferBit);

            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            float[] vertexArray = new float[]
            {
                //-0.5f, -0.5f, 0.0f,
                //0.5f, -0.5f, 0.0f,
                //0.0f, 0.5f, 0.0f,
                //0.7f, 0.5f, 0.0f,
                
                //bal oldal
                0f, 0f, 0f,
                0f, -0.8f, 0f,
                -0.8f, 0.4f, 0f,
                -0.7f, -0.3f, 0f,

                //jobb oldal
                0f, 0f, 0f,
                0f, -0.8f, 0f,
                0.8f, 0.4f, 0f,
                0.7f, -0.3f, 0f, 

                //felso oldal
                0f, 0f, 0f,
                -0.8f, 0.4f, 0f,
                0.8f, 0.4f, 0f,
                0f, 0.7f, 0f,
                
                ////bal rubikkocka oldal
                //0f, 0f, 0f,
                //0f, -0.266f, 0f,
                //-0.266f, -0.066f, 0f,
                //-0.266f, 0.133f, 0f,

                //0f, -0.266f, 0f,
                //0f, -0.533f, 0f,
                //-0.266f, -0.066f, 0f,
                //-0.266f, -0.3f, 0f,

                //0f, -0.533f, 0f,
                //0f, -0.8f, 0f,
                //-0.266f, -0.3f, 0f,
                //-0.266f, -0.61f, 0f,
            };

            float[] colorArray = new float[]
            {
                //1.0f, 0.0f, 0.0f, 1.0f,
                //0.0f, 1.0f, 0.0f, 1.0f,
                //0.0f, 0.0f, 1.0f, 1.0f,
                //0.0f, 0.0f, 1.0f, 1.0f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                1f, 0f, 0f, 1f,
                0f, 1f, 0f, 1f,
                0f, 1f, 0f, 1f,
                0f, 1f, 0f, 1f,
                0f, 1f, 0f, 1f,
                0f, 0f, 1f, 1f,
                0f, 0f, 1f, 1f,
                0f, 0f, 1f, 1f,
                0f, 0f, 1f, 1f,
                0f, 0f, 0f, 1f,
                0f, 0f, 0f, 1f,
                0f, 0f, 0f, 1f,
                0f, 0f, 0f, 1f,
                1f, 1f, 1f, 1f,
                1f, 1f, 1f, 1f,
                1f, 1f, 1f, 1f,
                1f, 1f, 1f, 1f,
                0.5f, 0.5f, 0.5f, 1f,
                0.5f, 0.5f, 0.5f, 1f,
                0.5f, 0.5f, 0.5f, 1f,
                0.5f, 0.5f, 0.5f, 1f,
            };

            uint[] indexArray = new uint[]
            {
                //0, 1, 2,
                //2, 1, 3,
                0, 1, 2,
                1, 2, 3,
                4, 5, 6,
                5, 6, 7,
                8, 9, 10,
                9, 10, 11,
                12, 13, 14,
                12, 14, 15,
                16, 17, 18,
                17, 18, 19,
                20, 21, 22,
                21, 22, 23,
            };

            uint verticles = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, verticles);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)vertexArray.AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(0, 3, VertexAttribPointerType.Float, false, 0, null);
            Gl.EnableVertexAttribArray(0);

            if ((ErrorCode)Gl.GetError() != ErrorCode.NoError)
                throw new Exception("Error");

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

            Gl.UseProgram(program);

            // we used element buffer
            Gl.DrawElements(GLEnum.Triangles, (uint)indexArray.Length, GLEnum.UnsignedInt, null);
            DrawLines();

            Gl.BindBuffer(GLEnum.ElementArrayBuffer, 0);

            // always unbound the vertex buffer first, so no halfway results are displayed by accident
            Gl.DeleteBuffer(verticles);
            Gl.DeleteBuffer(colors);
            Gl.DeleteBuffer(indices);
            Gl.DeleteVertexArray(vao);
        }
    }
}
