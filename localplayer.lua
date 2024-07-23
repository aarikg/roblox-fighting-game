

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local replicatedStorage = game:GetService("ReplicatedStorage")


humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
humanoid.JumpPower = 0
humanoid.UseJumpPower = true


local leftJab = Instance.new("Animation")
leftJab.AnimationId = "rbxassetid://10676441659"
local leftJabTrack = humanoid:LoadAnimation(leftJab)

local rightJab = Instance.new("Animation")
rightJab.AnimationId = "rbxassetid://10676448956"
local rightJabTrack = humanoid:LoadAnimation(rightJab)

local block = Instance.new("Animation")
block.AnimationId = "rbxassetid://18619136473"
local blockTrack = humanoid:LoadAnimation(block)
blockTrack.Priority = Enum.AnimationPriority.Action4




local ActionEvent = replicatedStorage:WaitForChild("ActionEvent")


local function sendActionEvent(actionType)
	ActionEvent:FireServer(actionType)
end


local userInputService = game:GetService("UserInputService")

userInputService.InputBegan:Connect(function(input, processed)
	if processed then return end

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		leftJabTrack:Play()
		sendActionEvent("Left Jab")
	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
		rightJabTrack:Play()
		sendActionEvent("Right Jab")
	elseif input.KeyCode == Enum.KeyCode.Space then
		blockTrack:Play()
		sendActionEvent("Block")

		
	end
end)
