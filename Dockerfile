# AWS provided base image (Amazon Linux 2)
# It includes Lambda Runtime Emulator for testing locally.
#FROM public.ecr.aws/lambda/provided:al2
FROM public.ecr.aws/lambda/provided:al2.2024.04.22.19
# FROM julia:latest

# Download and install Julia
WORKDIR /usr/local
ARG JULIA_VERSION=1.13.2
RUN yum install -y tar gzip \
 && JULIA_MINOR=$(echo ${JULIA_VERSION} | cut -d. -f1,2) \
 && curl -LO https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_MINOR}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
 && tar zxf julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
 && rm julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
 && ln -s julia-${JULIA_VERSION} julia

# Install application
WORKDIR /var/task

# Use a special depot path to store precompiled binaries
ENV JULIA_DEPOT_PATH=/var/task/.julia

# Instantiate project and precompile packages
COPY Manifest.toml .
COPY Project.toml .
# Julia >= 1.13 decompresses registries with its bundled libexec/julia/zstd, which must find Julia's own
# libzstd (Amazon Linux 2 only provides an older, incompatible libzstd), so point the loader at lib/julia for this step.
RUN LD_LIBRARY_PATH=/usr/local/julia/lib/julia /usr/local/julia/bin/julia --project=. -e "using Pkg; Pkg.instantiate(); Pkg.API.precompile()"


# Copy application code
COPY . .

# Uncomment this line to allow more precompilation in lamdbda just in case.
# That's because /var/task is a read-only path during runtime.
ENV JULIA_DEPOT_PATH=/tmp/.julia:/var/task/.julia

# Install bootstrap script
WORKDIR /var/runtime
COPY bootstrap .

# Create an empty extensions directory
WORKDIR /opt/extensions

# Which module/function to call?
CMD [ "RackSectionsAPI.handle_event"]
