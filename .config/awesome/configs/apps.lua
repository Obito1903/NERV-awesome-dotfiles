local apps = {
    terminal = "termite",
    editor = "code",
    editor_cmd = "vim"
}

apps.editor_cmd = apps.terminal .. " -e " .. apps.editor_cmd

return apps
