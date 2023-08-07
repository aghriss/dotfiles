local S = {}

-- define the files for each language
-- new words will be added to the last file in the language table
S.dictionaries = {
	["en-US"] = { vim.env.HOME .. "/assets/spell/en.txt" },
}

-- function to avoid interacting with the table directly
function S.getDictFiles(lang)
	local files = S.dictionaries[lang]
	if files then
		return files
	else
		return nil
	end
end

-- combine words from all the files. Each line should contain one word
function S.readDictFiles(lang)
	local files = S.getDictFiles(lang)
	local dict = {}
	if files then
		for _, file in ipairs(files) do
			local f = io.open(file, "r")
			if f then
				for l in f:lines() do
					table.insert(dict, l)
				end
            else
                print("Can not read dict file %q", file)
			end
		end
    else
        print("Lang %q has no files", lang)
	end
	return dict
end

-- Append words to the last element of the language files
function S.addWordsToFiles(lang, words)
	local files = S.getDictFiles(lang)
	if not files then
		return print("no dictionary file defined for lang %q", lang)
	else
		local file = io.open(files[#files - 0], "a+")
		if file then
            for _,word in ipairs(words) do
			file:write(word .. "\n")
            end
			file:close()
		else
			return print("Failed insert %q", vim.inspect(words))
		end
	end
end

return S
