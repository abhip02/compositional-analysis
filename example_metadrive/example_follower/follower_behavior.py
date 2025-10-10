import math
import numpy as np
from scenic.core.dynamics.behaviors import Behavior
# Scenic PID controllers
from scenic.domains.driving.controllers import PIDLongitudinalController, PIDLateralController
from scenic.domains.driving.actions import SetSpeedAction, SetSteerAction, SetThrottleAction, SetBrakeAction

class Follower(Behavior):
    def __init__(self, ego, target_distance=0.0):
        super().__init__()
        # define default preconditions/invariants manually
        self.checkPreconditions = lambda agent, *args, **kwargs: True
        self.checkInvariants = lambda agent, *args, **kwargs: True
        
        # references
        self.target_distance = target_distance
        self.trajectory_points = []
            
        # controllers
        self.speed_pid = PIDLongitudinalController()
        self.steer_pid = PIDLateralController()
        

    # Scenic will call this automatically
    def makeGenerator(self, agent):
        while True:
            from scenic.syntax.veneer import currentScenario
            ego = currentScenario.ego  # dynamic access
            
            # --- Longitudinal control ---
            ego_speed = ego.speed
            speed_error = (ego_speed - agent.speed)
            throttle = self.speed_pid.run_step(speed_error)
            
            throttle_action = SetThrottleAction(throttle) if throttle >= 0 else SetBrakeAction(abs(throttle))
            
            ego_pos = ego.position
            self.trajectory_points.append((ego_pos.x, ego_pos.y))
            
            pts = np.asarray(self.trajectory_points)
            diffs = pts - np.array([agent.position.x, agent.position.y])
            dists = np.linalg.norm(diffs, axis=1)
            idx = np.argmin(dists)
            nearest_point = pts[idx]
            
            # estimate tangent using next point (or previous if last)
            if idx < len(pts) - 1:
                tangent = pts[idx + 1] - pts[idx]
            else:
                tangent = pts[idx] - pts[idx - 1]
                
            # compute signed cross product
            cross_z = tangent[0]*(agent.position.y - nearest_point[1]) - tangent[1]*(agent.position.x - nearest_point[0])
            sign = np.sign(cross_z)
            cte = dists[idx] * sign

            # --- Lateral control ---
            steer = self.steer_pid.run_step(cte) if len(pts) > 25 else 0
            
            
            yield (throttle_action, SetSteerAction(steer))
            