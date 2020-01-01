# Biru

Do things with your trash from CLI

## We have `trash-cli` already!

Well yes, but it doesn't hurt to have another one, in another language

### But wait, what does `rac` mean?

Rac (rác) in Vietnamese means "trash", makes sense?

### Dependencies

In order to run, you must have `glib` installed, depends on your GNU/Linux distro, package names may vary. Vala compiler and meson are required to build, not to run.

```sh
# on Archlinux
sudo pacman -S --needed vala meson
```

```sh
# on Ubuntu
sudo apt-get install libvala-dev valac meson

```

### Building

Clone this project

```sh
git clone https://github.com/l4rzy/rac.git
```

Go to project folder, and call meson to generate build files in a new directory (`b` in this case)

```sh
cd rac
meson b
```

Go to build folder and call ninja to build

```sh
cd b
ninja
```

Run with

```sh
./rac
```

## Authors

* **l4rzy** - *Initial work* -

## License

MIT
