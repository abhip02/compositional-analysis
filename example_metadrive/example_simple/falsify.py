import os
from verifai.samplers import ScenicSampler
from verifai.falsifier import generic_falsifier
from verifai.scenic_server import ScenicServer
from verifai.monitor import specification_monitor
from dotmap import DotMap

# 1. Load scenario
scenario_path = os.path.abspath("simple_scenario.scenic")
sampler = ScenicSampler.fromScenario(scenario_path)

# 2. Spec: fail if speed > 20
class SpeedSpec(specification_monitor):
    def __init__(self):
        def spec(sim_result):
            # Get recorded speeds from Scenic result
            ego_speeds = sim_result.records.get("ego_speed", [])
            
            # DEBUG
            for name, value in vars(sim_result).items():
                print(f"{name}\n: {value}\n")
                print("")

            sampled_speed = ego_speeds[-1][-1]  # final speed value
            print(f"Simulation completed: speed={sampled_speed}")

            # Fail if sampled speed > 5
            return 0 if sampled_speed > 5 else 1
        super().__init__(spec)

# 3. Falsifier params
params = DotMap(
    n_iters=1,
    save_error_table=True,
    fal_thres=1
)

# 4. Create falsifier
falsifier = generic_falsifier(
    sampler=sampler,
    monitor=SpeedSpec(),
    falsifier_params=params,
    server_class=ScenicServer
)

# 5. Run falsifier (launches MetaDrive simulation each time)
falsifier.run_falsifier()

# DEBUG
df = falsifier.error_table
print(df.table)
