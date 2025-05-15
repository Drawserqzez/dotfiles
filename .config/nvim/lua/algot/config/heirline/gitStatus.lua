local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local GitBlock = {
    condition = conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = { fg = "orange" },
}

local BranchBlock = {
    condition = function()
        return conditions.is_git_repo
    end,
    provider = " ",
    {
        utils.surround({"(", ")"}, nil,
        {
            provider = function(self)
                local branch = self.status_dict.head

                local issuePattern = "^([fF][eE][dD]%-%d%d%d%d?)"
                local featureBranchPattern = "^([^/]+)/([^/]+)"

                if not conditions.width_percent_below(#branch, 0.25) then
                    local issueMatch = string.match(branch, issuePattern)

                    if issueMatch then
                        return issueMatch
                    end

                    local beforeSlash, afterSlash = string.match(branch, featureBranchPattern)

                    if beforeSlash and afterSlash then
                        return beforeSlash.sub(1, 2) .. "/" .. afterSlash
                    end
                end

                return branch
            end,
        })
    },
    hl = { bold = true },
}

GitBlock = utils.insert(GitBlock,
    BranchBlock,
    {
        condition = function(self)
            return self.has_changes
        end,
        utils.surround({ '[', ']' }, "bright_bg",
        {
            {
                provider = function(self)
                    local count = self.status_dict.added or 0
                    return count > 0 and ("+" .. count)
                end,
                hl = { fg = "git_add" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.removed or 0
                    return count > 0 and ("-" .. count)
                end,
                hl = { fg = "git_del" },
            },
            {
                provider = function(self)
                    local count = self.status_dict.changed or 0
                    return count > 0 and ("~" .. count)
                end,
                hl = { fg = "git_change" },
            }
        })
    }
)

return GitBlock
