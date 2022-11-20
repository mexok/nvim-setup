--
vim.g.vcmd.set({'n', 'v'}, 'schließen', ':wq<cr>')
vim.g.vcmd.set({'n', 'v'}, {'speicher', 'speichern'}, ':w<cr>')
vim.g.vcmd.set({'n', 'v'}, 'öffnen', 'o')

-- Navigation
vim.g.vcmd.set({'n', 'v'}, 'hoch', 'k')
vim.g.vcmd.set({'n', 'v'}, {'runter', 'unter', 'und der'}, 'j')
vim.g.vcmd.set({'n', 'v'}, 'links', 'h')
vim.g.vcmd.set({'n', 'v'}, {'rechts', 'uhr'}, 'l')

vim.g.vcmd.set('n', 'springe rein', ' gd')
vim.g.vcmd.set('n', {'umbenenne', 'umbenennen'}, ' rn')

vim.g.vcmd.set('n', 'springe zurück', '<C-o>')
vim.g.vcmd.set('n', 'springe vorwärts', '<C-i>')

-- Visual mode
function set_visual_cmd(words, base_command)
    vim.g.vcmd.set({'n', 'v'}, words, base_command)
    vim.g.vcmd.set('i', words, '<esc>'..base_command)
end
set_visual_cmd('markiere', 'v')
set_visual_cmd('markieren', 'v')
set_visual_cmd('markiere zeile', 'V')
set_visual_cmd('markiere blog', '<C-v>')
set_visual_cmd('markiere wort', 'viw')
set_visual_cmd('markiere wutz', 'viw')
set_visual_cmd('markiere watz', 'viw')


-- Start insertion
vim.g.vcmd.set('n', 'hinten schreiben', 'A')
vim.g.vcmd.set('n', 'vorne schreiben', 'I')
vim.g.vcmd.set('n', 'danach schreiben', 'a')
vim.g.vcmd.set('n', 'darüber schreiben', 'O')
vim.g.vcmd.set('n', 'darunter schreiben', 'o')
vim.g.vcmd.set('n', {'schreibe', 'schreiben'}, 'i')


-- General
vim.g.vcmd.set({'n', 'v'}, {'lösche', 'löschen'}, 'd')
vim.g.vcmd.set('n', 'lösche wort', 'diw')
vim.g.vcmd.set('n', 'lösche zeile', 'dd')
vim.g.vcmd.set({'n', 'v'}, {'entferne', 'entfernen'}, 'c')
vim.g.vcmd.set('n', 'entferne wort', 'ciw')
vim.g.vcmd.set({'n', 'v'}, {'ersetze', 'ersetzen'}, 's')
vim.g.vcmd.set('n', {'wort ersetzen', 'wurz ersetzen'}, 'viwp')

vim.g.vcmd.set({'n', 'v'}, {'kopiere', 'kopieren'}, 'y')
vim.g.vcmd.set('n', {'kopiere wort', 'kopierer wort', 'kopierer wutz'}, 'yiw')
vim.g.vcmd.set('n', {'kopiere zeile', 'kopierer zeile'}, 'yy')
vim.g.vcmd.set({'n', 'v'}, 'noch mal', '.')
vim.g.vcmd.set('a', 'fertig', '<esc>')

vim.g.vcmd.set({'n', 'v'}, 'davor einfügen', 'P')
vim.g.vcmd.set({'n', 'v'}, 'einfügen', 'p')

vim.g.vcmd.set({'n', 'v'}, {'einrücken', 'ein rücken'}, '>>')
vim.g.vcmd.set({'n', 'v'}, {'ausrücken', 'aus rücken', 'ausdrücken', 'ausdrucken'}, '<lt><lt>')

-- Insert mode - Special chars
vim.g.vcmd.set('i', 'doppel', ':')
vim.g.vcmd.set('i', 'komma', ',')
vim.g.vcmd.set('i', 'semikolon', ';')
vim.g.vcmd.set('i', 'punkt', '.')
vim.g.vcmd.set('i', 'unterstrich', '_')
vim.g.vcmd.set('i', 'bindestrich', '-')

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


-- Insert mode - Words

local words = {
    wenn='if', dann='else', service='service', händler='handler'
}


-- Insert mode - Chars
local chars = {
    anton='a', blau='b', chor='c', dora='d', emil='e', emir='e', friedrich='f',
    gustav='g', heinrich='h', ida='i', julius='j', konrad='k', ludwig='l',
    martha='m', nordpol='n', otto='o', paula='p', quelle='q', richard='r',
    siegfried='s', theodor='t', ulrich='u', viktor='v', wilhelm='w', xaver='x',
    y='y', yipsilyon='y', zeppelin='z'
}

all = {}
table.move(words, 1, #words, #all + 1, all)
table.move(chars, 1, #chars, #all + 1, all)

for word, mapping in pairs(all) do
    vim.g.vcmd.set('i', word, char)
    vim.g.vcmd.set('i', "groß"..word, string.upper(char))
    vim.g.vcmd.set('i', "große"..word, string.upper(char))
    vim.g.vcmd.set('i', "großes"..word, string.upper(char))
    vim.g.vcmd.set('i', "großer"..word, string.upper(char))
end
