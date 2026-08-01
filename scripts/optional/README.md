# Optional tools

Scripts in this directory are not part of the base dojo install and are never run by `ekohacks-dojo-setup.sh`. Each one is a standalone program: it checks its own requirements, is safe to run twice, and is run by hand on the machines that need it, usually well after provisioning.

This directory is where policy exceptions live in the open. The base install keeps the training rules for every machine in the fleet. A machine that needs something beyond them, an ops laptop, an instructor machine, gets it by someone deliberately running a script here.

| Script | Who runs it | What it does |
| --- | --- | --- |
| `install-claude-code.sh` | Ops and instructors | Installs Claude Code via the native installer. Needs a login on first run. |

To add a new optional tool, copy the shape of an existing script: refuse to run as root, check your own requirements, exit cleanly if already installed, and say what to do next when you finish.
