import numpy as np
import queue
from matplotlib import pyplot as plt

MAX_X = 100
MAX_Y = 100


class Point:
    def __init__(self, x=0, y=0, z=0.0, b=1):
        self.x = x
        self.y = y
        self.z = z
        self.b = b
        self.parent = (np.inf, np.inf)
        self.distance_from_source = np.inf
        self.heuristic_distance = np.inf
        self.total = (self.distance_from_source + self.heuristic_distance)
        self.done = False


def valid_coordinates(x, y):
    return 0 <= x < MAX_X and 0 <= y < MAX_Y


def distance(a: Point, b: Point):
    return np.sqrt((a.x - b.x) ** 2 + (a.y - b.y) ** 2 + (a.z - b.z) ** 2)


def distance2(a: Point, b: Point):
    return max(abs(a.x - b.x), abs(a.y - b.y))


def route(matrix: list, source: Point, destination: Point):
    tmp = [(destination.x, destination.y)]
    while source != destination:
        tmp.append(destination.parent)
        x = destination.parent[0]
        y = destination.parent[1]
        destination = matrix[x][y]
    tmp.reverse()
    return tmp


def a_star(matrix: list, source: Point, destination: Point, distance_function, output):
    pq = queue.PriorityQueue()

    source.distance_from_source = 0
    source.heuristic_distance = 0
    source.total = 0

    # needed for priority queue comparing
    number = 0
    pq.put((source.total, number, source))
    number = number + 1
    directions = [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]
    while not pq.empty():
        _, _, point = pq.get()
        if point.done:
            continue
        point.done = True
        if point == destination:
            break

        for i in directions:
            x = point.x + i[0]
            y = point.y + i[1]
            if not ((valid_coordinates(x, y)) and (matrix[x][y].b != 1) and (matrix[x][y].done is False)):
                continue

            new_point = matrix[x][y]
            new_distance = distance_function(point, new_point) + point.distance_from_source
            new_heuristic = distance_function(new_point, destination)
            new_total = new_distance + new_heuristic

            if new_total < new_point.total:
                new_point.parent = (point.x, point.y)
                new_point.distance_from_source = new_distance
                new_point.heuristic = new_heuristic
                new_point.total = new_total

                pq.put((new_total, number, new_point))
                number = number + 1

    output.write(str(destination.distance_from_source) + "\n")
    output.write(str(route(matrix, source, destination)))


def solve(input_file, endpoints, output, distance_function):
    matrix = [[Point() for _ in range(MAX_Y)] for _ in range(MAX_X)]
    file = open(input_file, "r")
    while 1:
        line = file.readline().split()
        if not line:
            break
        x = int(line[0])
        y = int(line[1])
        z = float(line[2])
        b = int(line[3])
        matrix[x][y] = Point(x, y, z, b)
    file.close()

    file = open(endpoints, "r")
    line = file.readline().split()
    source = matrix[int(line[0])][int(line[1])]
    line = file.readline().split()
    destination = matrix[int(line[0])][int(line[1])]
    file.close()

    file = open(output, "w")
    a_star(matrix, source, destination, distance_function, file)
    file.close()
    route1 = route(matrix, source, destination)
    return matrix, route1


matrix, route1 = solve("surface_100x100.txt", "surface_100x100.end_points.txt",
                       "output_a.txt", distance)
route1_x = [i[0] for i in route1]
route1_y = [i[1] for i in route1]
route1_z = [matrix[i[0]][i[1]].z for i in route1]

matrix, route2 = solve("surface_100x100.txt", "surface_100x100.end_points.txt",
                       "output_b.txt", distance2)
route2_x = [i[0] for i in route2]
route2_y = [i[1] for i in route2]
route2_z = [matrix[i[0]][i[1]].z for i in route2]

# opcionalis feladat
# 3D felulet, akadalyokkal
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
x_coord = [point.x for row in matrix for point in row if point.b == 0]
y_coord = [point.y for row in matrix for point in row if point.b == 0]
z_coord = [point.z for row in matrix for point in row if point.b == 0]
ax.scatter(x_coord, y_coord, z_coord, c="white", marker='.')
x_coord_obstacle = [point.x for row in matrix for point in row if point.b == 1]
y_coord_obstacle = [point.y for row in matrix for point in row if point.b == 1]
z_coord_obstacle = [point.z for row in matrix for point in row if point.b == 1]
ax.scatter(x_coord_obstacle, y_coord_obstacle, z_coord_obstacle, c="red", marker='o')
ax.scatter(route1_x, route1_y, route1_z, c='blue', marker='o')
ax.scatter(route2_x, route2_y, route2_z, c='black', marker='o')

# 2D heatmap
fig = plt.figure()
fig.add_subplot()
plt.scatter(x_coord, y_coord, z_coord, c=z_coord)
plt.scatter(route1_x, route1_y, route1_z, c='blue', marker='.')
plt.scatter(route2_x, route2_y, route2_z, c='black', marker='.')
plt.scatter(x_coord_obstacle, y_coord_obstacle, z_coord_obstacle, c="red", marker='.')

# 3D heatmap
fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.scatter(x_coord, y_coord, z_coord, c=z_coord, marker='.')
ax.scatter(route1_x, route1_y, route1_z, color='blue', marker='o')
ax.scatter(route2_x, route2_y, route2_z, color='black', marker='o')
ax.scatter(x_coord_obstacle, y_coord_obstacle, z_coord_obstacle, color="red", marker='o')
plt.show()





# # opcionalis feladat
# # 3D felulet, akadalyokkal
# x_coord = [point.x for row in matrix for point in row if point.b == 0]
# y_coord = [point.y for row in matrix for point in row if point.b == 0]
# z_coord = [point.z for row in matrix for point in row if point.b == 0]
# normal = go.Scatter3d(x=x_coord, y=y_coord, z=z_coord, mode='markers', marker=dict(size=5, color='white', opacity=0.8))
# x_coord = [point.x for row in matrix for point in row if point.b == 1]
# y_coord = [point.y for row in matrix for point in row if point.b == 1]
# z_coord = [point.z for row in matrix for point in row if point.b == 1]
# obstacles = go.Scatter3d(x=x_coord, y=y_coord, z=z_coord, mode='markers', marker=dict(size=5, color='red'))
# route1 = go.Scatter3d(x=route1_x, y=route1_y, z=route1_z, mode='markers', marker=dict(size=5, color='blue'))
# route2 = go.Scatter3d(x=route2_x, y=route2_y, z=route2_z, mode='markers', marker=dict(size=5, color='black'))
# fig = go.Figure([normal, obstacles, route1, route2])
# fig.show()
#
# # 2D heatmap
# x_coord = [point.x for row in matrix for point in row]
# y_coord = [point.y for row in matrix for point in row]
# z_coord = [point.z for row in matrix for point in row]
# normal = go.Scatter(x=x_coord, y=y_coord, marker=dict(color=z_coord))
# fig = go.Figure(normal)
# fig.show()
# # 3D heatmap
# ax.scatter(x_coord, y_coord, z_coord, c=z_coord)
# ax.scatter(route1_x, route1_y, route1_z, color='blue', marker='o')
# ax.scatter(route2_x, route2_y, route2_z, color='black', marker='o')
# plt.show()
