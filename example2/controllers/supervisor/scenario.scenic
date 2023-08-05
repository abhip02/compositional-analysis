from scenic.simulators.webots.model import WebotsObject

import numpy as np

MODE = None
with open("mode.txt", "r") as f:
    MODE = f.read()
assert MODE is not None

class Lead(WebotsObject):
    webotsName: "LEAD"

class Follower(WebotsObject):
    webotsName: "FOLLOWER"

class ObstacleL(WebotsObject):
    webotsName: "OBSTACLE"
    color: Options([[0.0, 0.0, 0.0],
                    [0.5, 0.0, 0.0],
                    [1.0, 0.0, 0.0],
                    [0.0, 0.5, 0.0],
                    [0.0, 1.0, 0.0],
                    [0.0, 0.0, 0.5],
                    [0.0, 0.0, 1.0],
                    [0.5, 0.5, 0.5],
                    [1.0, 1.0, 1.0]])

class ObstacleS(WebotsObject):
    webotsName: "OBSTACLE"
    color: Options([[0.0, 0.0, 0.0],
                    [0.5, 0.0, 0.0],
                    [1.0, 0.0, 0.0],
                    [0.0, 0.5, 0.0],
                    [0.0, 1.0, 0.0],
                    [0.0, 0.0, 0.5],
                    [0.0, 0.0, 1.0],
                    [0.5, 0.5, 0.5],
                    [1.0, 1.0, 1.0]])

class ObstacleR(WebotsObject):
    webotsName: "OBSTACLE"
    color: Options([[0.0, 0.0, 0.0],
                    [0.5, 0.0, 0.0],
                    [1.0, 0.0, 0.0],
                    [0.0, 0.5, 0.0],
                    [0.0, 1.0, 0.0],
                    [0.0, 0.0, 0.5],
                    [0.0, 0.0, 1.0],
                    [0.5, 0.5, 0.5],
                    [1.0, 1.0, 1.0]])

class OilBarrel1(WebotsObject):
    webotsName: "OIL_BARREL_1"

class OilBarrel2(WebotsObject):
    webotsName: "OIL_BARREL_2"

class OilBarrel3(WebotsObject):
    webotsName: "OIL_BARREL_3"

class Wall(WebotsObject):
    webotsName: "WALL"

class Scenario(WebotsObject):
    webotsName: "SCENARIO"
    ind: Options(["BL", "BS", "BR", "WL", "WS", "WR"])
    mode: MODE

s = Scenario

oil_barrel_1 = OilBarrel1 at Range(-115.0, -95.0) @ Range(-45.0, -30.0)
oil_barrel_2 = OilBarrel2 at Range(-115.0, -95.0) @ Range(-60.0, -45.0)
oil_barrel_3 = OilBarrel3 at Range(-115.0, -95.0) @ Range(-75.0, -60.0)

wall = Wall at Uniform(-110.5, -99.5) @ Range(-60.0, -30.0)

x_spaceL = list(np.linspace(10.5, 25.5, num=100))
y_spaceL = list(np.linspace(-54.5, -51.5, num=50)) + list(np.linspace(-38.5, -35.5, num=50))
obstacleL = ObstacleL at Uniform(*x_spaceL) @ Uniform(*y_spaceL)

x_spaceS = list(np.linspace(35.5, 38.5, num=50)) + list(np.linspace(51.5, 54.5, num=50))
y_spaceS = list(np.linspace(-25.5, -10.5, num=100))
obstacleS = ObstacleS at Uniform(*x_spaceS) @ Uniform(*y_spaceS)

x_spaceR = list(np.linspace(57.0, 67.0, num=100))
y_spaceR = list(np.linspace(-54.5, -51.5, num=50)) + list(np.linspace(-38.5, -35.5, num=50))
obstacleR = ObstacleR at Uniform(*x_spaceR) @ Uniform(*y_spaceR)

lead = Lead at Range(-106, -104) @ Range(-7.5, -3.5), facing Range(-95.0, -85.0) deg
ego = Follower at Range(-106, -104) @ Range(2.5, 6.5), facing Range(-95.0, -85.0) deg

