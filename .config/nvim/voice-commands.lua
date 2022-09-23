-- Navigation
vim.g.vcmd.set({'n', 'v'}, 'hoch', 'k')
vim.g.vcmd.set({'n', 'v'}, 'runter', 'j')
vim.g.vcmd.set({'n', 'v'}, 'links', 'h')
vim.g.vcmd.set({'n', 'v'}, 'rechts', 'l')

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

-- Start insertion
vim.g.vcmd.set({'n', 'v'}, 'hinten einfügen', 'A')
vim.g.vcmd.set({'n', 'v'}, 'vorne einfügen', 'I')
vim.g.vcmd.set({'n', 'v'}, 'danach einfügen', 'a')
vim.g.vcmd.set({'n', 'v'}, 'darüber einfügen', 'O')
vim.g.vcmd.set({'n', 'v'}, 'darunter einfügen', 'o')
vim.g.vcmd.set({'n', 'v'}, 'einfügen', 'i')

-- General
vim.g.vcmd.set({'n', 'v'}, {'lösche', 'löschen'}, 'd')
vim.g.vcmd.set({'n', 'v'}, 'lösche wort', 'diw')
vim.g.vcmd.set({'n', 'v'}, {'entferne', 'entfernen'}, 'c')
vim.g.vcmd.set({'n', 'v'}, 'entferne wort', 'ciw')

vim.g.vcmd.set({'n', 'v'}, {'kopiere', 'kopieren'}, 'y')
vim.g.vcmd.set({'n', 'v'}, 'noch mal', '.')
vim.g.vcmd.set('a', 'fertig', '<esc>')


-- Insert mode - Special chars
vim.g.vcmd.set('i', 'doppel', ':')
vim.g.vcmd.set('i', 'komma', ',')
vim.g.vcmd.set('i', 'semikolon', ';')
vim.g.vcmd.set('i', 'punkt', '.')

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

-- Insert mode - Chars
local chars = {
    anton='a', blau='b', chor='c', dora='d', emil='e', emir='e', friedrich='f',
    gustav='g', heinrich='h', ida='i', julius='j', konrad='k', ludwig='l',
    martha='m', nordpol='n', otto='o', paula='p', quelle='q', richard='r',
    siegfried='s', theodor='t', ulrich='u', viktor='v', wilhelm='w', xaver='x',
    y='y', yipsilyon='y', zeppelin='z'
}
for word, char in pairs(chars) do
    vim.g.vcmd.set('i', word, char)
    vim.g.vcmd.set('i', "groß"..word, string.upper(char))
    vim.g.vcmd.set('i', "große"..word, string.upper(char))
    vim.g.vcmd.set('i', "großes"..word, string.upper(char))
    vim.g.vcmd.set('i', "großer"..word, string.upper(char))
end

