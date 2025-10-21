# TT-CableGen Dockerfile

#############################################################

# Use the published tt-metal base image instead of rebuilding
# This includes basic build tools (cmake, ninja, g++, mpi-ulfm)
FROM ghcr.io/tenstorrent/tt-metal/tt-metalium-ubuntu-22.04-release-amd64:latest AS base

#############################################################

FROM base AS dev

# Set up TT_METAL_HOME
# (PYTHON_ENV_DIR is already set in the base image)
ENV TT_METAL_HOME=/tt-metal

# Clone tt-metal
RUN /bin/bash -c "git clone --filter=blob:none --recurse-submodules --tags \
    https://github.com/tenstorrent/tt-metal.git ${TT_METAL_HOME} \
    && cd ${TT_METAL_HOME}"

WORKDIR ${TT_METAL_HOME}

COPY build_scaleout.sh ${TT_METAL_HOME}/build_scaleout.sh
RUN chmod +x ${TT_METAL_HOME}/build_scaleout.sh

WORKDIR ${TT_METAL_HOME}

RUN /bin/bash -c "${TT_METAL_HOME}/build_scaleout.sh --build-type Release --build-dir build_scaleout_Release"

# Expose ports for telemetry server
# Port 8080: Web server
# Port 8081: Intra-process websocket connections
EXPOSE 8080 8081

# Set the telemetry server as the entrypoint
# This allows passing command line arguments directly to docker run
ENTRYPOINT ["/bin/bash"]

#############################################################

