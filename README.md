# toolbox

An alpine linux container image with general tools to be used as a toolbox.  
Check the [Containerfile](./Containerfile) for the details about installed tools.

### How to use

Pull the image from [quay.io](https://quay.io/repository/tlbueno/toolbox)

```sh
podman pull quay.io/tlbueno/toolbox
```

### How to build

```sh
git clone https://github.com/tlbueno/toolbox.git
cd toolbox
podman build -t toolbox:latest .
```

