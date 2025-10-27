import warnings
warnings.filterwarnings("ignore", message="pkg_resources is deprecated")

import os
import argparse
from metadrive import MetaDriveEnv
from metadrive.policy.expert_policy import ExpertPolicy

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Test ExpertPolicy in MetaDrive")
    parser.add_argument("--seed", type=int, default=0, help="Random seed for reproducibility")
    parser.add_argument("--save-dir", type=str, default="storage", help="Directory to save GIFs")
    parser.add_argument("--n", type=int, default=10, help="Number of episodes to run")
    parser.add_argument("--scenario", type=str, default="XX", help="Scenario/map name")
    parser.add_argument("--gif", action="store_true", help="Generate top-down GIFs of episodes")
    args = parser.parse_args()

    os.makedirs(args.save_dir, exist_ok=True)

    # Create environment
    env = MetaDriveEnv(dict(
        map=args.scenario,
        use_render=False,   # You can enable rendering for visualization
        horizon=1000,
        traffic_density=0.1
    ))

    gif_enabled = args.gif
    trace_id = 0

    for ep in range(args.n):
        print(f"\n=== Episode {ep + 1}/{args.n} ===")
        obs, info = env.reset()

        # Expert policy is initialized on the current vehicle
        policy = ExpertPolicy(env.vehicle)

        done = False
        total_reward = 0.0

        while not done:
            # Get expert action
            action = policy.act()

            # Step the environment
            obs, reward, terminated, truncated, info = env.step(action)
            done = terminated or truncated
            total_reward += reward

            # Optional: render each step for GIF
            if gif_enabled:
                env.render(mode="topdown", screen_record=True, window=False)

        print(f"Episode {ep + 1} finished with reward {total_reward:.2f}")

        if gif_enabled:
            gif_path = os.path.join(args.save_dir, f"expert_trace_{trace_id:03d}.gif")
            env.top_down_renderer.generate_gif(gif_path)
            print(f"Saved gif to {gif_path}")
            trace_id += 1

    env.close()
