# https://hub.docker.com/r/denoland/deno
FROM denoland/deno:debian-1.37.1

# Install dependencies
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y git-lfs
RUN apt-get update && apt-get install -y openssh-client

# Add setup scripts
COPY setup.sh /home/deno/setup.sh
COPY update.sh /home/deno/update.sh
COPY pull-images-and-build.sh /home/deno/pull-images-and-build.sh
COPY docker-entrypoint.sh /home/deno/docker-entrypoint.sh

RUN chmod +x /home/deno/docker-entrypoint.sh

# Make a folder where we can attach a persistent disk
RUN mkdir /home/deno/git-repository
VOLUME /home/deno/git-repository

# Set Bash to be the login shell for deno
RUN usermod -s /bin/bash deno

# Create an `.ssh` folder
RUN mkdir /home/deno/.ssh

# Ensure /home/deno is owned by deno
RUN chown deno /home/deno
RUN chown deno /home/deno/.ssh
RUN chown deno /home/deno/git-repository

# Choose a user to run the application (this helps to avoid using `root`)
USER deno

ENTRYPOINT ["/home/deno/docker-entrypoint.sh"]

# Start the application
CMD /bin/bash -c 'cd /home/deno/git-repository && deno task file-server'
