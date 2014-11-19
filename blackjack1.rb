def num_is_float?(num_string)
  !(num_string !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/)
end

def num_is_123?(num)
  num == 1 || num == 2 || num == 3
end

def set_active_hands(hands_arr, user_hands_request)
  for i in 1..3
    hands_arr.delete(i) if i > user_hands_request
  end
end

def say(string)
  puts "==> #{string}"
end

def num_is_mult_of_10?(num)
  num % 10  == 0
end

def num_at_least_100?(num)
  num > 99
end

def current_count (array)
  array.inject(:+)
end

def reshuffle_shoe_with_decks (shoe, num)
  shoe.each_key do |k|
    shoe[k][0] = num
  end
end

def get_one_card_from_shoe (shoe)
  next_card = []

  begin
    key = shoe.keys.sample
  end until shoe[key][0] >

  shoe[key][0] -= 1

  return next_card.push(shoe[key][1]).push(shoe[key][2])
end

def natural_blackjack?(hand, counts)
  (hand.count == 2) & (counts.max == 21)
end

def set_cards_to_blank(arr)
  for i in 1..8
    arr[i] = "  "
  end
end

def set_active_cards_for_printing(arr1, arr2)
  for i in 1..8
    arr1[i] = arr2[i-1].join() if !(arr2[i-1] == nil)
  end
end

def get_current_count(hand, value_key)
  counts = []
  count1 = 0
  count2 = 0

  hand.each do |x|
    count1 += value_key["#{x[0]}"]
  end
  counts[0] = count1

  if hand.flatten.include?("1")
    count2 = count1 + 10 if count1 < 12
    counts[1] = count2
  end

  return counts
end

def get_user_hand_options(user_hand_count, dealer_count, user_hand, dealer_hand)
  moves = []
  if (user_hand_count[0] < 21)
    if (dealer_hand[0][0]== "1") & (dealer_hand.count == 2)
      moves.push("H").push("S").push("SU")
    # elsif (user_hand[0][0] == user_hand[1][0]) & (user_hand.count == 2)
    #   moves.push("SP").push("H").push("S")
    else
      moves.push("H").push("S")
    end
    moves.push("DD") if (((user_hand_count[0] == 10) || (user_hand_count[0] == 11)) & (user_hand.count == 2))
  end
  return moves
end

def print_table(user_hands, dealer_hand, bank, chip_count, bets, min_bet, max_bet, active_hands, card_values, reveal_card)
  dcount, hand1_count, hand2_count, hand3_count = Array.new(4) { [] }
  dcount = get_current_count(dealer_hand, card_values) if reveal_card
  small = true
  small = false if (dcount[0].to_i > 16) & (dcount[0].to_i < 22)
  large = false
  large = true if (dcount[1].to_i > 16) & (dcount[1].to_i < 22)
  hand1_count = get_current_count(user_hands[1], card_values)
  hand2_count = get_current_count(user_hands[2], card_values)
  hand3_count = get_current_count(user_hands[3], card_values)

  h1_cards, h2_cards, h3_cards, d_cards = Array.new(4) { [] }
  set_cards_to_blank(h1_cards)
  set_active_cards_for_printing(h1_cards,user_hands[1])

  set_cards_to_blank(h2_cards)
  set_active_cards_for_printing(h2_cards,user_hands[2])

  set_cards_to_blank(h3_cards)
  set_active_cards_for_printing(h3_cards,user_hands[3])

  set_cards_to_blank(d_cards)
  set_active_cards_for_printing(d_cards, dealer_hand)

  d_cards[2] = "[?]" if !reveal_card
  d_cards[2] = dealer_hand[1].join if reveal_card

  sleep 0.25
  system("clear")
  puts
  puts "#-------------------------------------------------------------------------------#"
  puts "#                  ** 6-DECK BLACKJACK - TEALEAF ACADEMY v1.0 **                #"
  puts "#                     --------------------------------------                    #"
  puts "#                 Min Bet:  $#{min_bet}                       Bank:  $#{bank}              #"
  puts "                  Max Bet:  $#{max_bet}                    Player:  $#{chip_count} "
  puts "                                    ** dealer **                                 "
  puts "                                      #{d_cards[1]}#{:- if !(d_cards[2] == "  ")}#{d_cards[2]}                  "
  puts "                                      #{d_cards[3]}#{:- if !(d_cards[4] == "  ")}#{d_cards[4]}                  "
  puts "                                      #{d_cards[5]}#{:- if !(d_cards[6] == "  ")}#{d_cards[6]}                  "
  puts "                                      #{d_cards[7]}#{:- if !(d_cards[8] == "  ")}#{d_cards[8]}                  "
  puts "                                   --------------                   "
  puts "                            Count => #{dcount[0] if !large & reveal_card}  #{:or if small & reveal_card & !large} #{dcount[1] if reveal_card & small}     "
  puts "#                                                                               #"
  puts "#                                                                               #"
  puts "#                                                                               #"
  puts "   Bets =>  #{bets[1]}                         #{bets[2]}                         #{bets[3]}           " #bet line
  puts "#       * hand-1 *                  * hand-2 *                 * hand-3 *       #"
  puts "#                                                                               #"
  puts "          #{h1_cards[1]}#{:- if !(h1_cards[2] == "  ")}#{h1_cards[2]}  \
                    #{h2_cards[1]}#{:- if !(h2_cards[2] == "  ")}#{h2_cards[2]}  \
                    #{h3_cards[1]}#{:- if !(h3_cards[2] == "  ")}#{h3_cards[2]}   "
  puts "          #{h1_cards[3]}#{:- if !(h1_cards[4] == "  ")}#{h1_cards[4]}  \
                    #{h2_cards[3]}#{:- if !(h2_cards[4] == "  ")}#{h2_cards[4]}   \
                    #{h3_cards[3]}#{:- if !(h3_cards[4] == "  ")}#{h3_cards[4]}   "
  puts "          #{h1_cards[5]}#{:- if !(h1_cards[6] == "  ")}#{h1_cards[6]}    \
                    #{h2_cards[5]}#{:- if !(h2_cards[6] == "  ")}#{h2_cards[6]}    \
                    #{h3_cards[5]}#{:- if !(h3_cards[6] == "  ")}#{h3_cards[6]}   "
  puts "          #{h1_cards[7]}#{:- if !(h1_cards[8] == "  ")}#{h1_cards[8]}    \
                    #{h2_cards[7]}#{:- if !(h2_cards[8] == "  ")}#{h2_cards[8]}   \
                    #{h3_cards[7]}#{:- if !(h3_cards[8] == "  ")}#{h3_cards[8]}   "
  puts "#        ----------                 ----------                 ----------       #"
  puts "#                                                                               #"
  puts " Counts =>  #{hand1_count[0]} #{:or if !(hand1_count[1].nil?)} #{hand1_count[1] if !(hand1_count[1] == 0)} \
                    #{hand2_count[0]} #{:or if !(hand2_count[1].nil?)} #{hand2_count[1] if !(hand2_count[1] == 0)}  \
                    #{hand3_count[0]} #{:or if !(hand3_count[1].nil?)} #{hand3_count[1] if !(hand3_count[1] == 0)}    " #count line
  puts "#-------------------------------------------------------------------------------#"
end

card_values = {"1" => 1, "2" => 2, "3" => 3, "4" => 4, \
                    "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, \
                    "10" => 10, "J" => 10, "Q" => 10, "K" => 10}

suits = ["s", "h", "c", "d"]

deck = {}
shoe = {}

bank_chip_count = 9000
user_chip_count = 0
max_bet = 250
min_bet = 10
# hands_played = 0

card_values.each_key do |k|
  suits.each do |y|
    deck[k+y] = [1, k, y]
  end
end

shoe = deck

begin
  # insurance_paid = [false, false, false]
  reveal_hand = false
  dealer_hand = []
  user_hands = {1 => [], 2 => [], 3 => []}
  active_hands = [1, 2, 3]
  bet_tracker = {1 => 0, 2 => 0, 3 => 0}
  counts_tracker = {1 => [], 2 => [], 3 => []}
  dealer_count = []
  user_hand_options =[]

  reshuffle_shoe_with_decks(shoe, 6)
  print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)

  #get initial or add to user chip count
  if (user_chip_count < 100)
    say "Your current chip count is: #{user_chip_count}."
    begin
      say "Please enter the amount you want to add to your chip count (multiples of 10 only and total must exceed 100)"
      additional_chips = gets.chomp
    end until num_is_float?(additional_chips) & num_is_mult_of_10?(additional_chips.to_i) & num_at_least_100?(additional_chips.to_i + user_chip_count)
    user_chip_count += additional_chips.to_i
  end

  print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)

  begin
    say "You can play up to 3 hands.  How many hands would you like to play? Enter 1, 2, or 3 only"
    user_hands_select = gets.chomp
  end until num_is_123?(user_hands_select.to_i) & num_is_float?(user_hands_select)
  set_active_hands(active_hands, user_hands_select.to_i)

  #take initial bets
  active_hands.each do |x|
    begin
      say "Current chip count: #{user_chip_count}"
      say "Please enter your bet for hand ##{x} (min: #{min_bet}, max: #{max_bet}, must be multiple of 10):"
      user_next_bet = gets.chomp
    end until ((user_next_bet.to_i < user_chip_count) & num_is_float?(user_next_bet) & num_is_mult_of_10?(user_next_bet.to_i)) & (user_next_bet.to_i <= max_bet) & (user_next_bet.to_i >= min_bet)
    user_chip_count -= user_next_bet.to_i
    bet_tracker[x] = user_next_bet.to_i
    print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
  end

  #deal initial cards
  2.times {
    active_hands.each do |x|
      user_hands[x].push(get_one_card_from_shoe(shoe))
    end
    dealer_hand.push(get_one_card_from_shoe(shoe))
  }

  #get starting counts
  dealer_count = get_current_count(dealer_hand, card_values)
  active_hands.each {|x| counts_tracker[x] = get_current_count(user_hands[x], card_values)}

  #get all user moves for each hand
  active_hands.each do |x|
      #if dealer 21
      begin #go until hand is over
        user_hand_options = get_user_hand_options(counts_tracker[x], dealer_count, user_hands[x], dealer_hand)
        print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
        counts_tracker[x] = get_current_count(user_hands[x], card_values)
        if !user_hand_options.empty?
          begin
            say "Hand ##{x} has a current count of #{counts_tracker[x]}.  You may select only the following: "
            say "#{user_hand_options}"
            user_move = gets.chomp.upcase
          end until user_hand_options.include?(user_move)
        else
          next
        end
        print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)

        case user_move
        when "S"
          next
        when "H"
          user_hands[x].push(get_one_card_from_shoe(shoe))
          counts_tracker[x] = get_current_count(user_hands[x], card_values)
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
        when "DD"
          begin
            say "Current chip count: #{user_chip_count}"
            say "Please enter your double down bet for hand ##{x} (min: #{min_bet}, max: #{bet_tracker[x]}, must be multiple of 10):"
            user_next_bet = gets.chomp
          end until (user_next_bet.to_i < user_chip_count) & num_is_float?(user_next_bet) & num_is_mult_of_10?(user_next_bet.to_i) & (user_next_bet.to_i <= bet_tracker[x]) & (user_next_bet.to_i >= min_bet)
          user_chip_count -= user_next_bet.to_i
          bet_tracker[x] += user_next_bet.to_i
          user_hands[x].push(get_one_card_from_shoe(shoe))
          counts_tracker[x] = get_current_count(user_hands[x], card_values)
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
        # when "I"
        #   say "$5 Insurance charged."
        #   bank_chip_count += 5
        #   user_chip_count -= 5
        #   insurance_paid[x-1] = true
        when "SU"
          user_chip_count -= bet_tracker[x] * 0.5
          bank_chip_count += bet_tracker[x] * 0.5
          bet_tracker[x] = 0
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
          active_hands.delete(x)
        else
          say "NOT CAUGHT CASE STATEMENT: FIX THIS SHIT"
          exit
        end

        #check busted hands
        if (counts_tracker[x][0].to_i > 21)
          bank_chip_count += bet_tracker[x]
          bet_tracker[x] = 0
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
          say "Hand #{x} busted.  You lost the hand."
          sleep 2.5
        elsif natural_blackjack?(user_hands[x], counts_tracker[x])
          if natural_blackjack?(dealer_hand, dealer_count)
            user_chip_count += bet_tracker[x]
            bet_tracker[x] = 0
            print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
            say "Both hand #{x} and dealer hand are natural blackjacks. You tie."
          else
            user_chip_count += (bet_tracker[x] * 2.5)
            bank_chip_count -= (bet_tracker[x] * 1.5)
            bet_tracker[x] = 0
            print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
            say "Hand #{x} is natural blackjack. Dealer is #{dealer_count_used}.  You won this hand."
          end
          sleep 2.5
          active_hands.delete(x)
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
        end
      sleep 1.0
      end until user_hand_options.empty? || user_move != "H"
  end #do loop


  #reveal dealer hand here *******************
  reveal_hand = true
  sleep 0.5

  #dealer hand updates
  if ((dealer_count[1].to_i > 16) || (dealer_count[0].to_i > 16)) &  !(dealer_hand.flatten.include?("1") & (dealer_hand.count == 2))
    sleep 0.5
    print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
  else
    begin
      dealer_hand.push(get_one_card_from_shoe(shoe))
      dealer_count = get_current_count(dealer_hand, card_values)
      sleep 0.5
      print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
    end until ((dealer_count[1].to_i > 16) || (dealer_count[0].to_i > 16)) & ( !(dealer_hand.flatten.include?("1") & (dealer_hand.count == 2)) || dealer_hand.count >2)
  end

  dealer_count = get_current_count(dealer_hand, card_values)
  dealer_count_used = dealer_count[1]
  dealer_count_used = dealer_count[0] if (dealer_count[1].to_i > 21) || (dealer_count[1].to_i == 0)

  #DO status checks for win lose tie
  active_hands.each do |x|
    user_count_used = counts_tracker[x][1]
    user_count_used = counts_tracker[x][0] if (counts_tracker[x][1].to_i > 21) || (counts_tracker[x][1].to_i == 0)

    begin
      if dealer_count_used > 21
        user_chip_count += (bet_tracker[x] * 2)
        bank_chip_count -= bet_tracker[x]
        bet_tracker[x] = 0
        print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
        say "Dealer busted.  You won hand ##{x}"
      else
        if natural_blackjack?(dealer_hand, dealer_count)
          bank_chip_count += bet_tracker[x]
          bet_tracker[x] = 0
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
          say "Dealer has natural blackjack.  Hand #{x} is #{user_count_used}.  You lost hand ##{x}."
        elsif (counts_tracker[x][0] > 21)
          bank_chip_count += bet_tracker[x]
          bet_tracker[x] = 0
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
          say "Hand #{x} busted.  You lost hand ##{x}."
        elsif (user_count_used > dealer_count_used) & (user_count_used < 22)
          user_chip_count += (bet_tracker[x] * 2)
          bank_chip_count -= bet_tracker[x]
          bet_tracker[x] = 0
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
          say "Hand #{x} count is #{user_count_used}. Dealer count is #{dealer_count_used}.  You won hand ##{x}."
        else
          bank_chip_count += bet_tracker[x]
          bet_tracker[x] = 0
          print_table(user_hands, dealer_hand, bank_chip_count, user_chip_count, bet_tracker, min_bet, max_bet, active_hands, card_values, reveal_hand)
          say "Hand #{x} count is #{user_count_used}. Dealer count is #{dealer_count_used}.  You lost hand ##{x}."
        end
      end

      say "Enter any key to move to next hand"
      input = gets.chomp
    end until !input.nil?
  end

  say "Your current chip count: #{user_chip_count}"
  say "Do you want to play more hands? y/n"
  play_again = gets.chomp
end until play_again != "y"


