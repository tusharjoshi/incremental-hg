# The MIT License (MIT)
# 
# Copyright (c) 2014 Tushar Joshi
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# initclone.sh
#
# Cloning initial 10 changesets of the repository

# ----------------------Configutaion-------------------------------
# URL for the repo to clone
REPO_PATH=http://hg.netbeans.org/main-silver
# Name of the local folder, keep blank for default
LOCAL_NAME=

# cloning only first 10 changesets
echo Starting the cloning process.
hg --debug --verbose %PROXY_OPTS% clone %REPO_PATH% -r 10 %LOCAL_NAME%
echo "Cloning 10 changesets done."