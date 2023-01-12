  ***************************************************************************
  * All the software  contained in this library  is protected by copyright. *
  * Permission  to use, copy, modify, and  distribute this software for any *
  * purpose without fee is hereby granted, provided that this entire notice *
  * is included  in all copies  of any software which is or includes a copy *
  * or modification  of this software  and in all copies  of the supporting *
  * documentation for such software.                                        *
  ***************************************************************************
  * THIS SOFTWARE IS BEING PROVIDED "AS IS", WITHOUT ANY EXPRESS OR IMPLIED *
  * WARRANTY. IN NO EVENT, NEITHER  THE AUTHORS, NOR THE PUBLISHER, NOR ANY *
  * MEMBER  OF THE EDITORIAL BOARD OF  THE JOURNAL  "NUMERICAL ALGORITHMS", *
  * NOR ITS EDITOR-IN-CHIEF, BE  LIABLE FOR ANY ERROR  IN THE SOFTWARE, ANY *
  * MISUSE  OF IT  OR ANY DAMAGE ARISING OUT OF ITS USE. THE ENTIRE RISK OF *
  * USING THE SOFTWARE LIES WITH THE PARTY DOING SO.                        *
  ***************************************************************************
  * ANY USE  OF THE SOFTWARE  CONSTITUTES  ACCEPTANCE  OF THE TERMS  OF THE *
  * ABOVE STATEMENT.                                                        *
  ***************************************************************************

   AUTHORS:

       Michela Redivo-Zaglia
       University of Padova, Italy
       Email: Michela.RedivoZaglia@unipd.it

       Giuseppe Rodriguez
       University of Cagliari, Italy
       Email: rodriguez@unica.it

   REFERENCE:

       smt: a Matlab toolbox for structured matrices.
       NUMERICAL ALGORITHMS, 59 (2012), pp. 639-659
       DOI: 10.1007/s11075-011-9527-9.

   SOFTWARE REVISION DATE:

       V1.0, January 2012

   SOFTWARE LANGUAGE:

       MATLAB 7.10 (R2010a)


======================================================================
SOFTWARE
======================================================================

The smt toolbox for Matlab introduces two new classes for circulant
and Toeplitz matrices, and implements optimized storage and fast
computational routines for them, transparently to the user.

The software has been developed and tested using several MATLAB
versions from 6.5 to 7.10. No other MathWorks products or toolboxes
are required.


======================================================================
HOW TO INSTALL AND CHECK THE INSTALLATION
======================================================================

Please, follow the following steps:

- Extract the archive in the directory you prefer.
  This will create a directory called smt that contains all the files
  of the toolbox.

- Start MATLAB.

- Add the directory containing the toolbox to Matlab search path,
  for instance by using the Matlab command addpath, or the
  "File --> Set path" option in the Matlab file menu.

- It is possible to check for potential problems in the installation
  of the toolbox by running the command
	smtcheck
  This command checks that the path was correctly set, and the
  presence of the function isfloat in the version of Matlab being
  used. This step is optional, but recommended.

- The function
	validate
  which must be run after changing the working directory to
  smt/demo/validate/, runs most of the possible tests on all operators
  and functions, to verify that the structured routines produce
  essentially the same results than Matlab standard routines.

More information can be found in the userguide.pdf file, available in
the main smt directory.


======================================================================
PACKAGE
======================================================================

The directories and MATLAB functions created during the installation
are sketched in the following

                           smt
                            |
_________________________________________________________________
       |            |             |           |           |
    private      @smcirc       @smtoep      demo        .....
       |            |              |          |
     .....        .....          .....      .....

smt              contains the Matlab the functions used by the toolbox,
                 and the userguide.pdf file
smt/@smcirc      constructors and methods for the smcirc class
smt/@smcirc      constructors and methods for the smtoep class
smt/private      contains functions which are not directly accessible
                 to the user, but are used by other functions
smt/demo         tutorial, test files and validate commands


======================================================================
CONFIGURATION
======================================================================

Several options are provided to configure the package. For obtaining
information about the possible options and for changing them use the
	smtconfig
command; see also the corresponding help page.

The package was developed with MATLAB 7.10 (R2010a), but our tests
show that it can be used also with previous versions of Matlab.
With version 6.5, it is necessary to rename the file isfloat.m.no to
isfloat.m, since this function is missing in this version of Matlab.
This file can be found in the smt base directory.


======================================================================
TUTORIAL AND TESTS
======================================================================

The directory smt/demo contains the file tutorial.m, which can be
executed for illustrating the basic use of the toolbox.
To execute it you must change the working directory to smt/demo.

The files in the directory smt/demo/tests reproduce the numerical tests
reported in the paper.
To replicate the tests it is necessary to run the following commands,
after changing the working directory to smt/demo/tests.

test1		% to reproduce Figure 1
test2		% to reproduce Figure 2
test3		% to reproduce Figure 3
test4		% to reproduce Table 6


======================================================================
DOCUMENTATION
======================================================================

More information can be found:

     - in the paper
       smt: a Matlab toolbox for structured matrices.
       NUMERICAL ALGORITHMS, 59 (2012), pp. 639-659
       DOI: 10.1007/s11075-011-9527-9.

     - in the userguide.pdf file, available in the main smt directory

     - on the web page
       http://bugs.unica.it/smt/
