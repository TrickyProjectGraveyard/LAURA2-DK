--[[
	LAURA 2 DK
	Create Project
	
	
	
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
Version: 17.04.23
]]
JCR_Dirs = { 'AUDIO',
             'DATA',
             'FONTS',
             'GFX',
             'KTHURA',
             'LANGUAGES',
             'MUSIC',
             'SCRIPT/Char',
             'SCRIPT/Events',
             'SCRIPT/Flow',
             'SCRIPT/Init',
             'SCRIPT/Flow',
             'SCRIPT/JINC',
             'SCRIPT/LIBS',
             'SCRIPT/Maps',
             'SCRIPT/OSBOOT',
             'SCRIPT/Subs',
             'SCRIPT/System',
             'SCRIPT/Use/Anyway',
             'SCRIPT/Use/Linkers',
             'VOCALS',
             "FORMS" -- And this dir should be reserved for Launcher forms, which will just like this DK be written in Maan :)
           }

           
function CreateProject(dir,Template)
      --MAAN_Hide("FORM_ProjectManager")
      MAAN_Hide("KIDS_PANEL_PPanelProjectManagement")
      CSay("Creating needed dirs")
      for d in each(JCR_Dirs) do
          CSay("Creating dir: "..dir.."/"..d)
          if not MkDir(dir.."/"..d,true) then 
             alert("Project creation failed!\n\nI could not create: "..dir.."/"..d)
             MAAN_Show ("FORM_ProjectManager")
             return
          end
      end
      if Template:sub(1,1)~="*" then
         -- Template specific stuff
      end
      local prj = { Title=MAAN_Text('KID_TEXTFIELD_Title'), 
                    OSUser=MAAN_SYS_UserName(), 
                    Created=os.date(),                   
                    SrcMeta={Owner=MAAN_SYS_UserName()},
                    JCRID={},
                    GameJolt={},
                    PackageDirs = { Mac=Dirry("$Home$/MyGame.app"), Win=Dirry("$Home$\\MyGame"), Lin=Dirry("$Home$/MyGame")}
                    }
      MAAN_SaveVar(prj,dir.."/L2DKProject.lua")
      alert("Project created!\nHave fun!")
      projectlist[MAAN_Text('KID_TEXTFIELD_Title')] = { dir=dir}
      MAAN_SaveVar(projectlist,"ProjectList.lua")      
      MAAN_Show('KID_PANEL_WorkPanel')
end
