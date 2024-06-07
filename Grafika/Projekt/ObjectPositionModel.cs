using Silk.NET.Maths;

namespace Projekt
{
    internal class ObjectPositionModel
    {
        private static float leftBound = 15f;
        private static float rightBound = -15f;
        private static float topBound = 10f;
        private static float bottomBound = -10f;
        private static float movementSpeed = 0.5f;
        private static float obstacleMoveSpeed = 0.1f;

        public Vector3D<float> catPosition;
        public Vector3D<float>[] obstaclePositions;
        private bool[] direction;

        private Random random = new();

        public ObjectPositionModel()
        {
            catPosition = new Vector3D<float>(0f, 0f, bottomBound);
            obstaclePositions = new Vector3D<float>[4];
            direction = new bool[4];
            for (int i = 0; i < 4; i++)
            {
                direction[i] = random.Next() % 2 == 0;
            }
            obstaclePositions[0] = new Vector3D<float>((float)random.NextDouble() * (leftBound - rightBound) + rightBound, 0.5f, -7.4f);
            obstaclePositions[1] = new Vector3D<float>((float)random.NextDouble() * (leftBound - rightBound) + rightBound, 0.5f, -2f);
            obstaclePositions[2] = new Vector3D<float>((float)random.NextDouble() * (leftBound - rightBound) + rightBound, 0.5f, 4.2f);
            obstaclePositions[3] = new Vector3D<float>((float)random.NextDouble() * (leftBound - rightBound) + rightBound, 0.5f, 6.3f);
        }

        public double AdvanceTime()
        {
            double point = 0;
            if(catPosition.X > leftBound)
            {
                catPosition.X = leftBound;
            }
            if(catPosition.X < rightBound)
            {
                catPosition.X = rightBound;
            }
            if(catPosition.Z < bottomBound)
            {
                catPosition.Z = bottomBound;
            }
            if(catPosition.Z > topBound)
            {
                catPosition.Z = bottomBound;
                point = 1;
            }
            for (int i = 0; i < obstaclePositions.Length; i++)
            {
                if (direction[i] && obstaclePositions[i].X >= leftBound)
                {
                    direction[i] = !direction[i];
                    obstaclePositions[i].X -= obstacleMoveSpeed;
                }
                if (direction[i] && obstaclePositions[i].X < leftBound)
                {
                    obstaclePositions[i].X += obstacleMoveSpeed;
                }
                if (!direction[i] && obstaclePositions[i].X <= rightBound)
                {
                    direction[i] = !direction[i];
                    obstaclePositions[i].X += obstacleMoveSpeed;
                }
                if (!direction[i] && obstaclePositions[i].X > rightBound)
                {
                    obstaclePositions[i].X -= obstacleMoveSpeed;
                }
            }
            return point;
        }

        public void MoveForward()
        {
            catPosition.Z += movementSpeed;
        }

        public void MoveBackward()
        {
            catPosition.Z -= movementSpeed;
        }

        public void MoveLeft()
        {
            catPosition.X += movementSpeed;
        }

        public void MoveRight()
        {
            catPosition.X -= movementSpeed;
        }

        public void PunishCat()
        {
            catPosition.Z -= 5f;
        }
    }
}
