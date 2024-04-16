using Silk.NET.Maths;

namespace Szeminarium1_24_02_17_2
{
    internal class CameraDescriptor
    {
        private Vector3D<float> position = new Vector3D<float>(0, -0.5f, 12);
        private Vector3D<float> upVector = new Vector3D<float>(0, 1, 0);
        private Vector3D<float> target = new Vector3D<float>(0, -0.5f, 0);

        private const float MoveSpeed = 0.5f;
        private const float RotateSpeed = MathF.PI / 20;

        public Vector3D<float> Position => position;
        public Vector3D<float> UpVector => upVector;
        public Vector3D<float> Target => target;

        public void MoveForward()
        {
            var forward = Vector3D.Normalize(target - position);
            position += forward * MoveSpeed;
            target += forward * MoveSpeed;
        }

        public void MoveBackward()
        {
            var forward = Vector3D.Normalize(target - position);
            position -= forward * MoveSpeed;
            target -= forward * MoveSpeed;
        }

        public void MoveRight()
        {
            var right = Vector3D.Cross(target - position, upVector);
            right = Vector3D.Normalize(right);
            position += right * MoveSpeed;
            target += right * MoveSpeed;
        }

        public void MoveLeft()
        {
            var right = Vector3D.Cross(target - position, upVector);
            right = Vector3D.Normalize(right);
            position -= right * MoveSpeed;
            target -= right * MoveSpeed;
        }

        public void MoveUp()
        {
            position += upVector * MoveSpeed;
            target += upVector * MoveSpeed;
        }

        public void MoveDown()
        {
            position -= upVector * MoveSpeed;
            target -= upVector * MoveSpeed;
        }

        public void LookRight()
        {
            var forward = Vector3D.Normalize(target - position);
            var rotation = Matrix4X4.CreateFromAxisAngle(upVector, -RotateSpeed);
            forward = Vector3D.Transform(forward, rotation);
            target = position + forward;
        }

        public void LookLeft()
        {
            var forward = Vector3D.Normalize(target - position);
            var rotation = Matrix4X4.CreateFromAxisAngle(upVector, RotateSpeed);
            forward = Vector3D.Transform(forward, rotation);
            target = position + forward;
        }

        public void LookUp()
        {
            var forward = Vector3D.Normalize(target - position);
            var right = Vector3D.Cross(forward, upVector);
            right = Vector3D.Normalize(right);
            var rotation = Matrix4X4.CreateFromAxisAngle(right, RotateSpeed);
            forward = Vector3D.Transform(forward, rotation);
            upVector = Vector3D.Transform(upVector, rotation);
            target = position + forward;
        }

        public void LookDown()
        {
            var forward = Vector3D.Normalize(target - position);
            var right = Vector3D.Cross(forward, upVector);
            right = Vector3D.Normalize(right);
            var rotation = Matrix4X4.CreateFromAxisAngle(right, -RotateSpeed);
            forward = Vector3D.Transform(forward, rotation);
            upVector = Vector3D.Transform(upVector, rotation);
            target = position + forward;
        }
    }
}
