arca
=======

[![Build Status](https://travis-ci.org/stefanbc/arca.svg?branch=master)](https://travis-ci.org/stefanbc/arca) [![Dependency Status](https://www.versioneye.com/user/projects/57548c067757a00034dc42c4/badge.svg?style=flat)](https://www.versioneye.com/user/projects/57548c067757a00034dc42c4)

A simple aspect ratio calculator
--

While resizing images, use this calculator to preserve their aspect ratio. The formula used by this app is:

*(h1 / w1) x w2 = h2*

Where h1 is the original height, w1 is the original width, w2 is the new width and h2 is the new height.

![Screenshot](https://i.imgur.com/OYghw7m.png)

Installation
--

Just download the latest release and place it on your local or web server.

Preview a demo [HERE](http://stefanbc.github.io/arca).

Requirements
--

* Any local or web server

Developers
--

Make sure you have Node 0.10^ and npm installed. You'll need to have Grunt and Sass installed. Use these commands:

```
npm install -g grunt-cli
gem install sass
```

You can then install all the project dependencies using:

```
npm install
```

Available Grunt tasks:

* `grunt` - will build the whole project.
* `grunt watch` - will watch for any file modifications and will build. Will also build on start.
* `grunt test` - will test the main app js file using `jshint` (more tests are coming soon).

For local development you can use 

```
python -m SimpleHTTPServer <specify a port>
```

and you can check if the build passes using Travis-CI.
