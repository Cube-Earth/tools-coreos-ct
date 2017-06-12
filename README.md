# Introduction
With the config transpiler, config files (simliar, but not identical to cloud-config files) can be converted to Ignition JSON format.
The only purpose of this container is to build the ct tool for Alpine.

# Download
See [Releases](../../releases) for bre-build ct for Alpine.

# Usage
```
ct << EOF
storage:
  files:
    - path: /home/core/.bashrc
      filesystem: root
      contents:
        inline: |
          . /usr/share/skel/.bashrc
          alias ll="ls -l"
      mode: 0644
      user:
        id: 500
      group:
        id: 501
EOF
```
# Build
```
./docker-compose build
./run.sh
```
This container automatically creates a new release and propagates the built ct tool into this newly created release.

# References
https://github.com/coreos/container-linux-config-transpiler

