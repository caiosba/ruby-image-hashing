# Ruby Image Matcher

Look for similar images using Ruby. Current approaches:

* pHash
* dHash
* IDHash
* PDQ

# Installation

* `apt-get install libavformat-dev libmpg123-dev libsamplerate-dev libsndfile-dev cimg-dev libavcodec-dev ffmpeg libswscale-dev libffi-dev libavcodec-dev cimg-dev build-essential pkg-config glib2.0-dev libexpat1-dev libpng-dev libjpeg-dev python3-pip`
* `gem install pHash ffi ruby-vips dhash-vips phashion
* Download pHash from http://phash.org/download/
* Unzip it and enter its directory
* `./configure --enable-openmp=yes --enable-video-hash=no --enable-audio-hash=no LDFLAGS='-lpthread'`
* `make && make install`
* Download VIPS from https://github.com/libvips/libvips/releases
* Unzip it and enter its directory
* `./configure`
* `make && sudo make install && sudo ldconfig`
* `sudo pip3 install Image`
* `sudo pip3 install pillow`

# References

* https://github.com/Nakilon/dhash-vips
* https://github.com/facebook/ThreatExchange/blob/master/hashing/hashing.pdf

# Evaluation

Against the Facebook dataset, the results are:
