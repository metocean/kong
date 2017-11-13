
local _M = {}

function _M.execute(conf)
  require('mobdebug').start('192.168.2.84')
  for _,id in ipairs(conf.whitelist) do
    pattern=conf.template:gsub("$dataset_id",id)
    ngx.log(ngx.ERR, pattern)
  end
end

return _M