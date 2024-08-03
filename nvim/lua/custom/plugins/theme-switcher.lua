-- File to store the selected theme
local theme_file = vim.fn.stdpath('config') .. '/selected_theme.txt'

local function setup(params)
    if params.file_path then
        theme_file = params.file_path
    end
end

-- Save the theme to the file
local function save_theme(theme)
    local file = io.open(theme_file, "w")
    if file then
        file:write(theme)
        file:close()
        -- print("Saved theme: ", theme)
    else
        vim.api.nvim_err_writeln("Failed to save theme to " .. theme_file)
    end
end

local function apply_theme(theme)
    local status = pcall(vim.cmd, 'colorscheme ' .. theme)
    if not status then
        vim.api.nvim_err_writeln("Failed to apply theme: " .. theme)
    end
end

-- Load the theme from the file
local function load_theme()
    local file = io.open(theme_file, "r")
    if file then
        local theme = file:read("*l")
        file:close()
        if theme then
            apply_theme(theme)
        end
    end
end

-- Function to select a theme using Telescope
local function select_theme()
    require('telescope.builtin').colorscheme({
        -- enable_preview = true,
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local entry = require('telescope.actions.state').get_selected_entry()
                local theme = entry.value
                require('telescope.actions').close(prompt_bufnr)
                apply_theme(theme)
                save_theme(theme)
            end)
            return true
        end,
    })
end

load_theme()

return {setup = setup, select_theme = select_theme, load_theme = load_theme, apply_theme = apply_theme}
