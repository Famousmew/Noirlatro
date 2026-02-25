function create_UIBox_one_one_video(name,buttonname)
local file_path=SMODS.Mods["noirlatro"].path.."/assets/video/"..name
love.filesystem.write("temp.ogv", NFS.read(file_path))
local video_file=love.graphics.newVideo('temp.ogv')
local vid_sprite=Sprite(0,0,11*16/9,11,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)],{x=0,y=0})
local vid_source = video_file:getSource()
if vid_source then
vid_source:setVolume(G.SETTINGS.SOUND.volume*G.SETTINGS.SOUND.game_sounds_volume/(100*10))
end
vid_sprite.video=video_file
video_file:play()
local t=create_UIBox_generic_options({back_delay=2,back_label=buttonname,colour=G.C.BLACK,padding=0,contents={{n=G.UIT.O,config={object=vid_sprite}}}})
return t
end
OneOneVideoModal = OneOneVideoModal or {
active = false,
finished = false,
vid = nil,
vid_sprite = nil,
ui = nil,
started_this_loss = false,
triggered_game_over = false,
}
function OneOneVideoModal:update(dt)
if not self.active or not self.vid then return end
if not self.vid:isPlaying() and not self.finished then
self.finished = true
end
end
G.FUNCS.one_one_close_video = function(e)
if OneOneVideoModal.vid then OneOneVideoModal.vid:pause() end
OneOneVideoModal.active = false
G.FUNCS.exit_overlay_menu()
end
function OneOneVideoModal:start(filename)
if self.active then return end
if not (love and love.graphics and love.graphics.newVideo) then
return
end
local file_path = SMODS.Mods["noirlatro"].path.."/assets/video/"..filename
love.filesystem.write("temp_1-1.ogv", NFS.read(file_path))
local success, video_file = pcall(love.graphics.newVideo, 'temp_1-1.ogv')
if not success then
return
end
self.vid_sprite = Sprite(0,0,11*16/9,11,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)], {x=0, y=0})
self.vid_sprite.video = video_file
local vid_source = video_file:getSource()
if vid_source then
vid_source:setVolume(G.SETTINGS.SOUND.volume*G.SETTINGS.SOUND.game_sounds_volume/(100*10))
end
video_file:play()
self.vid = video_file
self.active = true
self.finished = false
self.started_this_loss = true
self.triggered_game_over = false
self:open_ui()
end
function OneOneVideoModal:open_ui()
local definition = create_UIBox_generic_options{
back_func = "one_one_close_video",
back_label = "Close",
colour = G.C.BLACK,
padding = 0,
contents = {
{n=G.UIT.O, config={object = self.vid_sprite}}
}
}
local layout = definition.definition or definition
G.FUNCS.overlay_menu{ definition = layout }
end