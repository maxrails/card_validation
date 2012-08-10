require 'spec_helper'

describe CardValidation do
  before do
    @card_array = %w{ 4111111111111111 4111111111111 4012888888881881 378282246310005
    6011111111111117 5105105105105100 }
    @card_array << '5105 1051 0510 5106'
    @card_array << 9111111111111111
    @card_array << ''
    @card_array << 'letters instead of numbers'
    @card_array << '~! @#$%^&*()""][]/\/'
    @card_array << 'l4e1t1t1e1r1s1  1 i1n1s1t1e1a1d    $##@   o1f n1umbers'
    # this case should work - because we've got correct numbers in string - so why not'

    @responces = ['VISA: 4111111111111111 (valid)', 'VISA: 4111111111111 (invalid)', 'VISA: 4012888888881881 (valid)', 'AMEX: 378282246310005 (valid)', 'Discover: 6011111111111117 (valid)', 'MasterCard: 5105105105105100 (valid)', 'MasterCard: 5105105105105106 (invalid)', 'Unknown: 9111111111111111 (invalid)', 'Please input card number', 'Card number must consist of numbers', 'Card number must consist of numbers', 'VISA: 4111111111111111 (valid)']
  end

  it 'should correct validate card number' do
    @card_array.each_with_index do |card_number, index|
      CardValidation.valid?(card_number).should == @responces[index]
    end
  end
end
