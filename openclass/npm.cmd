:: Created by npm, please don't edit manually.
@ECHO OFF

SETLOCAL

SET "NODE_EXE=C:\Users\TUBM01\repos\openclass\openclass\node.exe"
IF NOT EXIST "%NODE_EXE%" (
  SET "NODE_EXE=C:\Users\TUBM01\repos\openclass\openclass\node.exe"
)

SET "NPM_CLI_JS=C:\Users\TUBM01\repos\openclass\openclass\node_modules\npm\bin\npm-cli.js"
FOR /F "delims=" %%F IN ('CALL "%NODE_EXE%" "%NPM_CLI_JS%" prefix -g') DO (
  SET "NPM_PREFIX_NPM_CLI_JS=C:\Users\TUBM01\repos\openclass\openclass\node_modules\npm\bin\npm-cli.js"
)
IF EXIST "%NPM_PREFIX_NPM_CLI_JS%" (
  SET "NPM_CLI_JS=%NPM_PREFIX_NPM_CLI_JS%"
)

"%NODE_EXE%" "%NPM_CLI_JS%" %*
