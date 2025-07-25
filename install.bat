@echo off

REM Check if .env file exists
if not exist .env (
    REM If not, copy the template
    copy .env.template .env
    echo .env file created from template.
)

REM Install dependencies
echo Installing dependencies...
npm install

REM Make the CLI available globally
echo Making the CLI available globally...
npm link

echo Installation complete. You can now use the 'Cliode' command.