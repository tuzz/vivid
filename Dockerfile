FROM alpine:latest

WORKDIR /vivid

ADD . .

# Build the latest version of pbrt:
RUN apk add --update git build-base cmake doxygen graphviz zlib-dev
RUN git clone --recursive https://github.com/mmp/pbrt-v3
RUN mkdir build && cd build && cmake ../pbrt-v3 && make && cp pbrt /usr/local/bin

# Install ffmpeg and md5:
RUN apk add ffmpeg outils-md5

# Install Ruby and install gems:
RUN apk add ruby
RUN gem install bundler -v 1.17.2 --no-document
RUN bundle config --global silence_root_warning 1
RUN bundle

# Run the command-line interface:
ENTRYPOINT ["ruby", "-I", "lib", "-r", "vivid", "-e", "Vivid::CLI.run"]
