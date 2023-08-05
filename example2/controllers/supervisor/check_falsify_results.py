import numpy as np
import matplotlib.pyplot as plt

monolithic = []
compositional = []
for i in range(1, 11):
	s = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/scenario_results.csv", delimiter=",", names=True)
	s0W = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/subscenario0W_results.csv", delimiter=",", names=True)
	s0B = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/subscenario0B_results.csv", delimiter=",", names=True)
	s1 = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/subscenario1_results.csv", delimiter=",", names=True)
	s2L = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/subscenario2L_results.csv", delimiter=",", names=True)
	s2S = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/subscenario2S_results.csv", delimiter=",", names=True)
	s2R = np.genfromtxt("halton/falsify_csvs_" + str(i) + "/subscenario2R_results.csv", delimiter=",", names=True)
	monolithic.append(s["sim_steps"].sum())
	compositional.append(s0W["sim_steps"].sum() + s0B["sim_steps"].sum() + s1["sim_steps"].sum() + s2L["sim_steps"].sum() + s2S["sim_steps"].sum() + s2R["sim_steps"].sum())
	print("---- Sample", i, "----")
	print("Monolithic:", s["sim_steps"].sum())
	print("Compositional:", s0W["sim_steps"].sum() + s0B["sim_steps"].sum() + s1["sim_steps"].sum() + s2L["sim_steps"].sum() + s2S["sim_steps"].sum() + s2R["sim_steps"].sum())
	print("-----------------")

print("Monolithic:", np.mean(monolithic), np.std(monolithic))
print("Compositional:", np.mean(compositional), np.std(compositional))

for ss in ["scenario", "subscenario0W", "subscenario0B", "subscenario1", "subscenario2L", "subscenario2S", "subscenario2R"]:
	for i in range(1, 11):
		s = np.genfromtxt("random/falsify_csvs_" + str(i) + "/" + ss + "_post_conditions.csv", delimiter=",", skip_header=True)
		sems = []
		delta_sems = []
		previous_sem = None
		for i in range(2, np.size(s, axis=0)):
			sem = np.std(s[:i], ddof=1, axis=0) / np.sqrt(np.size(s[:i], axis=0))
			print("SEM:", sem)
			# print("Rounded:", np.round(sem, 5))
			sems.append(sem)
			delta_sem = None
			if previous_sem is not None:
				delta_sem = abs(sem - previous_sem)
				delta_sems.append(delta_sem)
			if delta_sem is not None and np.all(delta_sem <= 0.005):
				print("DELTA SEM:", delta_sem)
				input("HEY")
			previous_sem = sem
		# sems = np.array(sems)
		# plt.plot(sems)
		# plt.show()