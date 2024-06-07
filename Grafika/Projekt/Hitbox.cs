using Silk.NET.Maths;

namespace Projekt
{
    internal class Hitbox
    {
        private Vector3D<float> defaultBottomCorner;
        private Vector3D<float> defaultTopCorner;

        private Vector3D<float> bottomCorner;
        private Vector3D<float> topCorner;

        public Hitbox(Vector3D<float> bottomCorner, Vector3D<float> topCorner)
        {
            this.bottomCorner = bottomCorner;
            this.topCorner = topCorner;
            defaultBottomCorner = bottomCorner;
            defaultTopCorner = topCorner;
        }

        public bool Intersects(Hitbox other)
        {
            bool xOverlap = bottomCorner.X < other.topCorner.X && topCorner.X > other.bottomCorner.X;

            bool yOverlap = bottomCorner.Y < other.topCorner.Y && topCorner.Y > other.bottomCorner.Y;

            bool zOverlap = bottomCorner.Z < other.topCorner.Z && topCorner.Z > other.bottomCorner.Z;

            return xOverlap && yOverlap && zOverlap;
        }

        public void UpdateHitbox(Matrix4X4<float> transformation)
        {
            Vector4D<float> bottom = new(defaultBottomCorner, 1);
            bottom = Vector4D.Multiply(bottom, transformation);
            bottomCorner = new Vector3D<float>(bottom.X, bottom.Y, bottom.Z);

            Vector4D<float> top = new(defaultTopCorner, 1);
            top = Vector4D.Multiply(top, transformation);
            topCorner = new Vector3D<float>(top.X, top.Y, top.Z);

            if (bottomCorner.X > topCorner.X)
            {
                var tmp = bottomCorner.X;
                bottomCorner.X = topCorner.X;
                topCorner.X = tmp;
            }
            if (bottomCorner.Y > topCorner.Y)
            {
                var tmp = bottomCorner.Y;
                bottomCorner.Y = topCorner.Y;
                topCorner.Y = tmp;
            }
            if (bottomCorner.Z > topCorner.Z)
            {
                var tmp = bottomCorner.Z;
                bottomCorner.Z = topCorner.Z;
                topCorner.Z = tmp;
            }
        }
    }
}
