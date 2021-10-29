

class VerifyCheckSum

  def initialize(account_numbers)
    @account_numbers = account_numbers
  end

  # def verify_all
  #   for number in @account_numbers do
  #     verify(number.to_i)
  #   end
  # end
  def verify(number)
    sum = 0
    (number.digits.length - 1).downto(0) do |i|
      sum = sum + number.digits[i] * i
    end
    
    if sum % 11 != 0 then
      false
    else
      true
    end
  end
  
end