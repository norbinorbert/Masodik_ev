using Silk.NET.Maths;

namespace Projekt
{
    internal class CameraDescriptor
    {
        private static float leftBound = 15f;
        private static float rightBound = -15f;
        private static float topBound = 10f;
        private static float bottomBound = -10f;
        private static float offsetZfromCat = 1.2f;
        private static Vector3D<float> defaultPositon = new Vector3D<float>(0, 30, 0);
        private static Vector3D<float> defaultUpVector = new Vector3D<float>(0, 0, 1);
        private static Vector3D<float> defaultTarget = new Vector3D<float>(0, 0, 0);

        private Vector3D<float> position = defaultPositon;
        private Vector3D<float> upVector = defaultUpVector;
        private Vector3D<float> target = defaultTarget;

        private const float MoveSpeed = 0.5f;
        private const float RotateSpeed = MathF.PI / 20;
        private bool isfirstPerson = false;

        public Vector3D<float> Position => position;
        public Vector3D<float> UpVector => upVector;
        public Vector3D<float> Target => target;

        public void FirstPerson(Vector3D<float> catPosition)
        {
            isfirstPerson = true;
            position.X = catPosition.X;
            position.Y = catPosition.Y + 1f;
            position.Z = catPosition.Z + offsetZfromCat;
            target.X = position.X;
            target.Y = position.Y;
            target.Z = position.Z + 1;
            upVector.X = 0f;
            upVector.Y = 1f;
            upVector.Z = 0f;
        }

        public void TopDownView()
        {
            isfirstPerson = false;
            position = defaultPositon;
            target.X = position.X;
            target.Y = 0f;
            target.Z = position.Z;
            upVector.X = 0f;
            upVector.Y = 0f;
            upVector.Z = 1f;
        }

        public void MoveForward()
        {
            if (isfirstPerson && position.Z < topBound + offsetZfromCat)
            {
                position.Z += MoveSpeed;
                target.Z += MoveSpeed;
            }
            else if(isfirstPerson && position.Z >= topBound + offsetZfromCat)
            {
                position.Z = bottomBound + offsetZfromCat;
                target.Z = position.Z + 1;
            }
        }

        public void MoveBackward()
        {
            if (isfirstPerson && position.Z > bottomBound + offsetZfromCat)
            {
                position.Z -= MoveSpeed;
                target.Z -= MoveSpeed;
            }
        }

        public void MoveRight()
        {
            if (isfirstPerson && position.X > rightBound)
            {
                position.X -= MoveSpeed;
                target.X -= MoveSpeed;
            }
        }

        public void MoveLeft()
        {
            if (isfirstPerson && position.X < leftBound)
            {
                position.X += MoveSpeed;
                target.X += MoveSpeed;
            }
        }

        public void LookRight()
        {
            if (isfirstPerson)
            {
                var forward = Vector3D.Normalize(target - position);
                var rotation = Matrix4X4.CreateFromAxisAngle(upVector, -RotateSpeed);
                forward = Vector3D.Transform(forward, rotation);
                target = position + forward;
            }
        }

        public void LookLeft()
        {
            if (isfirstPerson)
            {
                var forward = Vector3D.Normalize(target - position);
                var rotation = Matrix4X4.CreateFromAxisAngle(upVector, RotateSpeed);
                forward = Vector3D.Transform(forward, rotation);
                target = position + forward;
            }
        }

        public void LookUp()
        {
            if (isfirstPerson)
            {
                var forward = Vector3D.Normalize(target - position);
                var right = Vector3D.Cross(forward, upVector);
                right = Vector3D.Normalize(right);
                var rotation = Matrix4X4.CreateFromAxisAngle(right, RotateSpeed);
                forward = Vector3D.Transform(forward, rotation);
                target = position + forward;
            }
        }

        public void LookDown()
        {
            if (isfirstPerson)
            {
                var forward = Vector3D.Normalize(target - position);
                var right = Vector3D.Cross(forward, upVector);
                right = Vector3D.Normalize(right);
                var rotation = Matrix4X4.CreateFromAxisAngle(right, -RotateSpeed);
                forward = Vector3D.Transform(forward, rotation);
                target = position + forward;
            }
        }

        public void PunishCat()
        {
            for (double i = 0; i < 5f; i += MoveSpeed)
            {
                MoveBackward();
            }
        }
    }
}
