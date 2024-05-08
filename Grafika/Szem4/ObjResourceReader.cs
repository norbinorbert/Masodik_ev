using Silk.NET.Maths;
using Silk.NET.OpenGL;
using System.Xml;
using System.Xml.Linq;

namespace Szem4
{
    internal class ObjResourceReader
    {
        public static unsafe GlObject CreateTeapotWithColor(GL Gl, float[] faceColor)
        {
            uint vao = Gl.GenVertexArray();
            Gl.BindVertexArray(vao);

            List<float[]> objVertices;
            List<int[]> objFaces;
            List<float[]> objNormals;

            ReadColladaData(out objVertices, out objFaces, out objNormals);

            List<float> glVertices = new List<float>();
            List<float> glColors = new List<float>();
            List<uint> glIndices = new List<uint>();

            CreateGlArraysFromObjArrays(faceColor, objVertices, objFaces, objNormals, glVertices, glColors, glIndices);

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

        private static unsafe void CreateGlArraysFromObjArrays(float[] faceColor, List<float[]> objVertices, List<int[]> objFaces, List<float[]> objNormals,
            List<float> glVertices, List<float> glColors, List<uint> glIndices)
        {
            Dictionary<string, int> glVertexIndices = new Dictionary<string, int>();

            foreach (var objFace in objFaces)
            {
                // process 3 vertices
                for (int i = 0; i < objFace.Length / 2; ++i)
                {
                    var objVertex = objVertices[objFace[i] - 1];

                    // create gl description of vertex
                    List<float> glVertex = new List<float>();
                    glVertex.AddRange(objVertex);

                    var objNormal = objNormals[objFace[i + 3] - 1];
                    glVertex.AddRange(objNormal);

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

        private static unsafe void ReadColladaData(out List<float[]> objVertices, out List<int[]> objFaces, out List<float[]> objNormals)
        {
            objVertices = new List<float[]>();
            objFaces = new List<int[]>();
            objNormals = new List<float[]>();

            Stream objStream = System.Reflection.Assembly.GetExecutingAssembly().GetManifestResourceStream("Szem4.Resources.man.dae");
            XmlDocument document = new XmlDocument();
            document.Load(objStream);

            // vertexes and normals are in float_array tag
            XmlNodeList xmlNodeList = document.GetElementsByTagName("float_array");

            foreach (XmlNode xmlNode in xmlNodeList)
            {
                XmlAttributeCollection attributeCollection = xmlNode.Attributes;
                XmlNode idAttribute = attributeCollection.GetNamedItem("id");
                string id = idAttribute.InnerText;

                //naming convention: position for vertex, normal for normal
                if (id.Contains("position"))
                {
                    string[] values = xmlNode.InnerText.Split(' ');
                    for (int i = 0; i < values.Length; i += 3)
                    {
                        float[] vertex = new float[3];
                        for (int j = 0; j < 3; j++)
                            vertex[j] = float.Parse(values[i + j]); ;
                        objVertices.Add(vertex);
                    }
                }
                else if (id.Contains("normal"))
                {
                    string[] values = xmlNode.InnerText.Split(' ');
                    for (int i = 0; i < values.Length; i += 3)
                    {
                        float[] normal = new float[3];
                        for (int j = 0; j < 3; j++)
                            normal[j] = float.Parse(values[i + j]); ;
                        objNormals.Add(normal);
                    }
                }
            }

            //triangles tag contains the face indexes
            xmlNodeList = document.GetElementsByTagName("triangles")[0].ChildNodes;
            foreach (XmlNode xmlNode in xmlNodeList)
            {
                if (xmlNode.Name == "p")
                {
                    string[] values = xmlNode.InnerText.Split(' ');
                    for (int i = 0; i < values.Length; i += 9)
                    {
                        // face contains 9 values, we only use 6 (3 vertexes and 3 normals)
                        int[] face = new int[6];
                        for (int j = 0; j < 9; j += 3)
                        {
                            face[j / 3] = int.Parse(values[i + j]) + 1;
                            face[j / 3 + 3] = int.Parse(values[i + j + 1]) + 1;
                        }
                        objFaces.Add(face);
                    }
                }
            }
        }
    }
}