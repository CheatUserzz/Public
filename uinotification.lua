local Utilities = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Notifications = {}
local Objects = {}

local GUI = Instance.new("ScreenGui")
GUI.Name = "NotificationGUI"
GUI.ResetOnSpawn = false
GUI.Parent = game.CoreGui

-- Container centralizado no topo
local Container = Instance.new("Frame")
Container.Name = "NotificationContainer"
Container.Size = UDim2.new(0, 250, 0, 0)
Container.Position = UDim2.new(0.5, 0, 0, 20) -- 20 pixels do topo
Container.AnchorPoint = Vector2.new(0.5, 0)
Container.BackgroundTransparency = 1
Container.Parent = GUI

-- Função auxiliar para criar instâncias
function Utilities.CreateInstance(class, properties)
	local obj = Instance.new(class)
	for i,v in pairs(properties) do
		obj[i] = v
	end
	table.insert(Objects, obj)
	return obj
end

-- Criar uma notificação
function Notifications.Create(Title, Desc, Time, TitleColor)
	local Frame = Utilities.CreateInstance("Frame", {
		Size = UDim2.new(0, 250, 0, 70),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		BorderColor3 = Color3.fromRGB(255,255,255),
		BorderSizePixel = 1,
		Parent = Container,
		Position = UDim2.new(0,0,#Container:GetChildren()*75), -- espaçamento de 5px
		AnchorPoint = Vector2.new(0,0)
	})
	
	-- UI Corner
	Utilities.CreateInstance("UICorner", {
		CornerRadius = UDim.new(0,6),
		Parent = Frame
	})
	
	-- Drop Shadow
	local Shadow = Utilities.CreateInstance("ImageLabel", {
		Parent = Frame,
		Size = UDim2.new(1,12,1,12),
		Position = UDim2.new(0,-6,0,-6),
		BackgroundTransparency = 1,
		Image = "rbxassetid://6014261993",
		ImageColor3 = Color3.new(0,0,0),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49,49,450,450)
	})
	
	-- Title
	local TitleLabel = Utilities.CreateInstance("TextLabel", {
		Text = Title,
		TextColor3 = TitleColor or Color3.fromRGB(255,255,255),
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0,10,0,5),
		Size = UDim2.new(1,-20,0,20),
		Parent = Frame
	})
	
	-- Description
	local DescLabel = Utilities.CreateInstance("TextLabel", {
		Text = Desc,
		TextColor3 = Color3.fromRGB(230,230,230),
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0,10,0,25),
		Size = UDim2.new(1,-20,0,40),
		Parent = Frame
	})
	
	-- Animar entrada
	Frame.Position = UDim2.new(0.5,0,-1,0)
	TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5,0,0,20 + (#Container:GetChildren()-1)*75)}):Play()
	
	-- Timeline
	task.spawn(function()
		task.wait(Time)
		TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = Frame.Position + UDim2.new(0,0,0,100)}):Play()
		task.wait(0.5)
		Frame:Destroy()
	end)
end

-- Limpar notificações
function Notifications.Clear()
	for _,v in pairs(Objects) do
		if v and v.Parent then
			v:Destroy()
		end
	end
end

return Notifications
