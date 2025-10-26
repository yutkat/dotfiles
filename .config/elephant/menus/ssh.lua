function GetEntries()
  local entries = {}
  local ssh_config = os.getenv("HOME") .. "/.ssh/config"

  local handle = io.open(ssh_config, "r")
  if handle then
    for line in handle:lines() do
      local hostname = line:match("^%s*Host%s+([^%s*?]+)%s*$")
      if hostname and hostname ~= "" then
        table.insert(entries, {
          Text = hostname,
          Subtext = "ssh host",
          Value = hostname,
          Icon = ssh_config
        })
      end
    end
    handle:close()
  end

  return entries
end
