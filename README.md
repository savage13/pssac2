pssac2
======

Plot Seismograms using GMT5

Note: Build from 11/04/2014 require an updated version of GMT5 libs (r13657 or later)

Building / Installing
---------------------

```./configure ```

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

If the GMT 5 libraries are not already in your path, you may need to add them to your LD_LIBRARY_PATH enviornment variable or to the system's ldconfig directories.

