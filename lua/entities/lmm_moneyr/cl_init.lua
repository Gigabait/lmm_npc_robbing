include('shared.lua')

surface.CreateFont( "LMMNPCRBounceFont", {
	font = "Lato Light",
	size = 80,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )

surface.CreateFont( "fontclose", {
	font = "Lato Light",
	size = 25,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )
 
surface.CreateFont( "LMMNPCRTitleFont", {
	font = "Lato Light",
	size = 30,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )
 
surface.CreateFont( "LMMNPCRNameFont", {
	font = "Lato Light",
	size = 46,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )
 
surface.CreateFont( "LMMNPCRNameFontSmall", {
	font = "Lato Light",
	size = 34,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )
 
surface.CreateFont( "LMMNPCRJobFont", {
	font = "Lato Light",
	size = 20,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )
 
local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount) --Panel blur function
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 6 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end
 
local function drawRectOutline( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( x, y, w, h )
end

net.Receive("LMMNPCROpenConfigMoney", function()
	local ent = net.ReadEntity()

	local DFrame = vgui.Create( "DFrame" )
	DFrame:SetSize( 300, 200 )
	DFrame:Center()
	DFrame:SetDraggable( true )
	DFrame:MakePopup()
	DFrame:SetTitle( "" )
	DFrame:ShowCloseButton( false )
	DFrame.Paint = function( self, w, h )
		DrawBlur(DFrame, 2)
		drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
		drawRectOutline( 2, 2, w - 4, h / 4.9, Color( 0, 0, 0, 85 ) )
		draw.RoundedBox(0, 2, 2, w - 4, h / 5, Color(0,0,0,125))
		draw.SimpleText( "LMM NPCR Config!", "LMMNPCRTitleFont", DFrame:GetWide() / 2, 25, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	local frameclose = vgui.Create( "DButton", DFrame )
	frameclose:SetSize( 35, 35 )
	frameclose:SetPos( DFrame:GetWide() - 36,9 )
	frameclose:SetText( "X" )
	frameclose:SetFont( "fontclose" )
	frameclose:SetTextColor( Color( 255, 255, 255 ) )
	frameclose.Paint = function()
		
	end
	frameclose.DoClick = function()
		DFrame:Close()
		DFrame:Remove()
	end
	
	local TextEntry = vgui.Create( "DTextEntry", DFrame )
	TextEntry:SetPos( 5, 65 )
	TextEntry:SetSize( DFrame:GetWide() - 10, 20 )
	TextEntry:SetText( "NPC ID (must match the npc you want the money to spawn for)" )
	TextEntry.OnEnter = function( self )

	end	

	local TextEntry2 = vgui.Create( "DTextEntry", DFrame )
	TextEntry2:SetPos( 5, 100 )
	TextEntry2:SetSize( DFrame:GetWide() - 10, 20 )
	TextEntry2:SetText( "Min amount to spawn every x sec (in config)" )
	TextEntry2.OnEnter = function( self )

	end	

	local TextEntry3 = vgui.Create( "DTextEntry", DFrame )
	TextEntry3:SetPos( 5, 135 )
	TextEntry3:SetSize( DFrame:GetWide() - 10, 20 )
	TextEntry3:SetText( "Max amount to spawn every x sec (in config)" )
	TextEntry3.OnEnter = function( self )

	end	

	local submittButton = vgui.Create( "DButton", DFrame )
	submittButton:SetPos( 5, 170 )
	submittButton:SetSize( DFrame:GetWide() - 10,20 )
	submittButton:SetText( "Submit NPC" )
	submittButton:SetTextColor( Color( 255, 255, 255 ) )	
	submittButton.Paint = function( self, w, h )		
		DrawBlur(submittButton, 2)
		drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
	end
	submittButton.DoClick = function()
		net.Start("LMMNPCRCreateNPCMoney")
			net.WriteEntity(ent)
			net.WriteString(TextEntry:GetValue())
			net.WriteString(TextEntry2:GetValue())
			net.WriteString(TextEntry3:GetValue())
		net.SendToServer()
		DFrame:Close()
	end		
end)

/*
local function LMMNPCRBounceFunction()
	for k, v in pairs( ents.FindByClass( "lmm_npcr" ) ) do   
		local p
		
		p = v:GetPos() + Vector(0,0,90 + math.sin(CurTime()*3)*5)
	   
		for _,yaw in pairs({0, 180}) do

			local a = Angle(0, 0, 0)
			a:RotateAroundAxis(a:Forward(), 90)
			a:RotateAroundAxis(a:Right(), yaw)	   
			a:RotateAroundAxis(a:Right(), CurTime() * 15)

			local name = v:GetNWString("LMMNPCRName") or ""
			local id = v:GetNWString("LMMNPCRID") or 0
			local colorr = v:GetNWFloat("LMMNPCRColorR") or 255
			local colorg = v:GetNWFloat("LMMNPCRColorG") or 0
			local colorb = v:GetNWFloat("LMMNPCRColorB") or 0
			local colora = v:GetNWFloat("LMMNPCRColorA") or 255

			
			render.PushFilterMag(TEXFILTER.ANISOTROPIC)
			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
			cam.Start3D2D(p, a, 0.1)
				if LMMNPCRConfig.DevMode == true then
					draw.DrawText(name.."("..id..")", "LMMNPCRBounceFont", 0, 0, Color(colorr, colorg, colorb, colora), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.DrawText(name, "LMMNPCRBounceFont", 0, 0, Color(colorr, colorg, colorb, colora), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)				
				end
			cam.End3D2D()
			render.PopFilterMag()
			render.PopFilterMin()
		end
	end
end 
hook.Add( "PostDrawOpaqueRenderables", "LMMNPCRBounceFunction", LMMNPCRBounceFunction)
*/