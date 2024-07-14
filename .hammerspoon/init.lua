-- simulate iterm2 system-wide hotkey
-- see https://github.com/kovidgoyal/kitty/issues/45

hs.hotkey.bind({"ctrl"}, "tab", function()
    local app = hs.application.get("kitty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
            app:mainWindow():moveToUnit'[0,0,100,100]'
        end
    else
        hs.application.launchOrFocus("kitty")
    end
end)
