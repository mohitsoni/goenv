# goenv

goenv is a script to bootstrap go workspace.

## Installation

```
wget <url-to-goenv.sh> | bash
```

## What does it do ?

goenv creates a go workspace according to
http://golang.org/doc/code.html

By default, it creates following directories:
```
~/goworkspace/
	/src
	/pkg
	/bin
```

It also appends following exports in ~/.profile on Mac:
```
export GOPATH=~/goworkspace
export PATH=$PATH:$GOPATH/bin
```

## Limitations:

The project is a work in progress, and works for Mac at this point.

Feel free to send pull requests to make it work for other platforms.
