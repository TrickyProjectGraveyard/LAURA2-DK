--[[
	LAURA II DK
	Kthura settings
	
	
	
	(c) Jeroen P. Broks, 2017, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
Version: 17.05.08
]]
KthuraHelp = {


             GENERALDATA = "Kthura Maps can handle quite a number of metadata fields\n\nEach field is able to hold a string value.\nYou can use these fields for many things.\nIn the Fairy Tale REVAMPED these fields were used to decide the battle arena, the background music and the enemies you can meet.\nIt's completely up to you what to set up here yourself.\n\nStart each variable name on a new line, and make sure you don't have duplicates.\nYou can also put *strike* on a line to create a separator line in the meta data editor.\n\nYou don't have any influence on the order in which Kthura saves these fields inside a map files, but the order you use here will always be the same order in which Kthura shows the fields in the editor.",
             CSPOTS = "Kthura does allow you to put spots on the map that are very specific in meaning for your game only.\nA very nice usage of these spots was shown in 'Star Story' where the enemy spots where created with this feature.\n\nIt can allow to do more, like putting an entire series of objects near each other.\nThe transporter in Marrilona's Path of Magic dungeon are a great example of this, where a turning disc was only meant for the player's eyes, while a (for the player invisible) zone made the computer detect if Marrilona actually stepped onto the teleporter or not.\n\nStart each spot name on a new line and prefix them with a '$'. Spots not prefixed like that will be ignored.\n\nFurthermore, the Kthura editor will need to be scripted in order to make it able to know how to handle these spots.\nJust like LAURA II, Kthura uses Lua for this.",
             LINES = "Lines can be used to put some lines in the editor screen.\nI've used these lines myself as a marker for the max screen size in Star Story.\n\nIf the lines annoy you can can easily turn them off in the editor by pressing Command-L if you are on Mac, and Ctrl-L when you are on Windows.\n\nEach line need its own line and needs to be set up with this syntax <startx>:<starty>:<endx>:<endy>"

}

function KthuraDir()
    return project.dir.."/Kthura"
end

function KthuraScriptFile()
    return KthuraDir().."/Scripts/Projects/KthuraProject.lua"
end


function KID_BUTTON_KthuraHelp_Action(idx)
      alert(idx.."\n\n"..(KthuraHelp[idx] or "No help available for this subject yet!"))
end      


function KID_TEXTAREA_Kthura_Action(idx)
     project.kthura[idx] = MAAN_Text('KID_TEXTAREA_Kthura#'..idx)
end     


function KID_BUTTON_KthuraScript_Action()
    if not IsFile(KthuraScriptFile()) then
       local n = NProceed("The Kthura Script file has not been found. I can generate one based on your current fields if you desire.\n\nDo you want me to do so?")
       if n==-1 then return end
       
       local content = ""
       local acts = {"Place","Show","Clicked"}
       if n==1 then
          content ="--[[ This file has been generated by the LAURA II DK\n\n     You may however use and license it any way you see fit ]]\n\n"
          local fields=mysplit(project.kthura.CSPOTS,"\n")
          for f in each(fields) do
              content = content .. "\n"
              if left(f,1)=="$"  then
                 for a in each(acts) do
                     content = content .."\nfunction CSpot_"..right(f,#f-1).."_"..a.."()\n\t-- code --\nend\n" 
                 end
              end
          end
          --alert('Data to be saved:\n\n'..content) -- debug line ;)
       end
       MkDir(KthuraDir().."/Scripts/Projects",true)
       local bt = io.open(KthuraScriptFile(),"w")
       if not bt then return alert("ERROR!\n\nI could not create: "..KthuraScriptFile()) end
       bt:write(content)
       bt:close() 
    end
    -- @IF $MAC
    CSay("executing: ".."open -a '"..GetCFG('Script').."' --args '"..KthuraScriptFile().."'")
    os.execute("open -a '"..GetCFG('Script').."' --args '"..KthuraScriptFile().."'")
    -- @FI
    -- @IF $WINDOWS
    os.execute("'"..GetCFG('Script').."' '"..KthuraScriptFile().."'")
    -- @FI
    -- @IF $LINUX
    os.execute("'"..GetCFG('Script').."' '"..KthuraScriptFile().."'")
    -- @FI       
end
