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

class Subscenario(WebotsObject):
    webotsName: "SUBSCENARIO"
    ind: "0B"
    mode: MODE

s = Subscenario

oil_barrel_1 = OilBarrel1 at Range(-115.0, -95.0) @ Range(-45.0, -30.0)
oil_barrel_2 = OilBarrel2 at Range(-115.0, -95.0) @ Range(-60.0, -45.0)
oil_barrel_3 = OilBarrel3 at Range(-115.0, -95.0) @ Range(-75.0, -60.0)

lead = Lead at Range(-106, -104) @ Range(-7.5, -3.5), facing Range(-95.0, -85.0) deg
ego = Follower at Range(-106, -104) @ Range(2.5, 6.5), facing Range(-95.0, -85.0) deg

