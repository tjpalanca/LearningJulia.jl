# Reinforcement learning experiments

using ReinforcementLearning, Plots

experiment = E`JuliaRL_BasicDQN_CartPole`

experiment.stop_condition

run(experiment)

plot(experiment.hook.hooks[1].rewards; title = "Total Reward per Episode")
plot(experiment.hook.hooks[2].times; title = "Time Per Step")

experiment.env