# simple_scenario.scenic

# Use 2D map
param map = "/Users/abhi/Documents/seshia_research/compositional-analysis/Scenic/assets/maps/CARLA/Town07.xodr"
speed = Uniform(5, 30)

# from scenic.simulators.metadrive.model import Car, Pedestrian
model scenic.simulators.metadrive.model

# Define the ego car
ego = new Car on road, with behavior FollowLaneBehavior(target_speed=speed)

# a lead car 20 m ahead (compute point, then project onto road), follow lane too
lead = new Car ahead of ego by 20, with behavior FollowLaneBehavior(target_speed=8)

record ego.speed as ego_speed

terminate after 3 seconds