fx_version 'cerulean'
game 'gta5'

author 'Event System'
description 'Comprehensive FiveM Server System'
version '1.0.0'

-- Shared Scripts
shared_scripts {
    'shared/**/*.lua'
}

-- Server Scripts
server_scripts {
    'server/**/*.lua'
}

-- Client Scripts
client_scripts {
    'client/**/*.lua'
}

-- UI Resources
ui_page 'html/index.html'

files {
    'html/**/*.html',
    'html/**/*.css',
    'html/**/*.js'
}

