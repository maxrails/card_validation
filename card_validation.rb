class CardValidation
  class << self

    def valid? card=nil
      return 'Please input card number' if card.to_s.empty?
      card = card.to_s.gsub /[^0-9]/, ''
      if card.to_i != 0
        digit_array = card.split ''
        card_type   = card_type_detect card.to_s[0..3], digit_array.length
        test_digits = []
        digit_array.reverse.each_with_index do |digit, index|
          number      = (index+1).even? ? digit.to_i*2 : digit.to_i
          test_digits << ( number > 9 ? number - 9 : number )
        end
        test_digits = test_digits.inject(:+)
        "#{card_type}: #{card} (#{test_digits % 10 == 0 ? 'valid' : 'invalid'})"
      else
        'Card number must consist of numbers'
      end
    end

    def card_type_detect first_digits, length
       result = case length
       when 15
         'AMEX' if first_digits[0..1].to_i == 34 || first_digits[0..1].to_i == 37
       when 16
         if first_digits.to_i == 6011
           'Discover'
         elsif (51..55).include?(first_digits[0..1].to_i)
           'MasterCard'
         elsif 4 == first_digits[0].to_i
           'VISA'
         end
       when 13
         'VISA' if 4 == first_digits[0].to_i
       end
       result ||= 'Unknown'
    end

  end
end    
