--Config
local GroundBrightnessConfig = 2 --Default 2
local ColorCorrectionConfig = 0.065 --Default 0.065
local BrightnessChangeTime = 3 --Default 3
local ColorCorrectionChangeTime = 5 --Default 3


--Script
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local rayDirection = game.Lighting:GetSunDirection()
local char = game.Players.LocalPlayer.Character
local RAY_LENGTH = 30
local ColorCorrection = Lighting.ColorCorrection


local BrightnessInfo = TweenInfo.new(
	BrightnessChangeTime,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false,
	0.5
)

local ColorCorrectioneInfo = TweenInfo.new(
	ColorCorrectionChangeTime,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false,
	1
)

local BrightnessInfoe = TweenInfo.new(
	BrightnessChangeTime + 1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false,
	0
)

local ColorCorrectionInfoe = TweenInfo.new(
	ColorCorrectionChangeTime + 1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false,
	0
)

local brightness = {
	Brightness = Lighting.Brightness + GroundBrightnessConfig
}

local colorcorrection = {
	Brightness = Lighting.ColorCorrection.Brightness - ColorCorrectionConfig
}

local brightnesse = {
	Brightness = Lighting.Brightness
}

local colorcorrctione = {
	Brightness = Lighting.ColorCorrection.Brightness
}

local DarkBrightness = TweenService:Create(Lighting, BrightnessInfo, brightness)
local DarkColorCorrection = TweenService:Create(ColorCorrection, ColorCorrectioneInfo, colorcorrection)
local DarkBrightnesse = TweenService:Create(Lighting, BrightnessInfoe, brightnesse)
local DarkColorCorrectione = TweenService:Create(ColorCorrection, ColorCorrectionInfoe, colorcorrctione)
game:GetService("RunService"):BindToRenderStep("SunService",Enum.RenderPriority.Camera.Value + 1,function()
	local ray = Ray.new(char.HumanoidRootPart.Position,rayDirection * RAY_LENGTH)
	local partFound = workspace:FindPartOnRay(ray,char)
	if partFound then
		DarkBrightness:Play()
		DarkColorCorrection:Play()
	else
		DarkBrightnesse:Play()
		DarkColorCorrectione:Play()
	end  
end)

Lighting:GetPropertyChangedSignal("TimeOfDay"):Connect(function()
	rayDirection = Lighting:GetSunDirection()
end)
