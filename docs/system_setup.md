# System Setup

Several development libraries will be needed. (TODO: research which dev libraries are needed)

RVM and ruby are expected.

To install RVM, follow the installation directions at the [RVM site](http://rvm.io/rvm/install)

Install ruby 2.1.2:

```shell
rvm install ruby-2.1.2
```

Create a gemset for the application:
```
rvm gemset create datacultures
rvm gemset use datacultures
```

Install [GraphicsMagick](http://www.graphicsmagick.org/README.html).
 * OS X:
   - Can be installed through Homebrew
 * Ubuntu
   - Add Peter Teichman's PPA (https://launchpad.net/~pteichman/+archive/ubuntu/graphicsmagick)
   - `apt-get install graphicsmagick`
