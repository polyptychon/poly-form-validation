module.exports = (url, obj) ->
  for name,value of obj
    regx = new RegExp(":"+name)
    url = url.replace(regx, obj[name])
  return url;
