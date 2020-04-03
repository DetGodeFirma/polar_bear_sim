# Simulator for Polar Bear
This is a Stage simulation of an omnidirectional robot like the kugle/polaris robot.
There is also a ROS move_base running with dwa_local_planner, and a map_server hosting a
pretend map (for now) of Combine A/S's offices.

Just build the Docker image and run it:
```
> docker build --tag polar_bear_sim .
> docker run -it --rm polar_bear_sim:latest
```
## Caution
This container is meant to work with a container with polar_bear. It is not much good to you without it.
