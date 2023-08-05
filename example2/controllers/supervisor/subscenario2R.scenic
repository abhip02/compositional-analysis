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

class Subscenario(WebotsObject):
    webotsName: "SUBSCENARIO"
    ind: "2R"
    mode: MODE

s = Subscenario

x_space = list(np.linspace(57.0, 67.0, num=100))
y_space = list(np.linspace(-54.5, -51.5, num=50)) + list(np.linspace(-38.5, -35.5, num=50))
obstacle = ObstacleR at Uniform(*x_space) @ Uniform(*y_space)

samples = np.genfromtxt(MODE + "_csvs/subscenario1_post_conditions.csv", delimiter=",", names=True)
sample = Uniform(*samples)

ego = Follower at sample[0] @ sample[1], facing sample[2]*57.2958 deg
lead = Lead at sample[3] @ sample[4], facing sample[5]*57.2958 deg
