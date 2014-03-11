incremental-hg
==============

Scripts to clone few change-sets and to pull change-sets incrementally from a Mercurial repository, for connections which may reset. This helps to optimise the downloads.

Works and tested on:
1. Windows 8.1
2. Mac OS X Mavericks
3. Linux

Installation
============

Copy the files into a local folder, we will call it INCREMENTAL_HG_HOME

Usage
=====


For Windows

Using the scripts in windows need sed and cut commands to be available in executable path.  This can be easily achieved by installing Git for Windows, which include these necessary commands, when updating the PATH variable is selected in installation.

1. Change directory to required folder
1. Change the repository name in the file initclone.bat (this will soon be changed to command line args)
1. For initial clone of the repo, Run the command
```
  %INCREMENTAL_HG_HOME%\initclone.bat
```  
1. Change directory into the cloned repo part and then run the command
```
  %INCREMENTAL_HG_HOME%\pullincr.bat
```  
For Mac and Linux

1. Change directory to required folder
1. Change the repository name in the file initclone.sh (this will soon be changed to command line args)
1. For initial clone of the repo, Run the command
```
  $INCREMENTAL_HG_HOME/initclone.sh
```  
1. Change directory into the cloned repo part and then run the command
```
  $INCREMENTAL_HG_HOME/pullincr.sh
``` 