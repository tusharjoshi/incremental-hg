@echo off
hg --debug --verbose %PROXY_OPTS% clone %REPO_PATH% -r 10 %LOCAL_NAME%