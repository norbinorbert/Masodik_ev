using Silk.NET.Maths;
using Silk.NET.OpenGL;

namespace Projekt
{
    internal class ObjResourceReader
    {
        private static Vector3D<float> bottomCorner = new();
        private static Vector3D<float> topCorner = new();

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

            CreateGlArraysFromObjArrays(objVertices, objFaces, objNormals, objTextures, glVertices, glIndices);

            return CreateOpenGlObject(Gl, vao, glVertices, glIndices);
        }

        private static unsafe void ReadObjDataForCat(out List<float[]> objVertices, out List<string[]> objFaces,
            out List<float[]> objNormals, out List<float[]> objTextures)
        {
            objVertices = new List<float[]>();
            objFaces = new List<string[]>();
            objNormals = new List<float[]>();
            objTextures = new List<float[]>();

            using (Stream objStream = typeof(ObjResourceReader).Assembly.GetManifestResourceStream("Projekt.Resources.cat.obj"))
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
                            {
                                vertex[i] = float.Parse(lineData[i]);
                                if (i == 0)
                                {
                                    topCorner.X = Math.Max(topCorner.X, vertex[i]);
                                    bottomCorner.X = Math.Min(bottomCorner.X, vertex[i]);
                                }
                                if (i == 1)
                                {
                                    topCorner.Y = Math.Max(topCorner.Y, vertex[i]);
                                    bottomCorner.Y = Math.Min(bottomCorner.Y, vertex[i]);
                                }
                                if (i == 2)
                                {
                                    topCorner.Z = Math.Max(topCorner.Z, vertex[i]);
                                    bottomCorner.Z = Math.Min(bottomCorner.Z, vertex[i]);
                                }
                            }
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

        private static unsafe void CreateGlArraysFromObjArrays(List<float[]> objVertices, List<string[]> objFaces,
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

                        var glVertexStringKey = string.Join(" ", glVertex);
                        if (!glVertexIndices.ContainsKey(glVertexStringKey))
                        {
                            glVertices.AddRange(glVertex);
                            glVertexIndices.Add(glVertexStringKey, glVertexIndices.Count);
                        }

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

                        var glVertexStringKey = string.Join(" ", glVertex);
                        if (!glVertexIndices.ContainsKey(glVertexStringKey))
                        {
                            glVertices.AddRange(glVertex);
                            glVertexIndices.Add(glVertexStringKey, glVertexIndices.Count);
                        }

                        glIndices.Add((uint)glVertexIndices[glVertexStringKey]);
                    }
                }
            }
        }

        private static unsafe GlObject CreateOpenGlObject(GL Gl, uint vao, List<float> glVertices, List<uint> glIndices)
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

            Gl.BindBuffer(GLEnum.ArrayBuffer, 0);
            uint indexArrayLength = (uint)glIndices.Count;

            Hitbox hitbox = new Hitbox(bottomCorner, topCorner);

            return new GlObject(vao, vertices, colors, indices, indexArrayLength, Gl, texture, hitbox);
        }
    }
}

