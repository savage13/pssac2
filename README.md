pssac2
======

Plot Seismograms using GMT5


Building / Installing
---------------------

```./configure --with-gmt=/usr/path/to/gmt```

- OSX Build Issues
  GMT5 by default creates libraries with relative paths, this causes trouble
  To create libraries with absolute paths, do
```shell 
    % cd gmt-5
    % cd cmake
    % cp ConfigUserTemplate.cmake ConfigUser.cmake 
    % edit ConfigUser.cmake
    % # Uncomment the following line
    set (GMT_INSTALL_RELOCATABLE FALSE)
    % cmake 
    % make
    % make install
```

