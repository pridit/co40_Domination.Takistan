find . -type d -not -path "*.git*" -not -path "*.vscode*" -not -path "*dialog*" -not -path "*fsm*" -not -path "*sounds*" -exec cp x_macros.sqf {} \;