# docker images

By [Florian Breuer].

## Description
Many Dockerfiles which I find usefull, will be extended as my infrastructure is migrated.

## Installation

install docker (obviously)

clone repo

## Usage

All descriptions assume that pwd == git repository root.

The docker container have to be build, this is done either through 
```console
$ ./build_all.sh
```
which (as the name suggests) will build all docker images.

Or by selecting specific images:

Note: All website images require the clu/apache2_http or clu/apache2_http_with_ssl images, so please generate them before.

### HTTP server with owncloud

```console
$ cd apache2_http
$ ./build.sh
$ cd ..
$ cd apache2_owncloud
$ ./build.sh
```

will for example build the clu/apache2_http and clu/apache2_http_owncloud image

### HTTP server and SSH server with owncloud

```console
$ cd apache2_http
$ ./build.sh
$ cd ..
$ cd apache2_owncloud
$ ./build.sh with_ssh
```

will for example build the clu/apache2_http_with_ssh and clu/apache2_http_owncloud_with_ssh image



## Configuration

## HTTP with ssh build script

You can start the build script in apache2_http_with_ssl with following options:

```console
$ ./build <no_pw_gen> <password>
```

If you start the build script without any arguments it will generate a random password for the root user. The password will be displayed in the shell:

```console
$ ./build
$ <output from script>
$ sshpassword=randompasswordhere
$ # easily grepable
```

no_pw_gen - the build script will search the password in a file under the relative path docker_root/tmp/password. If not found it will default to generating a random password

```console
$ mkdir -p docker_root/tmp/
$ echo "root:test" > docker_root/tmp/password
$ ./build no_pw_gen
$ # will set the password to "test"
```


password - can only be set with no_pw_gen, this will be the ssh password for root for all containers created from the image

```console
$ ./build no_pw_gen root
$ # will set the password to "root"
```

## Owncloud build script

You can start the build script in apache2_owncloud with following options:

```console
$ ./build <with_ssh>
```

If you start the build script without any arguments it will generate an owncloud container without ssh server:

```console
$ ./build
```


with_ssh - generates an owncloud container which is sshable (please make sure that you note the ssh password from the clu/apache2_http_with_ssh container)
```console
$ ./build with_ssh
```

build.sh has one important variable:

OWNCLOUD_LINK - url of a stable owncloud archive in .tar.bz2 format (default 7.0.1)

## Owncloud/apache2 configuration

create_owncloud_config.sh has three important variables:

OWNCLOUD_SERVER_NAME_DOCKER - hostname of the virtual host (default none)

OWNCLOUD_SERVER_ADMIN_DOCKER - email adress of the admin (default none)

OWNCLOUD_SERVER_PORT_DOCKER - port your server runs on  (default 80)

if you change OWNCLOUD_SERVER_PORT_DOCKER you'll also have to expose the port in the corresponding dockerfiles



### Known Issues

If you discover any bugs, feel free to create an issue on GitHub fork and
send me a pull request.

[Issues List](https://github.com/clu2/docker-owncloud/issues).

## Authors

* Florian Breuer (https://github.com/clu2)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

The MIT License (MIT)

Copyright (c) 2014 clu2

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

