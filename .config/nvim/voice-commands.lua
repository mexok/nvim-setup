vim.g.vcmd.define_replacement("null", "0");
vim.g.vcmd.define_replacement("eins", "1");
vim.g.vcmd.define_replacement("zwei", "2");
vim.g.vcmd.define_replacement("drei", "3");
vim.g.vcmd.define_replacement("vier", "4");
vim.g.vcmd.define_replacement("fünf", "5");
vim.g.vcmd.define_replacement("sechs", "6");
vim.g.vcmd.define_replacement("sieben", "7");
vim.g.vcmd.define_replacement("acht", "8");
vim.g.vcmd.define_replacement("neun", "9");
vim.g.vcmd.define_replacement("zehn", "10");
vim.g.vcmd.define_replacement("elf", "11");
vim.g.vcmd.define_replacement("es", "11");
vim.g.vcmd.define_replacement("zwölf", "12");

vim.g.vcmd.set('i', {"gleich", "fleisch"}, "=")
vim.g.vcmd.set('i', "achtung", "!")
vim.g.vcmd.set('i', "text", "\"")
vim.g.vcmd.set('i', {"fett", "bett"}, "$")
vim.g.vcmd.set('i', {"at"}, "@")
vim.g.vcmd.set('i', "prozent", "%")
vim.g.vcmd.set('i', "und", "&")
vim.g.vcmd.set('a', {"slash", "flash"}, "/")
vim.g.vcmd.set('a', "frage", "?")
vim.g.vcmd.set('i', "oder", "|")
vim.g.vcmd.set('i', 'komma', ',')
vim.g.vcmd.set('i', 'semikolon', ';')
vim.g.vcmd.set('i', {'punkt', '.'}, '.')
vim.g.vcmd.set('a', {'doppel', "opel", "apple"}, ':')
vim.g.vcmd.set('i', {'strich', 'ich'}, "-")
vim.g.vcmd.set('a', {"base"}, "_")
vim.g.vcmd.set('i', "raute", "#")
vim.g.vcmd.set('i', {"einzel", "eifel", "einfällt", "einzeln"}, "'")
vim.g.vcmd.set('i', "stern", "*")
vim.g.vcmd.set('i', {"kleiner"}, "<")
vim.g.vcmd.set('i', {"größer", "häuser"}, ">")

vim.g.vcmd.set('a', {'leer', 'der', 'lea'}, ' ')
vim.g.vcmd.set('a', {'enter', 'alter'}, '<cr>')

vim.g.vcmd.set('i', {'klammer', 'klammern'}, '(')
vim.g.vcmd.set('i', {'klammer auf', 'klammern auf'}, '(')
vim.g.vcmd.set('i', {'klammer zu', 'klammern zu'}, ')')
vim.g.vcmd.set('i', {'geschwungene klammer', 'geschwungene klammern'}, '{')
vim.g.vcmd.set(
    'i', {'geschwungene klammer auf', 'geschwungene klammern auf'}, '{')
vim.g.vcmd.set(
    'i', {'geschwungene klammer zu', 'geschwungene klammern zu'}, '}')
vim.g.vcmd.set('i', {'eckige klammer', 'eckige klammern'}, '[')
vim.g.vcmd.set('i', {'eckige klammer auf', 'eckige klammern auf'}, '[')
vim.g.vcmd.set('i', {'eckige klammer zu', 'eckige klammern zu'}, ']')


local cmp = require 'cmp'
local vorschlag_str = ''
for i = 1, 10 do
    vorschlag_str = vorschlag_str..'<tab>'
    vim.g.vcmd.set('i', {'vorschlag '..i}, vorschlag_str.."<cr><esc><esc>")
end


for i = 1, 9 do
    vim.g.vcmd.set({'n', 'v'}, {'datei '..i, 'teil '..i, 'partei '..i}, "g"..i)
end
--
vim.g.vcmd.set({'n', 'v'}, {'close', 'klaus', 'los'}, ':q<cr>')
vim.g.vcmd.set({'n', 'v'}, {'safe', 'face'}, ':w<cr>')
vim.g.vcmd.set({'n', 'v'}, {'open', 'ofen'}, 'o')


vim.g.vcmd.set('a', {'fertig', 'serbisch'}, "<esc><esc>") -- send twice so there is no delay

-- Navigation
vim.g.vcmd.set({'n', 'v'}, {'hoch', 'auch'}, 'k')
vim.g.vcmd.set('i', 'hoch', '<up>')
vim.g.vcmd.set({'n', 'v'}, {'runter', 'unter', 'und der'}, 'j')
vim.g.vcmd.set('i', {'runter', 'unter', 'und der'}, '<down>')
vim.g.vcmd.set({'n', 'v'}, 'anfang', 'gg')
vim.g.vcmd.set({'n', 'v'}, {'ende', 'ente'}, 'G')
vim.g.vcmd.set({'n', 'v'}, 'links', 'h')
vim.g.vcmd.set('i', 'links', '<left>')
vim.g.vcmd.set({'n', 'v'}, {'rechts', 'uhr'}, 'l')
vim.g.vcmd.set('i', {'rechts', 'uhr'}, '<right>')

vim.g.vcmd.set('n', 'springe', ' gd')
vim.g.vcmd.set('n', {'umbenenne', 'umbenennen'}, ' rn')

vim.g.vcmd.set('n', 'zurück', '<C-o>')
vim.g.vcmd.set('n', 'vorwärts', '<C-i>')

-- Visual mode
vim.g.vcmd.set({'n', 'v'}, 'stift', 'v')
vim.g.vcmd.set({'n', 'v'}, {'line', 'nein'}, 'V')
vim.g.vcmd.set({'n', 'v'}, 'tafel', '<C-v>')
vim.g.vcmd.set({'n', 'v'}, 'alles', '<leader>a')
vim.g.vcmd.set({'n', 'v'}, {'spot', 'swat', 'sport', 'sports', 'ott', 'scot', 'scott', 'what'}, 'c')

-- Navigation
vim.g.vcmd.set({'n', 'v'}, {'gestern', 'esther'}, 'b')
vim.g.vcmd.set({'n', 'v'}, {'nacht', 'nachts', 'macht'}, 'ge')
vim.g.vcmd.set({'n', 'v'}, {'heute'}, 'w')
vim.g.vcmd.set({'n', 'v'}, {'morgen'}, 'e')
vim.g.vcmd.set({'n', 'v'}, {'past', 'post', 'hast', 'passt', 'pass'}, 'B')
vim.g.vcmd.set({'n', 'v'}, {'future', 'teacher'}, 'E')
vim.g.vcmd.set({'n', 'v'}, {'start', 'stadt'}, 'g0')
vim.g.vcmd.set({'n', 'v'}, {'mitte', 'bitte'}, 'gM')
vim.g.vcmd.set({'n', 'v'}, {'stop'}, '$')


-- Start insertion
vim.g.vcmd.set('n', {'schreibe', 'schreiben'}, 'a')
vim.g.vcmd.set('v', {'schreibe', 'schreiben'}, 'A')
vim.g.vcmd.set({'n', 'v'}, {'papa'}, 'A')
vim.g.vcmd.set('n', {'tipp', 'tippe', 'tippen'}, 'i')
vim.g.vcmd.set('v', {'tipp', 'tippe', 'tippen'}, 'I')
vim.g.vcmd.set({'n', 'v'}, {'mama'}, 'I')

-- General
vim.g.vcmd.set({'n', 'v'}, {'bin'}, 'd')
vim.g.vcmd.set('i', {'bin'}, '<del>')
vim.g.vcmd.set({'i', 'n', 'v'}, {'weg', 'weck'}, '<bs>')
vim.g.vcmd.set({'n', 'v'}, {'schere', 'scherer', 'cher', 'shell'}, 's')
vim.g.vcmd.set({'n', 'v'}, {'ersetze', 'ersetzen'}, 'r')
vim.g.vcmd.set({'n', 'v'}, {'kopiere', 'kopieren', 'kopierer', 'computer', 'gyros', 'fabian'}, 'y')

vim.g.vcmd.set({'n', 'v'}, {'vorher'}, 'u')
vim.g.vcmd.set({'n', 'v'}, {'nachher'}, '<C-R>')
vim.g.vcmd.set({'n', 'v'}, {'wiederhole'}, ';')

vim.g.vcmd.set({'n', 'v'}, {'rein', 'rhein'}, 'p')
vim.g.vcmd.set({'n', 'v'}, 'raus', 'P')
vim.g.vcmd.set({'n', 'v'}, 'einfügen', '<C-p>')

vim.g.vcmd.set({'n', 'v'}, {'einrücken', 'ein rücken'}, '>>')
vim.g.vcmd.set({'n', 'v'}, {'ausrücken', 'aus rücken', 'ausdrücken', 'ausdrucken'}, '<lt><lt>')

vim.g.vcmd.set({'n', 'v'}, {'runter rücken', 'unter rücken'}, 'J')
vim.g.vcmd.set({'n', 'v'}, {'hoch rücken', 'hoch wecken', 'hoch hocken', 'hoch gucken', 'kochen'}, 'K')


-- Window navigation
vim.g.vcmd.set({'n', 'v'}, 'fenster links', '<C-W>h')
vim.g.vcmd.set({'n', 'v'}, 'fenster unten', '<C-W>j')
vim.g.vcmd.set({'n', 'v'}, 'fenster oben', '<C-W>k')
vim.g.vcmd.set({'n', 'v'}, {'fenster rechts', "fenster reicht's", 'pizza rechts'}, '<C-W>l')


-- commands
vim.g.vcmd.set({'n', 'v'}, {'explorer', 'explore'}, "<leader>e")
