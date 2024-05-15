using Silk.NET.Maths;
using Silk.NET.OpenGL;

namespace Szem5
{
    internal class ObjResourceReader
    {
        public static unsafe GlObject CreateTeapotWithColor(GL Gl, float[] faceColor)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            List<float[]> objVertices;
            List<int[]> objFaces;

            ReadObjDataForTeapot(out objVertices, out objFaces);

            List<float> glVertices = new List<float>();
            List<float> glColors = new List<float>();
            List<uint> glIndices = new List<uint>();

            CreateGlArraysFromObjArrays(faceColor, objVertices, objFaces, glVertices, glColors, glIndices);

            return CreateOpenGlObject(Gl, vao, glVertices, glColors, glIndices);
        }

        private static unsafe GlObject CreateOpenGlObject(GL Gl, uint vao, List<float> glVertices, List<float> glColors, List<uint> glIndices)
        {
            uint offsetPos = 0;
            uint offsetNormal = offsetPos + (3 * sizeof(float));
            uint vertexSize = offsetNormal + (3 * sizeof(float));

            uint vertices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, vertices);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)glVertices.ToArray().AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(0, 3, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetPos);
            Gl.EnableVertexAttribArray(0);

            Gl.EnableVertexAttribArray(2);
            Gl.VertexAttribPointer(2, 3, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetNormal);

            uint colors = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, colors);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)glColors.ToArray().AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(1, 4, VertexAttribPointerType.Float, false, 0, null);
            Gl.EnableVertexAttribArray(1);

            uint indices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ElementArrayBuffer, indices);
            Gl.BufferData(GLEnum.ElementArrayBuffer, (ReadOnlySpan<uint>)glIndices.ToArray().AsSpan(), GLEnum.StaticDraw);

            // release array buffer
            Gl.BindBuffer(GLEnum.ArrayBuffer, 0);
            uint indexArrayLength = (uint)glIndices.Count;

            return new GlObject(vao, vertices, colors, indices, indexArrayLength, Gl);
        }

        private static unsafe void CreateGlArraysFromObjArrays(float[] faceColor, List<float[]> objVertices, List<int[]> objFaces, List<float> glVertices, List<float> glColors, List<uint> glIndices)
        {
            Dictionary<string, int> glVertexIndices = new Dictionary<string, int>();

            foreach (var objFace in objFaces)
            {
                var aObjVertex = objVertices[objFace[0] - 1];
                var a = new Vector3D<float>(aObjVertex[0], aObjVertex[1], aObjVertex[2]);
                var bObjVertex = objVertices[objFace[1] - 1];
                var b = new Vector3D<float>(bObjVertex[0], bObjVertex[1], bObjVertex[2]);
                var cObjVertex = objVertices[objFace[2] - 1];
                var c = new Vector3D<float>(cObjVertex[0], cObjVertex[1], cObjVertex[2]);

                var normal = Vector3D.Normalize(Vector3D.Cross(b - a, c - a));

                // process 3 vertices
                for (int i = 0; i < objFace.Length; ++i)
                {
                    var objVertex = objVertices[objFace[i] - 1];

                    // create gl description of vertex
                    List<float> glVertex = new List<float>();
                    glVertex.AddRange(objVertex);
                    glVertex.Add(normal.X);
                    glVertex.Add(normal.Y);
                    glVertex.Add(normal.Z);
                    // add textrure, color

                    // check if vertex exists
                    var glVertexStringKey = string.Join(" ", glVertex);
                    if (!glVertexIndices.ContainsKey(glVertexStringKey))
                    {
                        glVertices.AddRange(glVertex);
                        glColors.AddRange(faceColor);
                        glVertexIndices.Add(glVertexStringKey, glVertexIndices.Count);
                    }

                    // add vertex to triangle indices
                    glIndices.Add((uint)glVertexIndices[glVertexStringKey]);
                }
            }
        }

        private static unsafe void ReadObjDataForTeapot(out List<float[]> objVertices, out List<int[]> objFaces)
        {
            objVertices = new List<float[]>();
            objFaces = new List<int[]>();
            using (Stream objStream = typeof(ObjResourceReader).Assembly.GetManifestResourceStream("Szem5.Resources.teapot.obj"))
            using (StreamReader objReader = new StreamReader(objStream))
            {
                while (!objReader.EndOfStream)
                {
                    var line = objReader.ReadLine();

                    if (String.IsNullOrEmpty(line) || line.Trim().StartsWith("#"))
                        continue;

                    var lineClassifier = line.Substring(0, line.IndexOf(' '));
                    var lineData = line.Substring(lineClassifier.Length).Trim().Split(' ');

                    switch (lineClassifier)
                    {
                        case "v":
                            float[] vertex = new float[3];
                            for (int i = 0; i < vertex.Length; ++i)
                                vertex[i] = float.Parse(lineData[i]);
                            objVertices.Add(vertex);
                            break;
                        case "f":
                            int[] face = new int[3];
                            for (int i = 0; i < face.Length; ++i)
                                face[i] = int.Parse(lineData[i]);
                            objFaces.Add(face);
                            break;
                    }
                }
            }
        }

        public static unsafe GlObject CreateCat(GL Gl)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            List<float[]> objVertices;
            List<string[]> objFaces;
            List<float[]> objNormals;
            List<float[]> objTextures;

            ReadObjDataForCat(out objVertices, out objFaces, out objNormals, out objTextures);

            List<float> glVertices = new List<float>();
            List<uint> glIndices = new List<uint>();

            CreateGlArraysFromObjArraysIncludingTextures(objVertices, objFaces, objNormals, objTextures, glVertices, glIndices);

            return CreateOpenGlObjectWithTexture(Gl, vao, glVertices, glIndices);
        }

        private static unsafe void ReadObjDataForCat(out List<float[]> objVertices, out List<string[]> objFaces, 
            out List<float[]> objNormals, out List<float[]> objTextures)
        {
            objVertices = new List<float[]>();
            objFaces = new List<string[]>();
            objNormals = new List<float[]>();
            objTextures = new List<float[]>();

            using (Stream objStream = typeof(ObjResourceReader).Assembly.GetManifestResourceStream("Szem5.Resources.cat.obj"))
            using (StreamReader objReader = new StreamReader(objStream))
            {
                while (!objReader.EndOfStream)
                {
                    var line = objReader.ReadLine();

                    if (String.IsNullOrEmpty(line) || line.Trim().StartsWith("#"))
                        continue;

                    var lineClassifier = line.Substring(0, line.IndexOf(' '));
                    var lineData = line.Substring(lineClassifier.Length).Trim().Split(' ');

                    switch (lineClassifier)
                    {
                        case "v":
                            float[] vertex = new float[3];
                            for (int i = 0; i < vertex.Length; ++i)
                                vertex[i] = float.Parse(lineData[i]);
                            objVertices.Add(vertex);
                            break;
                        case "vn":
                            float[] normal = new float[3];
                            for (int i = 0; i < normal.Length; ++i)
                                normal[i] = float.Parse(lineData[i]);
                            objNormals.Add(normal);
                            break;
                        case "f":
                            string[] face = new string[4];
                            for (int i = 0; i < face.Length; ++i)
                                face[i] = lineData[i];
                            objFaces.Add(face);
                            break;
                        case "vt":
                            float[] texture = new float[2];
                            for (int i = 0; i < texture.Length; ++i)
                            {
                                if (i == 1)
                                {
                                    texture[i] = 1 - float.Parse(lineData[i]);
                                }
                                else
                                {
                                    texture[i] = float.Parse(lineData[i]);
                                }
                            }
                            objTextures.Add(texture);
                            break;
                    }
                }
            }
        }
        
        private static unsafe void CreateGlArraysFromObjArraysIncludingTextures(List<float[]> objVertices, List<string[]> objFaces, 
            List<float[]> objNormals, List<float[]> objTextures, List<float> glVertices, List<uint> glIndices)
        {
            Dictionary<string, int> glVertexIndices = new Dictionary<string, int>();

            foreach (var objFaceString in objFaces)
            {
                for (int i = 0; i < objFaceString.Length; ++i)
                {
                    if (i != 1)
                    {
                        var objFace = objFaceString[i].Split('/');
                        var objVertex = objVertices[int.Parse(objFace[0]) - 1];

                        List<float> glVertex = new List<float>();
                        glVertex.AddRange(objVertex);

                        var objNormal = objNormals[int.Parse(objFace[2]) - 1];
                        glVertex.AddRange(objNormal);

                        var objTexture = objTextures[int.Parse(objFace[1]) - 1];
                        glVertex.AddRange(objTexture);

                        // check if vertex exists
                        var glVertexStringKey = string.Join(" ", glVertex);
                        if (!glVertexIndices.ContainsKey(glVertexStringKey))
                        {
                            glVertices.AddRange(glVertex);
                            glVertexIndices.Add(glVertexStringKey, glVertexIndices.Count);
                        }

                        // add vertex to triangle indices
                        glIndices.Add((uint)glVertexIndices[glVertexStringKey]);
                    }
                }

                for (int i = 0; i < objFaceString.Length; ++i)
                {
                    if (i != 3)
                    {
                        var objFace = objFaceString[i].Split('/');
                        var objVertex = objVertices[int.Parse(objFace[0]) - 1];

                        List<float> glVertex = new List<float>();
                        glVertex.AddRange(objVertex);

                        var objNormal = objNormals[int.Parse(objFace[2]) - 1];
                        glVertex.AddRange(objNormal);

                        var objTexture = objTextures[int.Parse(objFace[1]) - 1];
                        glVertex.AddRange(objTexture);

                        // check if vertex exists
                        var glVertexStringKey = string.Join(" ", glVertex);
                        if (!glVertexIndices.ContainsKey(glVertexStringKey))
                        {
                            glVertices.AddRange(glVertex);
                            glVertexIndices.Add(glVertexStringKey, glVertexIndices.Count);
                        }

                        // add vertex to triangle indices
                        glIndices.Add((uint)glVertexIndices[glVertexStringKey]);
                    }
                }
            }
        }
        private static unsafe GlObject CreateOpenGlObjectWithTexture(GL Gl, uint vao, List<float> glVertices, List<uint> glIndices)
        {
            uint offsetPos = 0;
            uint offsetNormal = offsetPos + (3 * sizeof(float));
            uint offsetTexture = offsetNormal + (3 * sizeof(float));
            uint vertexSize = offsetTexture + (2 * sizeof(float));

            uint vertices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ArrayBuffer, vertices);
            Gl.BufferData(GLEnum.ArrayBuffer, (ReadOnlySpan<float>)glVertices.ToArray().AsSpan(), GLEnum.StaticDraw);
            Gl.VertexAttribPointer(0, 3, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetPos);
            Gl.EnableVertexAttribArray(0);

            Gl.EnableVertexAttribArray(2);
            Gl.VertexAttribPointer(2, 3, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetNormal);

            uint colors = Gl.GenBuffer();

            uint texture = Gl.GenTexture();
            Gl.ActiveTexture(TextureUnit.Texture0);
            Gl.BindTexture(TextureTarget.Texture2D, texture);

            var catImage = GlCube.ReadTextureImage("cat.jpg");
            var textureBytes = (ReadOnlySpan<byte>)catImage.Data.AsSpan();

            Gl.TexImage2D(TextureTarget.Texture2D, 0, InternalFormat.Rgba, (uint)catImage.Width,
                (uint)catImage.Height, 0, PixelFormat.Rgba, PixelType.UnsignedByte, textureBytes);
            Gl.TexParameterI(TextureTarget.Texture2D, TextureParameterName.TextureWrapS, (int)TextureWrapMode.Repeat);
            Gl.TexParameterI(TextureTarget.Texture2D, TextureParameterName.TextureWrapT, (int)TextureWrapMode.Repeat);
            Gl.TexParameterI(TextureTarget.Texture2D, TextureParameterName.TextureMinFilter, (int)TextureMinFilter.Nearest);
            Gl.TexParameterI(TextureTarget.Texture2D, TextureParameterName.TextureMagFilter, (int)TextureMagFilter.Nearest);

            Gl.BindTexture(TextureTarget.Texture2D, 0);

            Gl.EnableVertexAttribArray(3);
            Gl.VertexAttribPointer(3, 2, VertexAttribPointerType.Float, false, vertexSize, (void*)offsetTexture);

            uint indices = Gl.GenBuffer();
            Gl.BindBuffer(GLEnum.ElementArrayBuffer, indices);
            Gl.BufferData(GLEnum.ElementArrayBuffer, (ReadOnlySpan<uint>)glIndices.ToArray().AsSpan(), GLEnum.StaticDraw);

            // release array buffer
            Gl.BindBuffer(GLEnum.ArrayBuffer, 0);
            uint indexArrayLength = (uint)glIndices.Count;

            return new GlObject(vao, vertices, colors, indices, indexArrayLength, Gl, texture);
        }
    }
}

