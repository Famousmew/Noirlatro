local function get_rank(hand, rank)
local found = {}
for i = 1, #hand do
if hand[i].base.value == rank then
found[#found + 1] = hand[i]
end
end
return found
end

SMODS.PokerHand{
key = 'debut',
chips = 100,
mult = 15,
l_chips = 30,
l_mult = 3,
example = {
{ 'S_2', true }, { 'D_2', true },
{ 'H_3', true }, { 'C_3', true },
{ 'S_A', true }
},
loc_txt = {
name = 'Debut',
description = { 'Two 2s, Two 3s, and one Ace' }
},
evaluate = function(parts, hand)
local twos = get_rank(hand, '2')
local threes = get_rank(hand, '3')
local aces = get_rank(hand, 'Ace')
if #twos >= 2 and #threes >= 2 and #aces >= 1 then
return {{twos[1], twos[2], threes[1], threes[2], aces[1]}}
end
end
}

SMODS.PokerHand{
key = 'flush_debut',
chips = 250,
mult = 30,
l_chips = 50,
l_mult = 5,
example = {
{ 'S_2', true }, { 'S_2', true },
{ 'S_3', true }, { 'S_3', true },
{ 'S_A', true }
},
loc_txt = {
name = 'Flush Debut',
description = { 'Two 2s, Two 3s, and one Ace of the same suit' }
},
evaluate = function(parts, hand)
if #parts._flush == 0 then return end
local twos = get_rank(hand, '2')
local threes = get_rank(hand, '3')
local aces = get_rank(hand, 'Ace')
if #twos >= 2 and #threes >= 2 and #aces >= 1 then
local combined = {twos[1], twos[2], threes[1], threes[2], aces[1]}
local suit = combined[1].base.suit
for i = 2, #combined do
if combined[i].base.suit ~= suit then return end
end
return {combined}
end
end
}