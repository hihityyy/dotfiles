--!nonstrict
-- Translator launcher provider using MyMemory API.
-- Fixed: Proper URL construction to avoid '$' artifacts in langpair

local DEFAULT_TARGET = noctalia.getConfig("target_lang")
DEFAULT_TARGET = if type(DEFAULT_TARGET) == "string" and DEFAULT_TARGET ~= "" then DEFAULT_TARGET else "en"

local MYMEMORY_KEY = noctalia.getConfig("mymemory_key") or ""

local LANGUAGES = {
  ar = { "arabic", "arabe" }, cs = { "czech", "tcheque" },
  de = { "german", "allemand", "deutsch" }, el = { "greek", "grec" },
  en = { "english", "anglais" }, es = { "spanish", "espagnol", "espanol" },
  fa = { "persian", "farsi", "persan" }, fi = { "finnish", "finnois" },
  fr = { "french", "francais" }, he = { "hebrew", "hebreu" },
  hi = { "hindi" }, hu = { "hungarian", "hongrois" },
  id = { "indonesian", "indonesien" }, it = { "italian", "italien" },
  ja = { "japanese", "japonais" }, ko = { "korean", "coreen" },
  nl = { "dutch", "neerlandais" }, no = { "norwegian", "norvegien" },
  pl = { "polish", "polonais" }, pt = { "portuguese", "portugais" },
  ro = { "romanian", "roumain" }, ru = { "russian", "russe" },
  sv = { "swedish", "suedois" }, tr = { "turkish", "turc" },
  uk = { "ukrainian", "ukrainien" }, vi = { "vietnamese", "vietnamien" },
  zh = { "chinese", "chinois", "mandarin" },
}

local cache = {}
local pending = {}

local function resolveLang(token)
  local lower = token:lower()
  for code, aliases in LANGUAGES do
    if code == lower or table.find(aliases, lower) then return code end
  end
  if lower:match("^%a%a%a?$") then return lower end
  return nil
end

local function fetchMyMemory(text, source, target, onDone)
  -- FIX: Use string concatenation instead of template literals to avoid '$' issues
  local srcCode = (source == "auto") and "Autodetect" or source
  local langPair = srcCode .. "|" .. target
  
  local baseUrl = "https://api.mymemory.translated.net/get?q=" .. noctalia.string.urlEncode(text) 
                .. "&langpair=" .. langPair
                
  local url = baseUrl
  if MYMEMORY_KEY ~= "" then
    url = baseUrl .. "&key=" .. MYMEMORY_KEY
  end

  pcall(function()
    noctalia.http({ url = url }, function(res)
      if not res or not res.ok then
        onDone(nil, "HTTP " .. tostring(res and res.status or "?"))
        return
      end
      
      local ok, decoded = pcall(noctalia.json.decode, res.body)
      if ok and decoded and decoded.responseStatus == 200 then
        local translation = decoded.responseData.translatedText
        -- Clean HTML entities sometimes returned by MyMemory
        translation = translation:gsub("&quot;", '"'):gsub("&amp;", "&"):gsub("&lt;", "<"):gsub("&gt;", ">")
        onDone(translation, nil)
      else
        local err = decoded and decoded.responseDetails or "Translation failed"
        onDone(nil, err)
      end
    end)
  end)
end

local function hintRow(title, subtitle, glyph)
  return { id = title, title = title, subtitle = subtitle, glyph = glyph }
end

local function resultRow(translated, target)
  return {
    id = translated, title = translated,
    subtitle = "Translation (" .. target .. ") — press Enter to copy",
    glyph = "language", presentation = "detail",
  }
end

function onQuery(query)
  local text = noctalia.string.trim(query)
  if text == "" then
    launcher.setResults(query, { hintRow("Translate text", "Type: <lang> <text> — e.g. es hello", "language") })
    return
  end

  local first, rest = text:match("^(%S+)%s+([%s%S]*)$")
  local target, content, source
  if first then
    local code = resolveLang(first)
    if code then target = code; content = rest; source = "auto"
    else target = DEFAULT_TARGET; content = text; source = "auto" end
  else
    if resolveLang(text) then
      launcher.setResults(query, { hintRow("Type text to translate", "Target language: " .. text, "language") })
      return
    end
    target = DEFAULT_TARGET; content = text; source = "auto"
  end

  if noctalia.string.trim(content) == "" then
    launcher.setResults(query, { hintRow("Type text to translate", "Target language: " .. target, "language") })
    return
  end

  local key = target .. "|" .. content
  if cache[key] then
    launcher.setResults(query, { resultRow(cache[key], target) })
    return
  end

  launcher.setResults(query, { hintRow("Translating…", content, "loader") })
  if not pending[key] then
    pending[key] = true
    fetchMyMemory(content, source, target, function(translated, err)
      pending[key] = nil
      if translated then
        cache[key] = translated
        launcher.setResults(query, { resultRow(translated, target) })
      else
        launcher.setResults(query, { hintRow(err or "Error", content, "alert-triangle") })
      end
    end)
  end
end

function onActivate(id)
  if id ~= "" then
    noctalia.copyToClipboard(id, "text/plain")
    noctalia.notify("Translator", "Copied to clipboard")
  end
end
