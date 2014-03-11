@echo off
REM The MIT License (MIT)
REM 
REM Copyright (c) 2014 Tushar Joshi
REM 
REM Permission is hereby granted, free of charge, to any person obtaining a copy
REM of this software and associated documentation files (the "Software"), to deal
REM in the Software without restriction, including without limitation the rights
REM to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
REM copies of the Software, and to permit persons to whom the Software is
REM furnished to do so, subject to the following conditions:
REM 
REM The above copyright notice and this permission notice shall be included in all
REM copies or substantial portions of the Software.
REM 
REM THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
REM FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
REM AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
REM LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
REM OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
REM SOFTWARE.

REM pullincr.bat
REM
REM Incremental fetching of changesets, 100 changesets at a time
REM This helps in slow connections and where chances of
REM reconnection are frequent. 
REM When the connection drops only last 100 changesets are rolledback
REM maintaining all the earlier changesets fetched intact.

REM set this variable to true for proxy use
set USE_PROXY=false

REM Used only if USE_PROXY is true
set PROXY_HOST=someproxy.com
set PROXY_PORT=8080
set PROXY_USER=username
set PROXY_PASS=password 

REM Lines below should work without any changes
if "$USE_PROXY" EQU "true" (
set PROXY_OPTS=--config http_proxy.host=%PROXY_HOST%:%PROXY_PORT% --config http_proxy.user=%PROXY_USER% --config http_proxy.passwd=%PROXY_PASS%
) else (
set PROXY_OPTS=
)

for /f "tokens=*" %%i in ('hg log -l 1 ^| sed -n 1p ^| cut -d" " -f4 ^| cut -d":" -f1') do set index=%%i
echo The local repo has highest changeset: %index%

set /a iteration=0

:start

set /a index=%index%+100
set /a iteration=%iteration%+1
TITLE Iteration %iteration% changeset %index%

echo Fetching changesets till index: %index%
hg --debug --verbose %PROXY_OPTS% pull -r %index%
if %ERRORLEVEL% GEQ 1 goto :lastcheck
goto :start

:lastcheck
echo "Checking one more time for last changes..."
hg --debug --verbose %PROXY_OPTS% pull
@echo on