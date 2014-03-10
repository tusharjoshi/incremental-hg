#!/bin/bash
#
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

# pullincr.sh
#
# Incremental fetching of changesets, 100 changesets at a time
# This helps in slow connections and where chances of 
# reconnection are frequent.  
# When the connection drops only last 100 changesets are rolledback
# maintaining all the earlier changesets fetched intact.

fetchsize=100

# function for setting terminal titles in OSX
function title {
  printf "\033]0;%s\007" "$1"
}

# get the last changeset number from repo
index=`hg log -l 1 | sed -n 1p | cut -d" " -f4 | cut -d":" -f1`
iteration=0
echo "The local repo has highest changeset: $index"

# start the fetch loop for next 100 changesets
while :
do
index=$((index+fetchsize))
iteration=$((iteration+1))
title "Iteration $iteration changeset $index"

echo "Fetching changesets till index: $index"
hg --debug --verbose pull -r $index

rc=$?
if [[ $rc != 0 ]] ; then
	echo "Nothing to fetch stopping now."
    break
fi
done

echo "Checking one more time for last changes..."
hg --debug --verbose pull