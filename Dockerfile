FROM ros:kinetic-ros-core

# Setup catkin workspace
ENV CATKIN_WS=/root/catkin_ws
RUN mkdir -p $CATKIN_WS/src/polar_bear_sim
WORKDIR $CATKIN_WS

# Copy over package.xml with dependencies
COPY package.xml src/polar_bear_sim

# Install dependencies with rosdep and apt-get
RUN rosdep update 2>/dev/null\
    && apt-get update \
    && rosdep install --from-paths src --ignore-src -r -y \
    && apt-get install python-catkin-tools -y \
    && rm -rf /var/lib/apt/lists/*

# Copy over and build Polar Bear Simulation Package
COPY . src/polar_bear_sim
RUN mkdir /opt/ros/polar_bear \
    && catkin config --init --extend /opt/ros/kinetic --install-space /opt/ros/polar_bear --install \
    && catkin build

# Clean up
RUN apt-get autoremove -y -o APT::Autoremove::RecommendsImportant=0 -o APT::Autoremove::SuggestsImportant=0

WORKDIR /
RUN sed -i "s/^source.*/source \/opt\/ros\/polar_bear\/setup.bash/" ros_entrypoint.sh
CMD ["roslaunch", "polar_bear_sim", "polar_bear_sim.launch"]