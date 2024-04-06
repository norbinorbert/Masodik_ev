using Silk.NET.Maths;

namespace Szem2
{
    internal class CubeArrangementModel
    {
        public bool CLOCKWISE = true, COUNTERCLOCKWISE = false, INSTANT = true, OVER_TIME = false;

        public bool RotationMode { get; set; }

        public bool AnimationEnabled { get; set; } = false;
        
        private double Time { get; set; } = 0;

        public double CenterCubeScale { get; private set; } = 1;

        private int[] indexes = new int[9];
        private int axis = 0;

        public double[] CubeAngleRevolutionX { get; private set; } = new double[27];
        public double[] CubeAngleRevolutionY { get; private set; } = new double[27];
        public double[] CubeAngleRevolutionZ { get; private set; } = new double[27];

        public double[] RotationAmountX { get; set; } = new double[27];
        public double[] RotationAmountY { get; set; } = new double[27];
        public double[] RotationAmountZ { get; set; } = new double[27];

        internal void AdvanceTime(double deltaTime, Cube[] cubes)
        {
            if (CubeSolved(cubes))
            {
                Time += deltaTime;

                CenterCubeScale = 1 + 0.001 * Math.Sin(Time);
            }
            else
            {
                CenterCubeScale = 1;
            }

            for (int i = 0; i < cubes.Length; i++)
            {
                cubes[i].Transformation *= Matrix4X4.CreateScale((float)CenterCubeScale);
            }

            if (!AnimationEnabled)
                return;

            if (RotationMode == CLOCKWISE)
            {
                for (int i = 0; i < indexes.Length; i++)
                {
                    switch (axis)
                    {
                        case 0:
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 250;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)Math.PI / 250);
                            if (CubeAngleRevolutionX[indexes[i]] > RotationAmountX[indexes[i]])
                            {
                                AnimationEnabled = false;
                            }
                            break;
                        case 1:
                            CubeAngleRevolutionY[indexes[i]] += Math.PI / 250;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)Math.PI / 250);
                            if (CubeAngleRevolutionY[indexes[i]] > RotationAmountY[indexes[i]])
                            {
                                AnimationEnabled = false;
                            }
                            break;
                        case 2:
                            CubeAngleRevolutionZ[indexes[i]] += Math.PI / 250;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)Math.PI / 250);
                            if (CubeAngleRevolutionZ[indexes[i]] > RotationAmountZ[indexes[i]])
                            {
                                AnimationEnabled = false;
                            }
                            break;
                    }
                }
            }
            else
            {
                for (int i = 0; i < indexes.Length; i++)
                {
                    switch (axis)
                    {
                        case 0:
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 250;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)-Math.PI / 250);
                            if (CubeAngleRevolutionX[indexes[i]] < RotationAmountX[indexes[i]])
                            {
                                AnimationEnabled = false;
                            }
                            break;
                        case 1:
                            CubeAngleRevolutionY[indexes[i]] -= Math.PI / 250;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)-Math.PI / 250);
                            if (CubeAngleRevolutionY[indexes[i]] < RotationAmountY[indexes[i]])
                            {
                                AnimationEnabled = false;
                            }
                            break;
                        case 2:
                            CubeAngleRevolutionZ[indexes[i]] -= Math.PI / 250;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)-Math.PI / 250);
                            if (CubeAngleRevolutionZ[indexes[i]] < RotationAmountZ[indexes[i]])
                            {
                                AnimationEnabled = false;
                            }
                            break;
                    }
                }
            }
        }

        internal bool CubeSolved(Cube[] cubes)
        {
            return XSideOk(cubes, -1) && XSideOk(cubes, 1) && YSideOk(cubes, -1) && YSideOk(cubes, 1) && ZSideOk(cubes, -1) && ZSideOk(cubes, 1);
        }

        private bool XSideOk(Cube[] cubes, int X)
        {
            Cube? tmpCube = null;
            for (int i = 0; i < 27; i++)
            {
                if (cubes[i].X == X)
                {
                    bool sameX = true;
                    bool sameY = true;
                    bool sameZ = true;
                    if (tmpCube == null)
                    {
                        tmpCube = cubes[i];
                    }
                    if (cubes[i].OrigX != tmpCube.OrigX)
                    {
                        sameX = false;
                    }
                    if (cubes[i].OrigY != tmpCube.OrigY)
                    {
                        sameY = false;
                    }
                    if (cubes[i].OrigZ != tmpCube.OrigZ)
                    {
                        sameZ = false;
                    }
                    if (!(sameX || sameY || sameZ))
                    {
                        return false;
                    }
                    Matrix4X4<float> tmp = cubes[i].Transformation - tmpCube.Transformation;
                    float sum = tmp.M11 * tmp.M11 + tmp.M12 * tmp.M12 + tmp.M13 * tmp.M13 + tmp.M14 * tmp.M14;
                    sum = sum + tmp.M21 * tmp.M21 + tmp.M22 * tmp.M22 + tmp.M23 * tmp.M23 + tmp.M24 * tmp.M24;
                    sum = sum + tmp.M31 * tmp.M31 + tmp.M32 * tmp.M32 + tmp.M33 * tmp.M33 + tmp.M34 * tmp.M34;
                    sum = sum + tmp.M41 * tmp.M41 + tmp.M42 * tmp.M42 + tmp.M43 * tmp.M43 + tmp.M44 * tmp.M44;
                    if (sum > 1e5)
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        private bool YSideOk(Cube[] cubes, int Y)
        {
            Cube? tmpCube = null;
            for (int i = 0; i < 27; i++)
            {
                if (cubes[i].Y == Y)
                {
                    bool sameX = true;
                    bool sameY = true;
                    bool sameZ = true;
                    if (tmpCube == null)
                    {
                        tmpCube = cubes[i];
                    }
                    if (cubes[i].OrigX != tmpCube.OrigX)
                    {
                        sameX = false;
                    }
                    if (cubes[i].OrigY != tmpCube.OrigY)
                    {
                        sameY = false;
                    }
                    if (cubes[i].OrigZ != tmpCube.OrigZ)
                    {
                        sameZ = false;
                    }
                    if (!(sameX || sameY || sameZ))
                    {
                        return false;
                    }
                    Matrix4X4<float> tmp = cubes[i].Transformation - tmpCube.Transformation;
                    float sum = tmp.M11 * tmp.M11 + tmp.M12 * tmp.M12 + tmp.M13 * tmp.M13 + tmp.M14 * tmp.M14;
                    sum = sum + tmp.M21 * tmp.M21 + tmp.M22 * tmp.M22 + tmp.M23 * tmp.M23 + tmp.M24 * tmp.M24;
                    sum = sum + tmp.M31 * tmp.M31 + tmp.M32 * tmp.M32 + tmp.M33 * tmp.M33 + tmp.M34 * tmp.M34;
                    sum = sum + tmp.M41 * tmp.M41 + tmp.M42 * tmp.M42 + tmp.M43 * tmp.M43 + tmp.M44 * tmp.M44;
                    if (sum > 1e5)
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        private bool ZSideOk(Cube[] cubes, int Z)
        {
            Cube? tmpCube = null;
            for (int i = 0; i < 27; i++)
            {
                if (cubes[i].Z == Z)
                {
                    bool sameX = true;
                    bool sameY = true;
                    bool sameZ = true;
                    if (tmpCube == null)
                    {
                        tmpCube = cubes[i];
                    }
                    if (cubes[i].OrigX != tmpCube.OrigX)
                    {
                        sameX = false;
                    }
                    if (cubes[i].OrigY != tmpCube.OrigY)
                    {
                        sameY = false;
                    }
                    if (cubes[i].OrigZ != tmpCube.OrigZ)
                    {
                        sameZ = false;
                    }
                    if (!(sameX || sameY || sameZ))
                    {
                        return false;
                    }
                    Matrix4X4<float> tmp = cubes[i].Transformation - tmpCube.Transformation;
                    float sum = tmp.M11 * tmp.M11 + tmp.M12 * tmp.M12 + tmp.M13 * tmp.M13 + tmp.M14 * tmp.M14;
                    sum = sum + tmp.M21 * tmp.M21 + tmp.M22 * tmp.M22 + tmp.M23 * tmp.M23 + tmp.M24 * tmp.M24;
                    sum = sum + tmp.M31 * tmp.M31 + tmp.M32 * tmp.M32 + tmp.M33 * tmp.M33 + tmp.M34 * tmp.M34;
                    sum = sum + tmp.M41 * tmp.M41 + tmp.M42 * tmp.M42 + tmp.M43 * tmp.M43 + tmp.M44 * tmp.M44;
                    if (sum > 1e5)
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        internal void RotateX1(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 0;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].X == -1)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountX[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountX[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].Y;
                        cubes[i].Y = multiplier * cubes[i].Z * (-1);
                        cubes[i].Z = multiplier * tmp;
                    }
                }
                if(speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateX2(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 0;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].X == 0)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountX[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountX[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].Y;
                        cubes[i].Y = multiplier * cubes[i].Z * (-1);
                        cubes[i].Z = multiplier * tmp;
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateX3(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 0;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].X == 1)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountX[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountX[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].Y;
                        cubes[i].Y = multiplier * cubes[i].Z * (-1);
                        cubes[i].Z = multiplier * tmp;
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationX((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateY1(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 1;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].Y == -1)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountY[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountY[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].X;
                        cubes[i].X = multiplier * cubes[i].Z;
                        cubes[i].Z = multiplier * tmp * (-1);
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateY2(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 1;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].Y == 0)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountY[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountY[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].X;
                        cubes[i].X = multiplier * cubes[i].Z;
                        cubes[i].Z = multiplier * tmp * (-1);
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateY3(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 1;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].Y == 1)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountY[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountY[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].X;
                        cubes[i].X = multiplier * cubes[i].Z;
                        cubes[i].Z = multiplier * tmp * (-1);
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationY((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateZ1(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 2;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].Z == -1)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountZ[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountZ[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].X;
                        cubes[i].X = multiplier * cubes[i].Y * (-1);
                        cubes[i].Y = multiplier * tmp;
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateZ2(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 2;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].Z == 0)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountZ[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountZ[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].X;
                        cubes[i].X = multiplier * cubes[i].Y * (-1);
                        cubes[i].Y = multiplier * tmp;
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }

        internal void RotateZ3(Cube[] cubes, bool mode, bool speed)
        {
            if (!AnimationEnabled)
            {
                axis = 2;
                int index = 0;
                RotationMode = mode;
                AnimationEnabled = true;
                int multiplier = 1;
                for (int i = 0; i < cubes.Length; i++)
                {
                    if (cubes[i].Z == 1)
                    {
                        indexes[index] = i;
                        index++;
                        if (RotationMode)
                        {
                            RotationAmountZ[i] += Math.PI / 2;
                        }
                        else
                        {
                            multiplier = -1;
                            RotationAmountZ[i] -= Math.PI / 2;
                        }
                        int tmp = cubes[i].X;
                        cubes[i].X = multiplier * cubes[i].Y * (-1);
                        cubes[i].Y = multiplier * tmp;
                    }
                }
                if (speed == INSTANT)
                {
                    for (int i = 0; i < indexes.Length; i++)
                    {
                        if (RotationMode == CLOCKWISE)
                        {
                            CubeAngleRevolutionX[indexes[i]] += Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)Math.PI / 2);
                        }
                        else
                        {
                            CubeAngleRevolutionX[indexes[i]] -= Math.PI / 2;
                            cubes[indexes[i]].Transformation *= Matrix4X4.CreateRotationZ((float)-Math.PI / 2);
                        }
                    }
                    AnimationEnabled = false;
                }
            }
        }
    }

}
