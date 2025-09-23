This is a fork of the original [Compositional-Analysis](https://github.com/BerkeleyLearnVerify/compositional-analysis) repository.

### Current Progress:
- [example_metadrive](https://github.com/abhip02/compositional-analysis/tree/main/example_metadrive): Replace Scenic backend Webots with Metadrive to run a simulation. Connect VerifAI falsifier to Metadrive simulation using ScenicServer.
- [example_compositional](https://github.com/abhip02/compositional-analysis/tree/main/example_metadrive/example_compositional):
  - Create "trajectories" and "behaviors" within Scenic to simulate ego turning at intersections
  - Simulate 4-way intersection scenario with multiple "subscenarios"
    - Subscenario1: ego drives up towards the intersection
    - Subscenario2S: ego goes straight at the intersection
    - Subscenario2L: ego takes a left turn at the intersection
    - Subscenario2R: ego takes a right turn at the intersection
  - Subscenario2# samples from the "post_conditions" of Subscenario1:
    - Same as in the original compositional analysis repo: ego_heading, ego_x, ego_y, ego_speed
  - Notes:
    - not using "save state" mechanism in Metadrive, need to look into this
    - starting speed is 0, even though speed is sampled
    - should add "Follower" to ego; need to define a controller/behavior for this
   
- Next steps:
  - Metadrive save states with environment

### Notes:
- Currently built 'scenic' and 'metadrive-simulator' from source to avoid issues in conda env, should resolve this

### Useful Links:
[Scenic source code for metadrive.simulator](https://docs.scenic-lang.org/en/latest/_modules/scenic/simulators/metadrive/simulator.html)
