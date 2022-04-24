script_version '1.0.0'
local dlstatus = require "moonloader".download_status
script_author("MultiSell")
local key = require 'vkeys'
local imgui = require 'imgui'
local inicfg = require 'inicfg'
local encoding = require 'encoding'
local sampev = require 'lib.samp.events'
local fontsize = nil
local fontsize1 = nil
local x = 0
local ev = require 'samp.events'
local namelavki = imgui.ImBuffer(256)
local superr = imgui.ImBool(false)
local window = imgui.ImBool(false)
require "lib.moonloader"
encoding.default = 'CP1251'
u8 = encoding.UTF8

local dlstatus = require('moonloader').download_status
local script_vers = 1
local script_vers_text = '1.00'
local script_path = thisScript().path
update_state = false
local update_url = 'https://raw.githubusercontent.com/JohnFeat/scriptsa/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'
local script_url = ''

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	repeat wait(100) until isSampAvailable()

  sampAddChatMessage('[MultiSell] ������ �������!', -1)

  autoupdate("https://api.jsonbin.io/b/6264b25d019db46796908e45/2", '['..string.upper(thisScript().name)..']: ', "https://gist.github.com/JohnFeat/4adb07aa66e074b9ee26a0b42c531971/raw/c829a5fbb90df3dd3c3f0be3dcffc478d6e1f581/secrtetpr")

	sampRegisterChatCommand("msell", function()
		main_window_state.v = not main_window_state.v
		imgui.Process = main_window_state.v
	end)


				imgui.Process = false
	    sampRegisterChatCommand('cal', calc)
	while true do wait(0)
    if update_state then
      downloadUrlToFile(script_url, script_path)
      if status == dlstatus.STATUS_ENDDOWNLOADDATA then
         sampAddChatMessage('������ ��������!', -1)
         thisScript():reload()
	  end
	end
	end
end

function autoupdate(json_url, prefix, url)
	local dlstatus = require('moonloader').download_status
	local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(json) then os.remove(json) end
	downloadUrlToFile(json_url, json,
	  function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD then
		  if doesFileExist(json) then
			local f = io.open(json, 'r')
			if f then
			  local info = decodeJson(f:read('*a'))
			  updatelink = info.updateurl
			  updateversion = info.latest
			  f:close()
			  os.remove(json)
			  if updateversion ~= thisScript().version then
				lua_thread.create(function(prefix)
				  local dlstatus = require('moonloader').download_status
				  local color = -1
				  sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
				  wait(250)
				  downloadUrlToFile(updatelink, thisScript().path,
					function(id3, status1, p13, p23)
					  if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
						print(string.format('��������� %d �� %d.', p13, p23))
					  elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
						print('�������� ���������� ���������.')
						sampAddChatMessage((prefix..'���������� ���������!'), color)
						goupdatestatus = true
						lua_thread.create(function() wait(500) thisScript():reload() end)
					  end
					  if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
						if goupdatestatus == nil then
						  sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
						  update = false
						end
					  end
					end
				  )
				  end, prefix
				)
			  else
				update = false
				print('v'..thisScript().version..': ���������� �� ���������.')
			  end
			end
		  else
			print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
			update = false
		  end
		end
	  end
	)
	while update ~= false do wait(100) end
  end
  
local mainini = inicfg.load({
config =
{
namelavok = false,
namelavki = '',
}
}, "JLog")

local namelavki = imgui.ImBuffer(tostring(mainini.config.namelavki), 256)
if not doesFileExist('moonloader/config/JLog.ini') then inicfg.save(mainini, 'JLog.ini') end

local main_window_state = imgui.ImBool(false)
local sw, sh = getScreenResolution()
local wmine = 700
local sametext = imgui.ImBuffer(256)
function SetStyle()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.ChildWindowRounding = 4.0
	colors[clr.PopupBg]                = ImVec4(0.0, 0.0, 0.0, 1.0)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Button]                 = ImVec4(0.10, 0.10, 0.10, 1.0)
	colors[clr.ButtonHovered]          = ImVec4(0.2, 0.2, 0.2, 1.00)
	colors[clr.ButtonActive]           = ImVec4(0.50, 0.5, 0.5, 1.00)
	colors[clr.TitleBg]                = ImVec4(0.0, 0.0, 0.0, 1.00)
	colors[clr.TitleBgActive]          = ImVec4(0.1, 0.0, 0.0, 0.00)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
	colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
	colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.Header]                 = ImVec4(0.25, 0.25, 0.25, 1.0)
	colors[clr.HeaderHovered]          = ImVec4(0.30, 0.30, 0.30, 1.0)
	colors[clr.HeaderActive]           = ImVec4(0.35, 0.35, 0.35, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
  colors[clr.WindowBg]               = ImVec4(0.0, 0.0, 0.0, 1.0)
  colors[clr.Border]                 = ImVec4(1.0, 1.0, 1.0, 1.0)
  colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.Separator]              = colors[clr.Border]
end

function imgui.CenterTextColoredRGB(text)
		encoding.default = 'CP1251'
		u8 = encoding.UTF8
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end

function imgui.CenterTextColoredRGB1(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            imgui.SetCursorPosX( (width - 200)  - (text_width .x - 150) )
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end


SetStyle()


function imgui.BeforeDrawFrame()
    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 20.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- ?????? 30 ????? ?????? ??????
    end
    if fontsize1 == nil then
        fontsize1 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 10.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
      end
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
end
apply_custom_style()
function imgui.ButtonHex(lable, rgb, size)
    local r = bit.band(bit.rshift(rgb, 16), 0xFF) / 255
    local g = bit.band(bit.rshift(rgb, 8), 0xFF) / 255
    local b = bit.band(rgb, 0xFF) / 255

    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, 0.6))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, 0.8))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, 1.0))
    local button = imgui.Button(lable, size)
    imgui.PopStyleColor(3)
    return button
end

function imgui.OnDrawFrame()
  if not main_window_state then
    imgui.Process = false
  end
  if main_window_state then
		end
		local btnSize = imgui.ImVec2(250, 100)
    imgui.SetNextWindowSize(imgui.ImVec2(900, 640), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin('', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoScrollbar)
		imgui.PushFont(fontsize)
    imgui.PopFont()
		imgui.BeginChild("##trigger", imgui.ImVec2(885, 590), true, imgui.WindowFlags.NoScrollbar)
		imgui.BeginChild('##razdel', imgui.ImVec2(225,575), true)
			imgui.CenterTextColoredRGB('�������� ������')
			imgui.Separator()
			if imgui.Button(u8'��������� �������', imgui.ImVec2(210,40), settings) then
					settings = not settings
					calculator = false
					skupka = false
				end
			if imgui.Button(u8'��������� ���������� �������', imgui.ImVec2(210,40), skupka) then
				skupka = not skupka
				settings = false
				calculator = false
			end
			if imgui.Button(u8'�����������',  imgui.ImVec2(210,40), calculator) then
				calculator = not calculator
				settings = false
				skupka = false
			end
				imgui.Button( u8'������� ����������/������', imgui.ImVec2(210,40))
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild('##settings', imgui.ImVec2(635,575), true)

				if calculator then
					settings = false
					skupka = false
					imgui.CenterTextColoredRGB('���������� �� ����������� �������������', imgui.ImVec2(25,575))
					imgui.Separator()
					imgui.PushFont(fontsize)
						imgui.CenterTextColoredRGB('��������� ����������� �������� /cal �����1 "��������" �����2')
					imgui.PopFont()
					imgui.Text(u8'����������� ��������')
					imgui.Text(u8'����� = " + "')
					imgui.Text(u8'������� = " - "')
					imgui.Text(u8'������� = " / "')
					imgui.Text(u8'��������� = " * "')
					imgui.Text(u8'����� ���������, ���������� ������ /cal, ����� ������� �����, ����� �������� � ������ �����')
					imgui.Text(u8'��������: /cal 1+1 . � ��� ��������� ��������� "���������: 2"')
				end
				if settings then
					calculator = false
					skupka = false
					imgui.CenterTextColoredRGB('������ �������� ������� ��� ����', imgui.ImVec2(25,575))
					imgui.Separator()
					imgui.Checkbox(u8'�������������� �������� �����##1', superr)
					imgui.SameLine()
					imgui.SameLine()
					imgui.InputText(u8'�������� �����', namelavki)
					if imgui.Button(u8'���������') then
						sampAddChatMessage('��� ����������� ����� ������� ������� /clavka', -1)
						sampRegisterChatCommand('clavka', fast_lavka)
						mainini.config.namelavki = namelavki.v
						inicfg.save(mainini, 'JLog.ini')
					end
				end
				if skupka then
					calculator = false
					settings = false
					imgui.CenterTextColoredRGB('��������� ��� ������ ������� (�� ��������)', imgui.ImVec2(25,575))
					imgui.Separator()
					if imgui.CollapsingHeader(u8"����������") then
						if imgui.CollapsingHeader(u8'�� �����') then
													imgui.Text(u8'���������� ���� �1')
													imgui.Text(u8'���������� ���� �2')
													imgui.Text(u8'���������� ���� �3')
													imgui.Text(u8'������')
													imgui.Text(u8'����� � �����')
													imgui.Text(u8'������')
													imgui.Text(u8'��������� �� �����')
													imgui.Text(u8'������ �� �����')
													imgui.Text(u8'�������� �� �����')
													imgui.Text(u8'������� �� �����')
													imgui.Text(u8'�������� �� �����')
													imgui.Text(u8'������� �� �����')
													imgui.Text(u8'����� �� �����')
													imgui.Text(u8'�������� �� ����� �1')
													imgui.Text(u8'�������� �� ����� �2')
													imgui.Text(u8'����� �� ����� �2')
													imgui.Text(u8'������� �� �����')
													imgui.Text(u8'������ �� �����')
													imgui.Text(u8'���� �� �����')
													imgui.Text(u8'���������� ������ �� �����')
													imgui.Text(u8'��������� ���� �� �����')
													imgui.Text(u8'��� �� �����')
													imgui.Text(u8'������� �� �����')
													imgui.Text(u8'������� ��������� �� �����')
													imgui.Text(u8'��������� �� �����')
													imgui.Text(u8'������� ���������')
													imgui.Text(u8'������� �������')
													imgui.Text(u8'������� �� ������')
													imgui.Text(u8'���� �� �����')
													imgui.Text(u8'������� �������')
													imgui.Text(u8'������ �� ����� ������')
													imgui.Text(u8'������ �� ����� �������')
													imgui.Text(u8'����������� �����')
													imgui.Text(u8'���������� �����')
													imgui.Text(u8'������ ��������')
													imgui.Text(u8'������ � �������')
													imgui.Text(u8'������� OPEN')
													imgui.Text(u8'������ � ������')
													imgui.Text(u8'������ ������')
													imgui.Text(u8'������ ����')
													imgui.Text(u8'������ �����')
						end
						if imgui.CollapsingHeader(u8'�� �����') then
											imgui.Text(u8'������ �� �����')
											imgui.Text(u8'������ �� �����')
											imgui.Text(u8'������� �� �����')
											imgui.Text(u8'����� �� �����')
											imgui.Text(u8'����� �� �����')
											imgui.Text(u8'������ �� �����')
											imgui.Text(u8'����������� �� �����')
											imgui.Text(u8'������� ���� �� �����')
											imgui.Text(u8'�������� ������')

						end
						if imgui.CollapsingHeader(u8'� ����') then
											imgui.Text(u8'������� �� ���������������')
											imgui.Text(u8'������ �� ���������������')
											imgui.Text(u8'������� �� ��������������� �1')
											imgui.Text(u8'������� �� ��������������� �2')
											imgui.Text(u8'���� �� ���������������')
											imgui.Text(u8'���� ������')
											imgui.Text(u8'��� ��������')
											imgui.Text(u8'����� ����')
											imgui.Text(u8'��������')
											imgui.Text(u8'����� ������-�����')
											imgui.Text(u8'����������� �� �����')
											imgui.Text(u8'����� ���')
						end
						if imgui.CollapsingHeader(u8'�� �����') then
											imgui.Text(u8'������� �� �����')
											imgui.Text(u8'����� �� �����')
											imgui.Text(u8"��������� �� �����")
											imgui.Text(u8'��� �� �����')
											imgui.Text(u8'�������� ���(�������)')
											imgui.Text(u8'�������� ���(�����)')
											imgui.Text(u8'�������� ���(�����)')
											imgui.Text(u8'�������� ���(����-�����)')
											imgui.Text(u8'�������� ���(������-����-����������)')
											imgui.Text(u8'�������� ���(�����-���������-�����)')
											imgui.Text(u8'�������� ���(������-������)')
											imgui.Text(u8'������ �� �����')
						end
						if imgui.CollapsingHeader(u8'�� ������/����') then
											imgui.Text(u8'���� ������� �������')
											imgui.Text(u8'������ �1')
											imgui.Text(u8'����������� ������� �1')
											imgui.Text(u8'����������� ������� �2')
											imgui.Text(u8'������(���������)')
											imgui.Text(u8'������ �2')
											imgui.Text(u8'������ �3')
											imgui.Text(u8'����� ���������')
											imgui.Text(u8'�������')
											imgui.Text(u8'������� �����')
											imgui.Text(u8'����� �������')
											imgui.Text(u8'����� ��������')
											imgui.Text(u8'������� �����')
											imgui.Text(u8'����� �� �������')
											imgui.Text(u8'����� ���� � ��������')
											imgui.Text(u8'����� ������')
											imgui.Text(u8'���� ��������')
											imgui.Text(u8'����� �� ��������')
											imgui.Text(u8'VR-����')

											imgui.Text(u8'���������� ������ �� ������')
											imgui.Text(u8'����� �� ������������')
											imgui.Text(u8'������')
						end
						if imgui.CollapsingHeader(u8'������') then
										imgui.Text(u8'�������� �� ������ �����')
										imgui.Text(u8'�������� ����������')
										imgui.Text(u8'����������� Jet-pack #1')
										imgui.Text(u8'����������� Jet-pack #2')
										imgui.Text(u8'����������� Jet-pack #3')
										imgui.Text(u8'����������� Jet-pack #4')
										imgui.Text(u8'����������� Wings')
										imgui.Text(u8'����������� Reg Eyes')
										imgui.Text(u8'����������� Demon')
										imgui.Text(u8'���������� ���')
										imgui.Text(u8'��� �������')
						end
					end
					imgui.Separator()
					if imgui.CollapsingHeader(u8'������') then
						imgui.Text(u8'�������� �����')
						imgui.Text(u8'��������� �����')
						imgui.Text(u8'����������� �����')
						imgui.Text(u8'����� ����-����')
					end
					imgui.Separator()
				end

		imgui.EndChild()
		imgui.EndChild()
		imgui.PushFont(fontsize1)
			imgui.CenterTextColoredRGB1('����� ������� John Feat', imgui.ImVec2(690, 730))
		imgui.PopFont()
		imgui.SetCursorPos(imgui.ImVec2(800,615))
		if imgui.Button(u8'������� ����') then imgui.Process = not main_window_state.v end
    imgui.End()
end


function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end


function fast_lavka()
	lua_thread.create(function()
	   sampSendChat('/lavka')
		 wait(1000)
		sampSendDialogResponse(3021, 1, 1, '')
		wait(1000)
		sampSendDialogResponse(3020, 1, 0, ''..namelavki.v..'' )
		wait(1000)
		sampSendDialogResponse(3030, 1, 15, '')
	end)
end

function calc(params)
    if params == '' then
        sampAddChatMessage('�������������: /cal [������]', -1)
    else
        local func = load('return ' .. params)
        if func == nil then
            sampAddChatMessage('������.', -1)
        else
            local bool, res = pcall(func)
            if bool == false or type(res) ~= 'number' then
                sampAddChatMessage('������.', -1)

            else
                sampAddChatMessage('���������: ' .. res, -1)
            end
        end
    end
end


