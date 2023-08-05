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

wall_samples = np.genfromtxt(MODE + "_csvs/subscenario0W_post_conditions.csv", delimiter=",", names=True)
barrel_samples = np.genfromtxt(MODE + "_csvs/subscenario0B_post_conditions.csv", delimiter=",", names=True)

samples = np.concatenate((wall_samples, barrel_samples), axis=0)

sample = Uniform(*samples)

ego = Follower at sample[0] @ sample[1], facing sample[2]*57.2958 deg
lead = Lead at sample[3] @ sample[4], facing sample[5]*57.2958 deg
