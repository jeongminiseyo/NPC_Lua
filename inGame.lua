-----------------------------------------------------------------------------------------
--
-- inGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 배경
	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	background:setFillColor(1)
	sceneGroup:insert(background)

	-- 버튼 
	local button = display.newImage("image/push.png")
	button.x, button.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(button)

	-- 점수 
	local score = 0
	local showScore = display.newText(score, display.contentWidth*0.05, display.contentHeight*0.08)
	showScore:setFillColor(0)
	showScore.size = 100
	sceneGroup:insert(showScore)

	-- push 이벤트
	local function push( event )
		local obj = event.target
		local pushed_button = display.newImage("image/pushed.png")
		pushed_button.x, pushed_button.y = display.contentWidth/2, display.contentHeight/2
		transition.to(button, {delay = 0, alpha = 0, time = 0})
		transition.to(obj, {delay = 0, alpha = 0, time = 0})
		transition.cancel()
		transition.to(pushed_button, {delay = 30, alpha = 0, time = 0})

		score = score + 1
		showScore.text = score

	end
	button:addEventListener("tap", push)

	-- 시간제한 
	local limit = 10
	local showLimit = display.newText(limit, display.contentWidth * 0.9, display.contentHeight * 0.1)
	showLimit:setFillColor(0)
	showLimit.size = 100
	sceneGroup:insert(showLimit)

	local function timeLimit( event )
		limit = limit -1
		showLimit.text = limit

		if limit == 0 then
			composer.setVariable("score", score)
			composer.gotoScene("result")
		end

	end
	timer.performWithDelay(1000, timeLimit, 0)
	timer.resume()
	
end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene