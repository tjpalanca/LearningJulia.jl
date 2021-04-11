# Reinforcement Learning

Reinforcement Learning has always interested me because I work in very 
data-sparse domains, and I view reinforcement learning as a way to overcome 
those data limitations at times.

## ReinforcementLearning.jl

* There are tons of predefined experiments defined using the E string macro
* Components of each model
    * Stop Condition: Used to determine when to stop an experiment such as 
    `StopAfterStep` or `StopAfterEpisode`
    * Hook: two-way callbacks format. There are some such as 
    `TotalRewardPerEpisode` or `StepsPerEpisode` to then be able to log metrics
    or do other things.
    * Environment: dictates things that the agent interacts with.
* There's a whole new book `ReinforcementLearningAnIntroduction.jl` that has 
  some Pluto notebooks to play with 

