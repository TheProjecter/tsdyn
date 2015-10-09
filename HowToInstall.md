# Introduction #

This page shows how to install tsDyn and compile it from sources.


# Details #

Currently, the version 0.6 is in the CRAN repository and hence easily avalaible. For those who want nevertheless the newest functionnalities, you will have to download and compile it yourself.

# Get the source #
This is very easy when you use subversion (you have to install it) and allows you to have always the newest version. Just downloaded the latest version of the sources:

`svn checkout http://tsdyn.googlecode.com/svn/trunk/ tsdyn-read-only`

Now each time you want the new version just go in the directory and type:

`svn update`

# Install required packages #
tsDyn **depends** on mgcv, Matrix, minpack.lm, rgenoud, **recquires** nnet, tseriesChaos, tseries, utils and **suggests** tcltk, sm, scatterplot3d, rgl. So, install them all by typing, at the R prompt (this may take some time):

```
install.packages(c("mgcv", "Matrix", "minpack.lm", "rgenoud",
 "nnet", "tseriesChaos", "tseries",
 "sm", "scatterplot3d", "rgl"), dep=TRUE)
```

Some of those packages may be difficult to install as they have complicated dependencies. On debian-based distributions, they can be installed easier by:
`sudo apt-get install r-cran-rgl`
# Install tsDyn #
Now you have the required external packages installed, as well as tsDyn sources. To make it loadable in R, you have to go to the download directory (`cd tsdyn-read-only`) and enter:

`sudo R CMD INSTALL tsDyn`

prompt your password and this will be done.


[Back](Intro.md) to package description here.