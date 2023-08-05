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

class Obstacle(WebotsObject):
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

class Subscenario(WebotsObject):
    webotsName: "SUBSCENARIO"
    ind: "1"
    mode: MODE

s = Subscenario

# oil_barrel_1 = OilBarrel1 at Range(-30.0, -10.0) @ Range(-115.0, -95.0)
# oil_barrel_2 = OilBarrel2 at Range(-10.0, 10.0) @ Range(-115.0, -95.0)
# oil_barrel_3 = OilBarrel3 at Range(10.0, 30.0) @ Range(-115.0, -95.0)

lead = Lead at Range(-56.5, -52.5) @ Range(-106, -104), facing Range(-5.0, 5.0) deg
ego = Follower at Range(-66.5, -62.5) @ Range(-106, -104), facing Range(-5.0, 5.0) deg
