## Vivid

This is a work in progress.

Vivid is an experiment into wrapping the Physically Based Rendering
software with some object-oriented Ruby code to create animations
of realistic 3D scenes that are fully programmable.

Check out `app/scenes/example/` for some examples of how to use it or
[these](https://twitter.com/chrispatuzzo/status/1104167121469272069)
[animations](https://twitter.com/chrispatuzzo/status/1105588326281682946)
to see what it can do.

## How to run

Vivid installs its dependencies to a container, so you'll need Docker.

Then run:

```sh
./vivid app/scenes/example/sphere_flyby.rb
```

This will build the container and run Vivid inside of it.

The default settings render a fairly low quality scene to the `output/`
directory. You can change the settings in `config/default.yml`.
