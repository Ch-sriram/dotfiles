local M = {}

-- Helper to find the package name based on file path
local function get_package_name(path)
  -- Look for standard Maven/Gradle source roots
  local pattern = "src/main/java/"
  local start, finish = string.find(path, pattern)
  
  if not start then
    pattern = "src/test/java/"
    start, finish = string.find(path, pattern)
  end

  if start then
    -- Extract part after src/main/java/
    local relative_path = string.sub(path, finish + 1)
    -- Remove the filename (last component)
    local package_path = vim.fn.fnamemodify(relative_path, ":h")
    -- Convert / to .
    local package_name = string.gsub(package_path, "/", ".")
    if package_name == "." then return "" end
    return package_name
  end
  
  return ""
end

function M.create_java_class()
  local current_dir = vim.fn.expand("%:p:h")
  
  -- 1. Ask for the Name
  vim.ui.input({ prompt = "New Java File Name: " }, function(name)
    if not name or name == "" then return end
    
    -- Ensure .java extension
    if not name:match("%.java$") then
      name = name .. ".java"
    end
    
    -- 2. Ask for the Type (using Telescope UI Select)
    local options = { "Class", "Interface", "Enum", "Record", "Abstract Class" }
    
    vim.ui.select(options, { prompt = "Select Type:" }, function(type)
      if not type then return end
      
      local full_path = current_dir .. "/" .. name
      local class_name = vim.fn.fnamemodify(name, ":r") -- remove extension
      local package_name = get_package_name(full_path)
      local year = os.date("%Y")

      -- 3. Construct the Content
      local lines = {}

      -- Insert standard 
      table.insert(lines, "/**")
      table.insert(lines, " * " .. name)
      table.insert(lines, " *")
      table.insert(lines, " * Product: SCG")
      table.insert(lines, " * Strand Clinical Genomics")
      table.insert(lines, " *")
      table.insert(lines, " * Strand Life Sciences,")
      table.insert(lines, " * 7th Floor, MSR North Tower 144,")
      table.insert(lines, " * Dr Puneeth Rajkumar Road,")
      table.insert(lines, " * Outer Ring Rd, Venkateshapura,")
      table.insert(lines, " * Nagawara, Bengaluru,")
      table.insert(lines, " * Karnataka 560045")
      table.insert(lines, " *")
      table.insert(lines, " * Copyright 2007-" .. year .. ", All rights reserved.")
      table.insert(lines, " *")
      table.insert(lines, " * This software is the confidential and proprietary information")
      table.insert(lines, " * of Strand Life Sciences., (\"Confidential Information\").  You")
      table.insert(lines, " * shall not disclose such Confidential Information and shall use")
      table.insert(lines, " * it only in accordance with the terms of the license agreement")
      table.insert(lines, " * you entered into with Strand Life Sciences.")
      table.insert(lines, " */")

      -- Package Declaration
      if package_name ~= "" then
        table.insert(lines, "package " .. package_name .. ";")
        table.insert(lines, "")
      end
      
      -- Imports (Standard list or empty)
      -- table.insert(lines, "import java.util.*;") 
      -- table.insert(lines, "")
      
      -- Header / Javadoc
      table.insert(lines, "/**")
      table.insert(lines, " * *Briefly mention what your class does*")
      table.insert(lines, " *")
      table.insert(lines, " * @author " .. (os.getenv("USER") or "User"))
      table.insert(lines, " */")
      
      -- Type Definition
      local type_keyword = type:lower()
      if type == "Abstract Class" then type_keyword = "abstract class" end
      
      table.insert(lines, "public " .. type_keyword .. " " .. class_name .. " {")
      table.insert(lines, "")
      table.insert(lines, "    // TODO: Add your logic here")
      table.insert(lines, "")
      table.insert(lines, "}")

      -- 4. Create the file and write content
      local file = io.open(full_path, "w")
      if file then
        for _, line in ipairs(lines) do
          file:write(line .. "\n")
        end
        file:close()
        
        -- 5. Open the new file in Neovim
        vim.cmd("edit " .. full_path)
        
        -- Optional: Move cursor to the TODO line (approx line 12)
        vim.api.nvim_win_set_cursor(0, { #lines - 2, 4 })
        
        print("Created " .. full_path)
      else
        print("Error creating file: " .. full_path)
      end
    end)
  end)
end

return M

