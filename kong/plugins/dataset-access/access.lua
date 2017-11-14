local responses = require "kong.tools.responses"

local _M = {}

function _M.execute(conf)
  request_path=ngx.var.uri
  for _,id in ipairs(conf.whitelist) do
    pattern=conf.template:gsub("$dataset_id",id)
    ngx.log(ngx.ERR, "Test request "..request_path.." against "..pattern)
    if ngx.re.match(request_path,pattern) then
      ngx.log(ngx.ERR, "Dataset match found for "..request_path)
    else
      ngx.log(ngx.ERR, "Dataset match not found for "..request_path)
      return responses.send_HTTP_FORBIDDEN("Dataset access not authorized")
    end
  end
end

return _M