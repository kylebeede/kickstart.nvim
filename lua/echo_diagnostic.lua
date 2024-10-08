-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }

-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil

-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 250

-- The highlight group to use for warning messages.
local warning_hlgroup = 'WarningMsg'

-- The highlight group to use for error messages.
local error_hlgroup = 'ErrorMsg'

-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20

-- Shows the current line's diagnostics in a floating window.
local function show_line_diagnostics()
    vim.lsp.diagnostic.show_line_diagnostics({ min = 'Warning' }, vim.fn.bufnr(''))
end

-- Prints the first diagnostic for the current line.
local function echo_diagnostic()
    -- Stop the existing timer if it exists
    if echo_timer then
        echo_timer:stop()
    end

    -- Defer the function to ensure diagnostics are up-to-date
    echo_timer = vim.defer_fn(
        vim.schedule_wrap(function()
            -- Get the current line and buffer number
            local line = vim.fn.line('.') - 1
            local bufnr = vim.api.nvim_win_get_buf(0)

            -- Check if the last echoed message is the same as the current one
            if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
                return
            end

            -- Get diagnostics for the current line
            local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line, { min = 'Warning' })

            -- If there are no diagnostics, clear the last echoed message if it exists
            if #diagnostics == 0 then
                if last_echo[1] then
                    last_echo = { false, -1, -1 }
                    vim.api.nvim_command('echo ""')
                end
                return
            end

            -- Update the last echoed message information
            last_echo = { true, bufnr, line }

            -- Get the first diagnostic message
            local diagnostic = diagnostics[1]
            local width = vim.api.nvim_get_option('columns') - 15
            local lines = vim.split(diagnostic.message, '\n')
            local message = lines[1]

            -- If the message is short, add the second line to it
            if #lines > 1 and #message <= short_line_limit then
                message = message .. ' ' .. lines[2]
            end

            -- Trim the message if it exceeds the width
            if width > 0 and #message >= width then
                message = message:sub(1, width) .. '...'
            end

            -- Determine the kind and highlight group based on the severity
            local kind = 'warning'
            local hlgroup = warning_hlgroup

            if diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
                kind = 'error'
                hlgroup = error_hlgroup
            end

            -- Create the message chunks and echo them
            local chunks = {
                { kind .. ': ', hlgroup },
                { message },
            }

            vim.api.nvim_echo(chunks, false, {})
        end),
        echo_timeout
    )
end

return { show_line_diagnostics = show_line_diagnostics, echo_diagnostic = echo_diagnostic }
