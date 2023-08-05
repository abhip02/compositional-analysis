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

class Scenario(WebotsObject):
    webotsName: "SCENARIO"
    ind: "L"
    mode: MODE







scenario L():
    setup:
        x_space = list(np.linspace(10.5, 25.5, num=100))
        y_space = list(np.linspace(-54.5, -51.5, num=50)) + list(np.linspace(-38.5, -35.5, num=50))
        obstacle = Obstacle at Uniform(*x_space) @ Uniform(*y_space)

scenario S():
    setup:
        x_space = list(np.linspace(35.5, 38.5, num=50)) + list(np.linspace(51.5, 54.5, num=50))
        y_space = list(np.linspace(-25.5, -10.5, num=100))
        obstacle = Obstacle at Uniform(*x_space) @ Uniform(*y_space)

scenario R():
    setup:
        x_space = list(np.linspace(57.0, 67.0, num=100))
        y_space = list(np.linspace(-54.5, -51.5, num=50)) + list(np.linspace(-38.5, -35.5, num=50))
        obstacle = Obstacle at Uniform(*x_space) @ Uniform(*y_space)

scenario Main():
    setup:
        s = Scenario
        lead = Lead at Range(-56.5, -52.5) @ Range(-106, -104), facing Range(-5.0, 5.0) deg
        ego = Follower at Range(-66.5, -62.5) @ Range(-106, -104), facing Range(-5.0, 5.0) deg
    compose:
        while True:
            do subScenario








