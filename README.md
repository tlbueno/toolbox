# toolbox

An alpine linux container image with general tools to be used as a toolbox.
Check the [Containerfile](./Containerfile) for the details about installed tools in the [source repo](https://github.com/tlbueno/toolbox)

### How to use

Pull the image from [ghcr.io](https://github.com/tlbueno/toolbox/pkgs/container/toolbox)

```sh
podman pull ghcr.io/tlbueno/toolbox:latest
```

### How to build

```sh
git clone https://github.com/tlbueno/toolbox.git
cd toolbox
podman build -t toolbox:latest .
```

