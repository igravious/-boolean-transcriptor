$ bower install

$ cd vendor

only needs to be done once

$ mkdir patches

put `patches` under version control

$ cd vendor/components

$ cp -R foo foo.orig

make changes to files in foo and when done

$ diff -rupN foo.orig/ foo/ > ../patches/foo.patch

put `foo.patch` under version control

when you have a new installation somewhere else or an update here

$ bower install

$ cd vendor/components/foo

$ patch -p1 < ../../patches/foo.patch
