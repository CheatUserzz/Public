local Utilities = {}
local Objects = {}
local TweenService = game:GetService("TweenService")

local function randomletters(len)
	local str = ""
	for i = 1, len do
		str = str .. string.char(math.random(65, 90)) .. "-" .. string.char(math.random(5, 8))
	end
	return str
end

function Utilities.CreateInstance(class, properties)
	local obj = Instance.new(class)
	if properties.Parent then
		obj.Parent = properties.Parent
	end
	for prop, value in next, properties do
		obj[prop] = value
	end
	table.insert(Objects, obj)
	return obj
end

local GUI = Instance.new("ScreenGui")
GUI.Name = randomletters(10)
GUI.ResetOnSpawn = false
GUI.Parent = game.CoreGui

local Notifications = {}

function Notifications.Create(Title, Desc, Time, TitleColor)
	assert(typeof(Title) == "string", "Title must be a string!")
	assert(typeof(Time) == "number", "Time must be a number!")

	local Frame = Utilities.CreateInstance("Frame", {
		Name = randomletters(10),
		Parent = GUI,
		Size = UDim2.new(0, 240, 0, 60),
		Position = UDim2.new(1.27, 0, 1, 0),
		AnchorPoint = Vector2.new(1,1),
		BackgroundColor3 = Color3.fromRGB(24,25,26),
		BorderSizePixel = 0,
		ZIndex = 1,
		Visible = true
	})
	Frame:TweenPosition(UDim2.new(1,0,1,0), "In", "Quad", 1)

	-- UICorner
	Utilities.CreateInstance("UICorner", {CornerRadius = UDim.new(0,2), Parent = Frame})

	-- Title Frame
	local TitleFrame = Utilities.CreateInstance("Frame", {
		Name = "TitleFrame",
		Parent = Frame,
		Size = UDim2.new(0,240,0,16),
		Position = UDim2.new(0,0,0,0),
		AnchorPoint = Vector2.new(0,0),
		BackgroundColor3 = Color3.fromRGB(25,26,27),
		BorderSizePixel = 0,
		ZIndex = 1
	})
	Utilities.CreateInstance("UICorner", {CornerRadius = UDim.new(0,2), Parent = TitleFrame})

	-- Title Label
	local TitleLabel = Utilities.CreateInstance("TextLabel", {
		Name = "TextLabel",
		Parent = TitleFrame,
		Size = UDim2.new(0,233,0,17),
		Position = UDim2.new(0.025,0,-0.051,0),
		BackgroundTransparency = 1,
		Text = Title,
		TextColor3 = TitleColor,
		TextSize = 12,
		TextScaled = true,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTransparency = 1,
		Visible = true,
		ZIndex = 1
	})

	-- Description
	local Description = Utilities.CreateInstance("TextLabel", {
		Name = "Desc",
		Parent = Frame,
		Size = UDim2.new(0,239,0,42),
		Position = UDim2.new(0,0,0.267,0),
		BackgroundTransparency = 1,
		Text = tostring(Desc),
		TextColor3 = Color3.fromRGB(213,213,213),
		TextSize = 12,
		TextScaled = true,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextTransparency = 1,
		ZIndex = 1,
		Visible = true
	})

	-- Drop Shadow
	local ShadowHolder = Utilities.CreateInstance("Frame", {
		Name = "DropShadowHolder",
		Parent = Frame,
		Size = UDim2.new(1,0,1,0),
		Position = UDim2.new(0,0,0,0),
		BackgroundTransparency = 1,
		ZIndex = 1
	})
	Utilities.CreateInstance("ImageLabel", {
		Name = "DropShadow",
		Parent = ShadowHolder,
		Size = UDim2.new(1,47,1,47),
		Position = UDim2.new(0.5,0,0.5,0),
		BackgroundTransparency = 1,
		Image = "rbxassetid://6014261993",
		ImageColor3 = Color3.fromRGB(0,0,0),
		ImageTransparency = 0.5,
		ResampleMode = Enum.ResamplerMode.Default,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49,49,450,450),
		SliceScale = 1,
		ZIndex = 0,
		Visible = true
	})

	-- Tween Text
	task.wait(0.8)
	for _,v in next, Frame:GetDescendants() do
		if v:IsA("TextLabel") then
			TweenService:Create(v, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
		end
	end

	task.wait(1.5)
	for _,v in next, Frame:GetDescendants() do
		if v:IsA("TextLabel") then
			TweenService:Create(v, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
		end
	end

	task.wait(Time - 0.5)
	Frame:TweenPosition(UDim2.new(1.27,0,1,0), "In", "Quad", 1)
end

function Notifications.Clear()
	GUI:Destroy()
end

return Notifications
