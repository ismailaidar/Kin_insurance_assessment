class VerifyCheckSum
  def verify(number)
    sum = 0
    (number.digits.length - 1).downto(0) do |i|
      sum = sum + number.digits[i] * i
    end
    puts ("sum is: #{sum}")
    if sum % 11 != 0 then
      false
    else
      true
    end
  end
  
end