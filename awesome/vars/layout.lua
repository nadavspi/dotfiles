local qwerty = {
	name = 'qwerty',
	left = 'h',
	down = 'j',
	up = 'k',
	right = 'l'
}

local colemak = {
	name = 'colemak',
	left = 'm',
	down = 'n',
	up = 'e',
	right = 'i'
}

if os.getenv("KB_LAYOUT") == "qwerty" then
	return qwerty
else
	return colemak
end
