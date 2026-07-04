@echo off
claude --model claude-sonnet-5 --effort medium --plugin-dir "%USERPROFILE%\.local\share\cheap-workflow" %*
