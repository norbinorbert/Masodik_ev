using Silk.NET.Input;
using Silk.NET.Maths;
using Silk.NET.OpenGL;
using Silk.NET.Windowing;

namespace Szem2
{
    internal static class Program
    {
        private static CameraDescriptor cameraDescriptor = new();

        private static CubeArrangementModel cubeArrangementModel = new();

        private static Arrays arrays = new();

        private static Random random = new Random();

        private static IWindow graphicWindow;

        private static GL Gl;

        private static int NUMBER_OF_CUBES = 27;
        private static Cube[] cubes = new Cube[NUMBER_OF_CUBES];

        private static uint program;

        private const string ModelMatrixVariableName = "uModel";
        private const string ViewMatrixVariableName = "uView";
        private const string ProjectionMatrixVariableName = "uProjection";

        private static readonly string VertexShaderSource = @"
        #version 330 core
        layout (location = 0) in vec3 vPos;
		layout (location = 1) in vec4 vCol;

        uniform mat4 uModel;
        uniform mat4 uView;
        uniform mat4 uProjection;

		out vec4 outCol;
        
        void main()
        {
			outCol = vCol;
            gl_Position = uProjection*uView*uModel*vec4(vPos.x, vPos.y, vPos.z, 1.0);
        }
        ";

        private static readonly string FragmentShaderSource = @"
        #version 330 core
        out vec4 FragColor;
		
		in vec4 outCol;

        void main()
        {
            FragColor = outCol;
        }
        ";

        static void Main(string[] args)
        {
            WindowOptions windowOptions = WindowOptions.Default;
            windowOptions.Title = "2. szeminárium";
            windowOptions.Size = new Silk.NET.Maths.Vector2D<int>(500, 500);

            graphicWindow = Window.Create(windowOptions);

            graphicWindow.Load += GraphicWindow_Load;
            graphicWindow.Update += GraphicWindow_Update;
            graphicWindow.Render += GraphicWindow_Render;
            graphicWindow.Closing += GraphicWindow_Closing;

            graphicWindow.Run();
        }

        private static void GraphicWindow_Load()
        {
            IInputContext inputContext = graphicWindow.CreateInput();
            foreach (var keyboard in inputContext.Keyboards)
            {
                keyboard.KeyDown += Keyboard_KeyDown;
            }

            Gl = graphicWindow.CreateOpenGL();

            Gl.ClearColor(System.Drawing.Color.White);

            for (int i = 0; i < NUMBER_OF_CUBES; i++)
            {
                SetUpObjects(i);
            }

            LinkProgram();

            Gl.Enable(EnableCap.CullFace);

            Gl.Enable(EnableCap.DepthTest);
            Gl.DepthFunc(DepthFunction.Lequal);
        }

        private static void LinkProgram()
        {
            uint vshader = Gl.CreateShader(ShaderType.VertexShader);
            uint fshader = Gl.CreateShader(ShaderType.FragmentShader);

            Gl.ShaderSource(vshader, VertexShaderSource);
            Gl.CompileShader(vshader);
            Gl.GetShader(vshader, ShaderParameterName.CompileStatus, out int vStatus);
            if (vStatus != (int)GLEnum.True)
                throw new Exception("Vertex shader failed to compile: " + Gl.GetShaderInfoLog(vshader));

            Gl.ShaderSource(fshader, FragmentShaderSource);
            Gl.CompileShader(fshader);

            program = Gl.CreateProgram();
            Gl.AttachShader(program, vshader);
            Gl.AttachShader(program, fshader);
            Gl.LinkProgram(program);
            Gl.DetachShader(program, vshader);
            Gl.DetachShader(program, fshader);
            Gl.DeleteShader(vshader);
            Gl.DeleteShader(fshader);

            Gl.GetProgram(program, GLEnum.LinkStatus, out var status);
            if (status == 0)
            {
                Console.WriteLine($"Error linking shader {Gl.GetProgramInfoLog(program)}");
            }
        }

        private static void Keyboard_KeyDown(IKeyboard keyboard, Key key, int arg3)
        {
            switch (key)
            {
                case Key.W:
                    cameraDescriptor.MoveForward();
                    break;
                case Key.S:
                    cameraDescriptor.MoveBackward();
                    break;
                case Key.A:
                    cameraDescriptor.MoveLeft();
                    break;
                case Key.D:
                    cameraDescriptor.MoveRight();
                    break;
                case Key.Space:
                    cameraDescriptor.MoveUp();
                    break;
                case Key.ControlLeft:
                    cameraDescriptor.MoveDown();
                    break;
                case Key.Left:
                    cameraDescriptor.LookLeft();
                    break;
                case Key.Right:
                    cameraDescriptor.LookRight();
                    break;
                case Key.Up:
                    cameraDescriptor.LookUp();
                    break;
                case Key.Down:
                    cameraDescriptor.LookDown();
                    break;
                case Key.T:
                    cubeArrangementModel.RotateX1(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.F:
                    cubeArrangementModel.RotateX2(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.C:
                    cubeArrangementModel.RotateX3(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.Y:
                    cubeArrangementModel.RotateX1(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.G:
                    cubeArrangementModel.RotateX2(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.V:
                    cubeArrangementModel.RotateX3(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.U:
                    cubeArrangementModel.RotateY1(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.H:
                    cubeArrangementModel.RotateY2(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.B:
                    cubeArrangementModel.RotateY3(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.I:
                    cubeArrangementModel.RotateY1(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.J:
                    cubeArrangementModel.RotateY2(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.N:
                    cubeArrangementModel.RotateY3(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.O:
                    cubeArrangementModel.RotateZ1(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.K:
                    cubeArrangementModel.RotateZ2(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.M:
                    cubeArrangementModel.RotateZ3(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.P:
                    cubeArrangementModel.RotateZ1(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.L:
                    cubeArrangementModel.RotateZ2(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.Comma:
                    cubeArrangementModel.RotateZ3(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.OVER_TIME);
                    break;
                case Key.R:
                    for (int i = 0; i < 30; i++)
                    {
                        int rotation = random.Next(18);
                        switch (rotation)
                        {
                            case 0: cubeArrangementModel.RotateX1(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT);break;
                            case 1: cubeArrangementModel.RotateX1(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 2: cubeArrangementModel.RotateX2(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 3: cubeArrangementModel.RotateX2(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 4: cubeArrangementModel.RotateX3(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 5: cubeArrangementModel.RotateX3(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 6: cubeArrangementModel.RotateY1(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 7: cubeArrangementModel.RotateY1(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 8: cubeArrangementModel.RotateY2(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 9: cubeArrangementModel.RotateY2(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 10: cubeArrangementModel.RotateY3(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 11: cubeArrangementModel.RotateY3(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 12: cubeArrangementModel.RotateZ1(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 13: cubeArrangementModel.RotateZ1(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 14: cubeArrangementModel.RotateZ2(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 15: cubeArrangementModel.RotateZ2(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 16: cubeArrangementModel.RotateZ3(cubes, cubeArrangementModel.CLOCKWISE, cubeArrangementModel.INSTANT); break;
                            case 17: cubeArrangementModel.RotateZ3(cubes, cubeArrangementModel.COUNTERCLOCKWISE, cubeArrangementModel.INSTANT); break;
                        }
                    }
                    break;
            }
        }

        private static void GraphicWindow_Update(double deltaTime)
        {
            cubeArrangementModel.AdvanceTime(deltaTime, cubes);
        }

        private static unsafe void GraphicWindow_Render(double deltaTime)
        {
            Gl.Clear(ClearBufferMask.ColorBufferBit);
            Gl.Clear(ClearBufferMask.DepthBufferBit);

            Gl.UseProgram(program);

            SetViewMatrix();
            SetProjectionMatrix();

            DrawCenterCube();
        }

        private static unsafe void DrawCenterCube()
        {
            for (int i = 0; i < NUMBER_OF_CUBES; i++)
            {
                SetModelMatrix(cubes[i].Transformation);

                Gl.BindVertexArray(cubes[i].Vao);
                Gl.DrawElements(GLEnum.Triangles, (uint)arrays.indexArray.Length, GLEnum.UnsignedInt, null);
                Gl.BindVertexArray(0);
            }
        }

        private static unsafe void SetModelMatrix(Matrix4X4<float> modelMatrix)
        {

            int location = Gl.GetUniformLocation(program, ModelMatrixVariableName);
            if (location == -1)
            {
                throw new Exception($"{ModelMatrixVariableName} uniform not found on shader.");
            }

            Gl.UniformMatrix4(location, 1, false, (float*)&modelMatrix);
            CheckError();
        }

        private static unsafe void SetUpObjects(int index)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            float[] vertexArray = (float[])arrays.vertexArray.Clone();
            for (int i = 0; i < vertexArray.Length; i += 3)
            {
                vertexArray[i] = vertexArray[i] + arrays.offsets[3 * index];
                vertexArray[i + 1] = vertexArray[i + 1] + arrays.offsets[3 * index + 1];
                vertexArray[i + 2] = vertexArray[i + 2] + arrays.offsets[3 * index + 2];
            }

            float[] colorArray = arrays.colorArray[index];

            uint[] indexArray = arrays.indexArray;

            uint vertices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, vertices);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)vertexArray.AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(0, 3, VertexAttribPointerType.Float, false, 0, null);
            Gl.EnableVertexAttribArray(0);

            uint colors = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, colors);

            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)colorArray.AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(1, 4, VertexAttribPointerType.Float, false, 0, null);
            Gl.EnableVertexAttribArray(1);

            uint indices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ElementArrayBuffer, indices);
            Gl.BufferData(GLEnum.ElementArrayBuffer, (ReadOnlySpan<uint>)indexArray.AsSpan(), GLEnum.StaticDraw);

            Gl.BindVertexArray(0);

            cubes[index] = new Cube(index / 9 - 1, (index % 9) / 3 - 1, index % 3 - 1, vao, vertices, colors, indices);
        }

        private static void GraphicWindow_Closing()
        {
            for (int i = 0; i < 18; i++)
            {
                Gl.DeleteBuffer(cubes[i].Vertices);
                Gl.DeleteBuffer(cubes[i].Colors);
                Gl.DeleteBuffer(cubes[i].Indices);
                Gl.DeleteVertexArray(cubes[i].Vao);
            }
        }

        private static unsafe void SetProjectionMatrix()
        {
            var viewMatrix = Matrix4X4.CreatePerspectiveFieldOfView<float>((float)(Math.PI / 2), 1024f / 768f, 0.1f, 100);
            int location = Gl.GetUniformLocation(program, ProjectionMatrixVariableName);

            if (location == -1)
            {
                throw new Exception($"{ProjectionMatrixVariableName} uniform not found on shader.");
            }

            Gl.UniformMatrix4(location, 1, false, (float*)&viewMatrix);
            CheckError();
        }

        private static unsafe void SetViewMatrix()
        {
            var viewMatrix = Matrix4X4.CreateLookAt(cameraDescriptor.Position, cameraDescriptor.Target, cameraDescriptor.UpVector);

            int location = Gl.GetUniformLocation(program, ViewMatrixVariableName);

            if (location == -1)
            {
                throw new Exception($"{ViewMatrixVariableName} uniform not found on shader.");
            }

            Gl.UniformMatrix4(location, 1, false, (float*)&viewMatrix);
            CheckError();
        }

        public static void CheckError()
        {
            var error = (ErrorCode)Gl.GetError();
            if (error != ErrorCode.NoError)
                throw new Exception("GL.GetError() returned " + error.ToString());
        }
    }
}
